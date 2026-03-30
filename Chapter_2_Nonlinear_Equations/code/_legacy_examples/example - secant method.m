p0=0.0;       %initial value
p1=0.5;       %initial value
tolerance=10^(-5);    %tolerance


q=p0;
p=p1;
fprintf('Step %2d,  p=% 10.8f,  f(p)=% 9.4e\n',0,q,f(q));
fprintf('Step %2d,  p=% 10.8f,  f(p)=% 9.4e\n',1,p,f(p));
k=1;
while abs(p-q)>tolerance & k<100
    x=p-f(p)*(p-q)/(f(p)-f(q));    %new element
    q=p;    
    p=x;    % p will be the new element
    k=k+1;
    fprintf('Step %2d,  p=% 10.8f,  f(p)=% 9.4e\n',k,p,f(p));
    if f(p)==0
        fprintf('exact solution=%9.7f\n',p);
        output=p;   
        break;
    end
end

%%%%%%%%%% variables used for testing the code %%%%%%%%%%%%
output=p;   %last value of the iteration - the output of this program
f1=f(p0);   %function value for testing the correctness of the definition of f
f2=f((p0+p1)/2);   %function value for testing the correctness of the definition of f
f3=f(p1);   %function value for testing the correctness of the definition of f
p0;         %initial value
p1;         %initial value
tolerance;  %tolerance value


function y=f(x)
y=x^3+x^2-8*x-12;     % the formula of the function f
end
