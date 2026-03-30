a=-1;       % left end point of the interval
b=2;        % right end point of the interval
tolerance=10^(-5);  %tolerance

r=(sqrt(5)-1)/2;
x=a+r*(b-a);
y=a+(1-r)*(b-a);
k=0;
fx=f(x);
fy=f(y);
fprintf('Step %2d,  a=% 10.8f,  y=% 10.8f,  x=% 10.8f,  b=% 10.8f\n',k,a,y,x,b)
while (b-a)>= tolerance & k<100
    if fx>fy
        b=x;
        x=y;
        fx=fy;
        y=a+(1-r)*(b-a);
        fy=f(y);
    else
        a=y;
        y=x;
        fy=fx;
        x=a+r*(b-a);
        fx=f(x);
    end
    k=k+1;
    fprintf('Step %2d,  a=% 10.8f,  y=% 10.8f,  x=% 10.8f,  b=% 10.8f\n',k,a,y,x,b)
end
output=(a+b)/2;
fprintf('minimum point=% 10.8f\n',output) 

%%%%%%%%%% variables used for testing the code %%%%%%%%%%%%
output=x;   %the output of the iteration
a;          %left end point of the interval
b;          %right end point of the interval
tolerance;  %tolerance value
f1=f(a);   %function value for testing the correctness of the definition of f
f2=f(b);   %function value for testing the correctness of the definition of f
f3=f((a+b)/2);   %function value for testing the correctness of the definition of f

function y=f(x)     %the function to be minimized
    y=x^2-0.8*x+1;
end