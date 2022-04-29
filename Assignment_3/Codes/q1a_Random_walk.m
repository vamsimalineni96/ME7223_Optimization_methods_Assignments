clear all
clc

% Objective Function
obj_f= @(x) (100.*( x(2) -x(1).^2 ).^2 +(1-x(1)).^2);

L=[];
e=1e-9;

x1= [0;0];  % Initial point
x_res=[x1(1),x1(2)];
T=x1;

%Saving results to an array
results=[x1' 0 ];
iterations=0;

while true
    
iterations=iterations+1
[x,Lf,u]= one_d_opti(x1);
L=[L; Lf];
x_res= [x_res;x'];
results=[results;x' obj_f(x)];

if obj_f(x)<obj_f(x1)
x1=x;   
end

if abs(Lf)<e
    clc;
    optima=x1;
    iterations;
    fprintf('Iterations to convergence:\n');
    disp(iterations);
    fprintf('Optimum point after convergence:\n');
    disp(optima);
    results=[results;optima' obj_f(optima)];
    x_res=[x_res;optima'];
    break
end

end
points=results(:,1:2);
%% PLotting
clf
x = linspace(-1 ,2,1500);
y = linspace(-1 ,2,1500);
[X,Y] = meshgrid(x,y);
Z= 100.*( Y -X.^2 ).^2 +(1-X).^2;

Levels=(results(:,3))';
contour(X,Y,Z,'LevelList',[Levels 25:max(Levels)/200:max(Levels)])
colorbar('vertical')
grid on
xlabel("x1");
ylabel("x2");
title("Random walk with direction exploitation");
hold on

for i=1: length(points)-1
    [x,y]=return_points(points(i,:) ,points(i+1,:));
    line(x,y, 'LineWidth',1 ,'Color', 'Black')
    hold on
end
    
lab={'Initial Point'};
plot(T(1),T(2),'o','MarkerSize',4,'LineWidth',3,'Color', 'Green')
text(T(1),T(2),lab,'VerticalAlignment','top','HorizontalAlignment','right');
hold on
lab2={'Optima'};
plot(optima(1),optima(2),'^','MarkerSize',4,'LineWidth',3,'Color','Red');
txt='\leftarrow Optimum (1,1)';
t=text(1,1,txt);
hold on



%% 1D Optimization

function [x,h_f,u]= one_d_opti(x1)
obj_f1= @(x) (100.*( x(2) -x(1).^2 ).^2 +(1-x(1)).^2);
u= random_gen();

syms L
x=x1 + L*u;
f1= obj_f1(x);
eqn= expand( diff(f1,L) ==0);
h_s= double(solve( eqn ));
%     Saving only real values of step length
    h_s = h_s( imag(h_s)==0);
%     Taking the index of minimum step length
    [~,index]= min(abs(h_s));
%     Optimal step length
    h_s=h_s(index);
clear x L

% L1=L_t(1);
x= x1+h_s*u;
f2=obj_f1(x);
h_f=h_s;

end
%% Random vector generation
function n= random_gen()
    while true
        r= [randi(1e5); randi(1e5)]/1e5;
        if norm(r) <=1
            s1= (-1)^randi(10);
            s2= (-1)^randi(10);
            n= [r(1)*s1; r(2)*s2]/norm(r);
            break
        end
    end
end

%% Function to return points for drawing lines
function [a,b]= return_points(X,Y)
a= [X(1) Y(1)];
b= [X(2) Y(2)];
end




    
