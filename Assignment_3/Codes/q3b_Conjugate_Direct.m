 
clear all
clc
% Objective Function
obj_f=@(x) (8*x(1)^2 -6*x(1)*x(2) + 8*x(2)^2 -x(1)+x(2));
 

x0= [100;0]; % Initial guess point
T=x0;
syms x1 x2
X= [x1;x2];
grad_objF= gradient(obj_f(X),X);

S1=- vpa(subs(grad_objF,X,x0 ));

% Finding the optimal step length
syms L
x1=x0 + L*S1;
eq = diff( obj_f(x1),L) ==0;
hs = vpa(solve(eq,L)); 
% Saving only real values of step length
hs = hs( imag(hs)==0); 
hs=hs(1);

x1=x0 + hs*S1;
i=2;
x_res= [x0';x1'];
SR= [S1'];
G1= subs(grad_objF,X,x0);
G2= subs(grad_objF,X,x1);

%Saving results to an array
results=[vpa(x0') obj_f(x0) norm(G1) 0 0 0; x1' obj_f(x1) norm(G2) S1' double(hs)];

while true
    
    G2=  vpa(subs(grad_objF,X,x1)) ; %gradient of objective function at  X_i
    G1=  vpa(subs(grad_objF,X,x0)) ; %gradient of objective function at  X_i-1
    S2= -G2 + S1*(G2'*G2)/ (G1'*G1); %S_i from S_i-1
    SR= [SR; S2'];
    x2 = x1 +L*S2;
    
    f3 =obj_f(x2);
    dfl=diff(f3,L);
    hs=double(solve(dfl==0,L));
%     Saving only real values of step length
    hs = hs( imag(hs)==0);
%     Taking the index of minimum step length
    [~,index]= min(abs(hs));
%     Optimal step length
    hs=hs(index); 
    
    x2=x1 + hs*S2;
    G3=subs(grad_objF,X,x2);
    results=[results ; x2' obj_f(x2) norm(G3) S2' vpa(hs)];
    
    if(i==4)
        fprintf('Optima at the end of 4 iterations:%d',x2);
    end
    
    if abs(x2-x1)<1e-7
        optima=x2;
        iterations=i;
        fprintf('Iterations to convergence:\n');
        disp(iterations);
        fprintf('Optimum point after convergence:\n');
        disp(optima);
        break
    end
    
    %Updating variables for next iteration
    x0=x1;
    x1=x2;
    S1=S2;   
    x_res= [x_res; x2']; 
    i=i+1;
end

x_res= double(x_res);
results= double(results);
i=0:length(results(:,1))-1;
results= [i' results];
%% Plotting
clf
a = linspace(-10 ,100,1500);  
b = linspace(-10,100,1500);
[X,Y] = meshgrid(a,b);

Z =  8.*X.^2 -6.*X.*Y+8.*Y.^2-X+Y;
 
 Levels=(results(:,4))';
contour(X,Y,Z,'LevelList',[Levels 25:max(Levels)/100:max(Levels)])
colorbar('vertical')
grid on
 

xlabel("x1");
ylabel("x2");
title("Conjugate direction Method");
hold on


for i=1: length(x_res)-1
    [a,b]=return_points(x_res(i,:) ,x_res(i+1,:));
    plot(a(1),b(1),'^','MarkerSize',3,'LineWidth',2,'Color','Red')
    hold on
    line(a,b, 'LineWidth',1 ,'Color', 'Black')
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

