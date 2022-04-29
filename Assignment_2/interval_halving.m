%Interval Halving Method
clc; 
clear;
accuracy=input('Enter the accuracy in % : \n')*0.01;
l_b=input('Enter lower limit : \n'); 
u_b=input('Enter upper limit : \n');

f=@(x)(-(.5/sqrt(1+x^2) -sqrt(1+x^2)*(1-.5/(1+x^2)) +x));

a=l_b;
b=u_b;
iter=-1;

x_sp=linspace(l_b, u_b,5);
f0=f(x_sp(3));
f1=f(x_sp(2)); 
f2=f(x_sp(4));

while true
    iter=iter+1;
      
    if f2< f0 & f0 < f1
            l_b=x_sp(3);
            f0=f2;
            x_sp=linspace(l_b, u_b,5)
            f1=f(x_sp(2)); f2=f(x_sp(4));
            
    elseif f2>f0 & f0 > f1
            u_b=x_sp(3);
            f0=f1;
            x_sp=linspace(l_b, u_b,5);
            f1=f(x_sp(2)); f2=f(x_sp(4));
            
    elseif f2>f0 & f1>f0
            l_b=x_sp(2); 
            u_b=x_sp(4);
            x_sp=linspace(l_b, u_b,5);
            f1=f(x_sp(2)); f2=f(x_sp(4));                   
    end

    if (u_b-l_b)/(b-a) < 2*accuracy
        opti= (u_b+ l_b)/2;
        l_b_f=l_b;
        u_b_f=u_b;
        n=3+iter*2;
        break
    end
end

fprintf("\nPoint of Maximum stress :%f\n",opti)
fprintf("Maximum stress :%f\n",-f(opti))
fprintf("Number of iterations : %d\n",n)
