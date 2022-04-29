%Interior penalty function one variable
clc
clear all

x0=1 ; %Initial feasible point
iterations=0;
del=1e-6;

qnewton_tol=1e-8;
tol2=1e-14;

r=10 ; % Initial large value of r
R=[r];
optimas=[];

format long  

while true
   
while true %Quasi Newton minimisation 
%Using Central Difference Scheme to find the derivatives f'(x) and f"(x)
    
    iterations=iterations+1;
    d=(phi(x0+del,r)-2*phi(x0,r) +phi(x0-del,r) );
    x1=x0 - .5*del*( phi(x0+del,r)- phi(x0-del,r) )/d;
    df= ( phi(x1+del,r) - phi(x1-del,r) )/(2*del);   %Slope
    
    if abs(df)<qnewton_tol
        optima=vpa(x1);
        fx2=phi(x1,r); 
        fx1=phi(x0,r);
        break
    end
    x0=x1;
end

 cc1=abs(( fx2- fx1)/fx2) ;
 cc2= abs(x1-x0);

    if cc1 < tol2  & cc2 < tol2
        fprintf("Interior penalty method \n")
        iterations=iterations+1;
        fprintf("\nOptima reached :")
        disp(optima);
        fprintf("Iterations taken:")
        disp(iterations)
        fprintf("Final Penalty Parameter:")
        disp(r);
        
        optimas=[optimas; optima];
        break
    else
        r=r*.5;
        R=[R;r];
        x0=optima;
        optimas=[optimas; optima];
    end
 iterations=iterations+1;
end

function f=phi(x,r)
f= (2*x^2-6*x+9 )- r/(4-x);
end
 