%  For a given % of accuracy
clc; clear all;
a=input('Enter lower limit : \n'); 
b=input('Enter upper limit : \n');
init_len=b-a;
accuracy=input('Enter the accuracy value (in %) : \n')*0.01;
f=@(x)(-(.5/sqrt(1+x^2) -sqrt(1+x^2)*(1-.5/(1+x^2)) +x));


% Finding n
i=1;j=1;
fib_series=[1;1];
while true
    temp=i+j;
    fib_series=[fib_series;temp];
    if (1/temp)<= 2*accuracy
        e=length(fib_series);
        fib_series=[fib_series;(fib_series(e-1)+fib_series(e))];
        n=length(fib_series);
        break
    end
    i=j;
    j=temp;
end
% ------------------------------------------------------------------------
L_s=fib_series(n-2)*init_len/fib_series(n);
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
    elseif x-a< b-x
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
fprintf("Number of experiments:%d\n",N_exp)
fprintf("Point of Maximum stress :%f\n",optimum_point)
fprintf("Maximum stress :%f\n",-f((a+b)*0.5))
    
