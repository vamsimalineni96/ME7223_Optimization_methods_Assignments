clear all
clc
% Objective Function
obj_f=@(x) (2*x(1)^2 +16*x(2)^2-2*x(1)*x(2)-x(1)-6*x(2)-5);

syms x1 x2
F= obj_f([x1;x2]);
X=[x1;x2];
Hess= hessian(F,X);
Gr= gradient(F,X);

% Initial point
x1= [100;0]; 
T=x1;
i=0;
x_res=[x1'];
g_r= double(subs(Gr,X,x1));
%Saving results to an array
results=[vpa(x1') obj_f(x1) norm(g_r) 0 0 0 ];
 
while true
     
     i=i+1;
     
     G1= double(subs(Gr,X,x1)); % Gradient 
     J= double(subs(Hess,X,x1)); %Hessian
     
     syms L
     S1=inv(J)*G1; %Search direction
     x2= x1 - L*S1;
     df2=diff(obj_f(x2),L);
    hs=double(solve(df2==0,L));
%     Saving only real values of step length
    hs = hs( imag(hs)==0);
%     Taking the index of minimum step length
    [~,index]= min(abs(hs));
%     Optimal Step length 
    hs=hs(index);  %Optimal step length
    
     x2= x1 - hs*S1; %Xi+1
     g_r=double(subs(Gr,X,x2));
     
    results=[results ; x2' obj_f(x2) norm(g_r) S1' double(hs)];
    x_res=[x_res; x2'];
      
%     Covergence check
     if abs(norm(x2)-norm(x1))/norm(x1)< 1e-7 
        optima= x2;
        iterations=i;
        fprintf('Iterations to convergence:\n');
        disp(iterations);
        fprintf('Optimum point after convergence:\n');
        disp(optima);
        
        break
     end
     x1=x2;
 end
 results= double(results);
 i=0:length(results(:,1))-1;
results= [i' results];
%% %% PLOT
clf
x = linspace(-10 ,100,1500);
y = linspace(-10 ,100,1500);
[X,Y] = meshgrid(x,y);

 Z =  8.*X.^2 -6.*X.*Y+8.*Y.^2-X+Y;
 
 Levels=(results(:,4))';
contour(X,Y,Z,'LevelList',[Levels 50:max(Levels)/75:max(Levels)])
  colorbar('vertical')
  grid on
 

xlabel("x1");
ylabel("x2");
title("Newton's method");
hold on


for i=1: length(x_res)-1
    [x,y]=return_points(x_res(i,:) ,x_res(i+1,:));
    plot(x(1),y(1),'^','MarkerSize',3,'LineWidth',2,'Color','Red')
    hold on
    line(x,y, 'LineWidth',1 ,'Color', 'Black')
    hold on
end
    
 plot(T(1),T(2),'o','MarkerSize',4,'LineWidth',3,'Color', 'Red')
hold on

 plot(optima(1),optima(2),'^','MarkerSize',4,'LineWidth',3,'Color',[0, 0.5, 0])
hold on
%% Function to return points
function [x,y]= return_points(X,Y)
x= [X(1) Y(1)];
y= [X(2) Y(2)];
end
