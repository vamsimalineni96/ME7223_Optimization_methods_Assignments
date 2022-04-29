clear;
clc;

n=input('Enter the no of iterations : \n');
a=input('Enter lower limit : \n'); 
b=input('Enter upper limit : \n');

f=@(x)(-(.5/sqrt(1+x^2) -sqrt(1+x^2)*(1-.5/(1+x^2)) +x));
gamma=0.618;                    
iter=0;                            

x1=a+(1-gamma)*(b-a);             
x2=a+gamma*(b-a);

fe_x1=f(x1);                     
fe_x2=f(x2);

while ((iter<n))
    if(fe_x1<fe_x2)
        b=x2;
        x2=x1;
        x1=a+(1-gamma)*(b-a);
        fe_x1=f(x1);
        fe_x2=f(x2);
    else
        a=x1;
        x1=x2;
        x2=a+gamma*(b-a);
        fe_x1=f(x1);
        fe_x2=f(x2);   
    end
   iter=iter+1;
end

if(fe_x1<fe_x2)
fprintf("\nPoint of Maximum stress :%f\n",x1)
fprintf("Maximum stress :%f\n",-fe_x1)
else
fprintf("\nPoint of Maximum stress :%f\n",x2)
fprintf("Maximum stress :%f\n",-fe_x2)
end


