clc
clear all
% Objective Function:
obj_f= @(x) (100.*( x(2) -x(1).^2 ).^2 +(1-x(1)).^2);

x1=[0;1];       % Initial Point
f1=obj_f(x1);   % Objective function value at initial point
eps=1e-3;       % Probe Length
cc=1e-5;        % Convergence Criteria
iter_cap=2000;   % Restricted Maximum Number of Iterations

iteration=1;

T=x1;
% Variable to store the points, the algorithm takes.
x_res=[x1'];
%Saving results to an array
results=[vpa(x1') obj_f(x1') ]; 

while true
   disp("Iteration no :"+iteration)

%Choosing the univariate direction 
    if rem(iteration,2)== 01 
        S=[1;0];
    else
        S=[0;1];
    end
%Choosing direction of S for minimizing the objective function
    if obj_f(x1-eps*S)<obj_f(x1)
        S=-S;
    end
    
% Finding the optimal step length
    clear h
    syms h
    eq=diff(obj_f(x1+h*S),h)==0;
    
% Solving the 1D optimization problem for optimal step length
    h_s= double(solve(eq)); 
%     Saving only real values of step length
    h_s = h_s( imag(h_s)==0);
%     Taking the index of minimum step length
    [~,index]= min(abs(h_s));
%     Optimal step length
    h_s=h_s(index); 
    
    x2=x1+h_s*S;
    iteration=iteration+1;
    x_res= [x_res; x2'];
 
% Convergence criteria : Difference between the points in consequent
% iterations is insignificant.

    if  abs(x1-x2)< cc  
        optima=x2;
        fprintf("Optima reached :\n")
        disp(optima)
        results= [results; optima' obj_f(optima)];
        break
    end
    
% Since the algorithm is taking large iterations to converge, 
% the number of iterations has to be restricted, for better accuracy keep 
% larger number of iterations.

    if iteration==iter_cap
        optima=x2;
        fprintf("Optima reached :\n")
        disp(optima)
        results= [results; optima' obj_f(optima)];
        break
    end
    results= [results; x2' obj_f(x2)];
    x1=x2;
    
end

results= double(results);
i=0:length(results(:,1))-1;
results= [i' results];
%% Plot
clf
a = linspace(-1 ,2,1500);
b = linspace(-1 ,2,1500);
[X,Y] = meshgrid(a,b);

Z= 100.*( Y -X.^2 ).^2 +(1-X).^2;

Levels=(results(:,4))';
contour(X,Y,Z,'LevelList',[Levels 25:max(Levels)/100:max(Levels)])
colorbar('vertical')
grid on

xlabel("x1");
ylabel("x2");
title("Univariate Method");
hold on

for i=1: length(x_res)-1
   [a,b]=return_points(x_res(i,:) ,x_res(i+1,:));
    hold on
    line(a,b, 'LineWidth',1 ,'Color', 'Black')
    hold on
end
    
lab={'Initial Point'};
plot(T(1),T(2),'o','MarkerSize',4,'LineWidth',3,'Color', 'Green')
text(T(1),T(2),lab,'VerticalAlignment','top','HorizontalAlignment','right');

hold on

lab2={'Optima'};
plot(optima(1),optima(2),'^','MarkerSize',4,'LineWidth',3,'Color','Red');
txt='\leftarrow Optimum';
t=text(optima(1),optima(2),txt);
hold on
%% Function to return points 
function [a,b]= return_points(X,Y)
a= [X(1) Y(1)];
b= [X(2) Y(2)];
end