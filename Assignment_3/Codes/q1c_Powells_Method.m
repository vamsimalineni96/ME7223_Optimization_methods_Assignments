clear all
clc

obj_f= @(x) (100.*( x(2) -x(1).^2 ).^2 +(1-x(1)).^2);

x1=[-0.5;0.5];   % Initial point

S1=[1;0] ;
S2=[0;1] ;  % Starting Direction

hr=[];
e=.001;     % Probe 
cc=1e-4;    % Convergence Criteria
cyc=0;
SR=[];

qa=obj_f(x1-e*S2);
qb=obj_f(x1);

if qa < qb
    S2=-S2;
end

% Finding x2
syms L
x2=x1+L*S2;
eqn= diff(obj_f(x2),L)==0;
hs= double( solve(eqn) );
hs= hs(imag(hs)==0);
hr=[hr; hs(1)];

x2=x1+hs(1)*S2
x_res=[x1'];

while true
cyc=1+cyc;
disp("Cycle "+ cyc)

% Finding x3 
if obj_f(x2-e*S1)< obj_f(x2)
    S1=-S1;
end
x_res= [x_res; x2'];

x3=x2+L*S1;
eqn= diff(obj_f(x3),L)==0;
hs= double( solve(eqn) );
hs= hs(imag(hs)==0);
hr=[hr; hs(1)];

x3=x2+hs(1)*S1

x_res= [x_res; x3'];

% Finding x4
if obj_f(x3-e*S1)< obj_f(x3)
    S1=-S1;
end

x4=x3+L*S2;
eqn= diff(obj_f(x4),L)==0;
hs= double( solve(eqn) );
hs= hs(imag(hs)==0);
hr=[hr; hs(1)];

x4=x3+hs(1)*S2

x_res= [x_res; x4'];

% Finding the Conjugate Direction
cyc=cyc+1;
disp("Cycle "+ cyc)
S_p=x4-x2;
if S_p==0
    break
end
% Finding x5
if obj_f(x4-e*S_p)< obj_f(x4)
    S_p=-S_p;
end

x5=x4+L*S_p;
eqn= diff(obj_f(x5),L)==0;
hs= double( solve(eqn) );
hs= hs(imag(hs)==0);   % Storing only the real values of step length
hr=[hr; hs(1)];

x5=x4+hs(1)*S_p

x_res= [x_res; x5'];

x2=x5;

SR=[SR; S1' S2' S_p' ];
S1=S2;
S2=S_p;

if cyc>2
    if abs(x5-x5_old) < cc
        optima=x5;
        break
    end
end

x5_old=x5;

end
%% Finding the Functional values at each point
fs=[];
for i=1:length(x_res)
fs=[fs;obj_f(x_res(i,:))];
end
%% Plot
clf
x = linspace(-1 ,2,1500);
y = linspace(-1 ,2,1500);
[X,Y] = meshgrid(x,y);
Z= 100.*( Y -X.^2 ).^2 +(1-X).^2;

 Levels=(fs(:,1))';
contour(X,Y,Z,'LevelList',[Levels 25:max(Levels)/200:max(Levels)])
  colorbar('vertical')
  grid on
xlabel("x1");
ylabel("x2");
title("Powell's Method");

hold on

for i=1: length(x_res)-1
    [x,y]=return_points(x_res(i,:) ,x_res(i+1,:));
    line(x,y, 'LineWidth',1 ,'Color', 'Black')
    hold on
end

lab={'Initial Point'};
plot(x1(1),x1(2),'o','MarkerSize',4,'LineWidth',3,'Color', 'Green')
text(x1(1),x1(2),lab,'VerticalAlignment','top','HorizontalAlignment','right');

hold on

lab2={'Optima'};
plot(optima(1),optima(2),'^','MarkerSize',4,'LineWidth',3,'Color','Red');
txt='\leftarrow Optimum (1,1)';
t=text(1,1,txt);
hold on

%% Function to return points 

function [a,b]= return_points(X,Y)
a= [X(1) Y(1)];
b= [X(2) Y(2)];
end


   