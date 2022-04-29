clear all
clc
% Objective Function
obj_f=@(x) (8*x(1)^2 -6*x(1)*x(2) + 8*x(2)^2 -x(1)+x(2));

syms X1 X2
X= [X1;X2];
grad= gradient(obj_f(X),X);
x0= [100;0];
T=x0;

x_res=[x0'];
g= double(subs(grad,X,x0));
% Array to collect results
results=[vpa(x0') obj_f(x0') norm(g) 0 0 0 ];

i=0;
cc=1e-5; % Convergence Criteria

while true
   i=i+1;
   syms h
   % Search direction
   S=-subs(grad,[X1;X2],x0); 
   % Optimum step length
   x1= x0 + h* S;
   eq =  diff( obj_f(x1),h);
   hs= double(solve(eq)); 
   % Next point
   x1=  double( x0- hs(1)*subs(grad,[X1;X2],x0)); 
   
   if(i==4)
        fprintf('Optimum point at the end of 4 iterations:\n');
        fprintf('\n');
        disp(x1);
   end
   
   %Convergence criteria
   if abs(norm(x1)-norm(x0))/norm(x0) < cc 
        optima= vpa(x1);
        iterations=i;
        fprintf('Iterations to convergence:\n');
        disp(iterations);
        fprintf('Optimum point after convergence:\n');
        disp(optima);
        break
   end
   
   g= norm(subs(grad,X,x1));
   x_res=[x_res;x1'];
   results= [results; x1' obj_f(x1) g S' hs(1) ];
   x0=x1;
    
end
results= double(results);
i=0:length(results(:,1))-1;
results= [i' results];
%% Plotting 
clf
x = linspace(-10 ,100,1500);
y = linspace(-10 ,100,1500);
[X,Y] = meshgrid(x,y);

 Z =  8.*X.^2 -6.*X.*Y+8.*Y.^2-X+Y;
 
Levels=(results(:,4))';
contour(X,Y,Z,'LevelList',[Levels 25:max(Levels)/100:max(Levels)])
colorbar('vertical')
grid on

xlabel("x1");
ylabel("x2");
title("Steepest descent Method");
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

 plot(.0454,-.0454,'^','MarkerSize',4,'LineWidth',3,'Color',[0, 0.5, 0])
hold on
%% Function to return points
function [x,y]= return_points(X,Y)
x= [X(1) Y(1)];
y= [X(2) Y(2)];
end

