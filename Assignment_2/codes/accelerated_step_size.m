%Accelerated search method
clc;
clear;
init_guess=input("Enter the intial guess: \n");
step=input("Enter the step size : \n");
x1t=init_guess;
x1=x1t;


dir =1;
i=1;
m=0;
iter=0;

f=@(x)(-(.5/sqrt(1+x^2) -sqrt(1+x^2)*(1-.5/(1+x^2)) +x));

X=[];
while true
    iter=iter+1;
    x2=dir*step*2^(i-1) +x1;
    
    if f(x2)<f(x1t)
        i=i+1;        
        x1t=x2;
        X=[X;x1t];
    else if f(x2)> f(x1t) 
            if i>1
                m=x1t;
                X=[X;x1t];
                break
            else if dir==-1
                    X=[X;x1t];
                    m=x1t;
                    break
                else
                    dir=-1;
                    i=1;
                end                
            end    
        else
            X=[X;x1t];
            m=x1t;
            break
        end
    end         
end
opti=m;
max_stress=-f(opti);

fprintf("Point of Maximum stress :%f\n",opti)
fprintf("Maximum stress :%f\n",max_stress)
fprintf("Number of iterations : %d\n",iter)