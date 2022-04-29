clear all
clc
% Objective Function
obj_f=@(x) (8*x(1)^2 -6*x(1)*x(2) + 8*x(2)^2 -x(1)+x(2));

syms x1 x2
F= obj_f([x1;x2]);
X=[x1;x2];
% Getting the Hessian and Gradient for the objective Function
hess= hessian(F,X);
grad= gradient(F,X);

% Initial Point
x0=[100;0];
T=x0;

checking=1;
alpha=1e4;
% Arbitrary constants 0<c1<1 and c2>1
c1=.5;
c2=1.5;
i=1;

x_res= [x0'];
syms h
g= subs(grad,X,x0);
%Saving results to an array
results=[vpa(x0') obj_f(x0) norm(g) 0 0 0 alpha];

while true

    if checking == 1 
        G1= subs(grad,X,x0);
        if i>1 
            if(i==5)
            fprintf('Optimum point at the end of 4 iterations:\n');
            fprintf('\n');
            disp(X2);
            end
            if  abs(G1) <1e-5
                optima=X2;
                iterations=i;
                fprintf('Iterations to convergence:\n');
                disp(iterations);
                fprintf('Optimum point after convergence:\n');
                disp(optima);
        
                break
            end
        end
    end
%    Search direction 
    S1=inv(subs(hess,X,x0)+ alpha*eye(2)) *G1; 
    
%    Finding X2 
    X2= x0 -h*S1 ;
    df2=diff(obj_f(X2),h);
    hs=double(solve(df2==0,h));
%     Saving only real values of step length
    hs = hs( imag(hs)==0);
%     Taking the index of minimum step length
    [~,index]= min(abs(hs));
%     Optimal step length
    hs=hs(index);   
    
    X2= double(x0 - hs*S1);
    g=subs(grad,X,X2);
    results=[results ; X2' obj_f(X2) norm(g) S1' double(hs) alpha]; 
        
   
    F2= obj_f(X2);
    F1= obj_f(x0);
    
    if F2>=F1
        alpha=c2*alpha;
        checking=0;
%         Going to step 7 of the algorithm
    else
        alpha=c1*alpha;
        i=i+1;
        x_res= [x_res; X2'];
        x0=X2;
        checking=1; 
%         Going to step 2 of the algorithm
    end
     
end
results= double(results); 
i=0:length(results)-1;
% indexing the results
results= [i' results];
%% Plotting
clf
x = linspace(-10,100,1500);
y = linspace(-10,100,1500);
[X,Y] = meshgrid(x,y);

 Z =  8.*X.^2 -6.*X.*Y+8.*Y.^2-X+Y;
 
 Levels=(results(:,4))';
contour(X,Y,Z,'LevelList',[Levels 25:max(Levels)/100:max(Levels)])
  colorbar('vertical')
  grid on
 

xlabel("x1");
ylabel("x2");
title("Marquardt's method");
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

