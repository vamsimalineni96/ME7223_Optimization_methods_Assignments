% For given number of experiments
clc; clear all;
a=input('Enter lower limit : \n'); 
b=input('Enter upper limit : \n');
n=input('Enter the number of experiments:\n');
a=0;b=3;
init_len=3;
f=@(x)(-(.5/sqrt(1+x^2) -sqrt(1+x^2)*(1-.5/(1+x^2)) +x));

% Developing the fibonacci series 
f_o=1;
f_n=1;
for i=1:n+1
    if i==1 || i==2
    fib_series(i)=1;
   continue;
    end
    fib_series(i)=f_o+f_n;
    f_o=f_n;
    f_n=fib_series(i);
end
% ------------------------------------------------------------------------
% Implementing the algorithm
L_s=fib_series(n-2)*init_len/fib_series(n)
iter=0;

while true
    x1=a+L_s;
    x2=b-L_s;
    fe_1=f(x1);
    fe_2=f(x2);

    if fe_2>fe_1
        b=x2;
        x=x1;
    elseif fe_2<fe_1
        a=x1;
        x=x2;
    end
    
    if x-a > b-x
        L_s=b-x;
    elseif x-a<b-x
        L_s=x-a;
    end
    
    iter=iter+1;
    if iter==n
        optimum_point=(a+b)/2;
        N_exp=n;
        l_b_f=a;
        u_b_f=b;
        break
    end
end

fprintf("\nFinal interval: (%f,%f)\n",a,b)
fprintf("Accuracy :%f\n",((b-a)/init_len));
fprintf("Point of Maximum stress :%f\n",optimum_point)
fprintf("Maximum stress :%f\n",-f(optimum_point))
    


