clc
clear all

x0=0 ;  % Initial point
r=1;    % Initial small r value 
R=[r];
tol=1e-5;
constraint= @(x) (4-x);
del=1e-6;
iterations=0;

while true
    
while true %Quasi Newton minimisation 
    
%Using Central Difference Scheme to find the derivatives f'(x) and f"(x)
    d=(phi(x0+del,r)-2*phi(x0,r) +phi(x0-del,r) );
    x1=x0 - .5*del*( phi(x0+del,r)- phi(x0-del,r) )/d;
    df= ( phi(x1+del,r) - phi(x1-del,r) )/(2*del);   %Slope
    
    if abs(df)<tol
        break
    end
    x0=x1;
end

if  (constraint(x1))<tol %Convergence criteria check
    disp("Exterior penalty method")
    iterations=iterations+1;
    optima=x1;
    fprintf("\nOptima reached :")
        disp(optima);
        fprintf("Iterations taken:")
        disp(iterations)
        fprintf("Final Penalty Parameter:")
        disp(r);
        
    break
else
    r=1.5*r; 
    R=[R;r];
end
iterations=iterations+1;

end

function g=phi(x,r)
 
g=2*x.^2-6.*x+9 + r.*(max(0,4-x).^2 ); 
end
    

