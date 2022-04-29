
clc;
clear;
f=@(x)(-(.5/sqrt(1+x^2) -sqrt(1+x^2)*(1-.5/(1+x^2)) +x));
x1=input("Enter the intial guess: \n");
step=input("Enter the step size : \n");

x2=x1+step;
temp=0;
check= 0;
i=0;
while(f(x1)>f(x2))
    if(f(x1)>f(x2))
        x1=x2;
        x2=x2+step;
        i=i+1;
    else
        temp=x2+step;
        if(f(temp)>f(x2))
            check= 1
            break
        else
            x1=x2;
            x2=x2+step;
        end
    end
end
if check == 0
    fprintf("\nPoint of Maximum stress :%f\n",x1)
    fprintf("Maximum stress :%f\n",-f(x1))
    fprintf("Number of iterations : %d\n",i)
end
