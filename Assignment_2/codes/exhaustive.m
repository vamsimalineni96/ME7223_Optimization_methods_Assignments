clear;clc;

a=input('Enter lower limit : \n'); 
b=input('Enter upper limit : \n');
accuracy=input('Enter the accuracy in % : \n')*0.01;
Init_len=b-a;
f=@(x)(-(.5/sqrt(1+x^2) -sqrt(1+x^2)*(1-.5/(1+x^2)) +x));

i=0;
n=( 1/( accuracy) -1 );
xs=[];
step=(b-a)/n;
% Finding the x distribution
temp=0;
for i=1:n
    temp=temp+step;
    xs=[xs;temp];
end
clear min 
clear index
y=[];
for i=1:length(xs)
    y=[y;f(xs(i))];
end
[m,ind] = min(y);
a_final=xs(ind-1);
b_final=xs(ind+1);
optimum_point=(a_final+b_final)/2;

fprintf("\nPoint of Maximum stress :%f\n",optimum_point)
fprintf("Maximum stress :%f\n",-f(optimum_point))
fprintf("Number of iterations : %d\n",n)
  