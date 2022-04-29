clear;clc;

a=input('Enter lower limit : \n'); 
b=input('Enter upper limit : \n');
accuracy=input('Enter the accuracy in % : \n')*0.01;
Init_len=b-a;

f=@(x)(-(.5/sqrt(1+x^2) -sqrt(1+x^2)*(1-.5/(1+x^2)) +x));

delta_0=0.001;
i=0; 
while true
    i=i+1;
    L0=b-a;
    x1=a+L0/2 - delta_0/2;
    x2=a+L0/2 + delta_0/2;
    f1=f(x1);
    f2=f(x2);
    if f1>f2
        a=x1;
    else if f1<f2
            b=x2;
        else
            a=x1;
            b=x2;
        end
    end  
    if b-a < 2*Init_len*accuracy
        n=2*i;
        lbf=a;
        ubf=b;
        optimum_point=(lbf+ubf)/2;
        break
    end
end

fprintf("\nFinal interval : (%f,%f)\n",a,b)
fprintf("Point of Maximum stress :%f\n",optimum_point)
fprintf("Maximum stress :%f\n",-f(optimum_point))
fprintf("Number of iterations : %d\n",n)