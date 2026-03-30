a0=0.;       %initial interval
b0=1.;       %initial interval
tolerance=10^(-5);    %tolerance

a=a0;
b=b0;
if f(a)*f(b)>=0
    error('The function does not satisfy the opposite sign property')
end

p=(a+b)/2;
k=0;
fprintf('Step %2d,  a=%9.7f,  p=%9.7f,  b=%9.7f,  f(a)=% 9.7e,  f(p)=% 9.7e,  f(b)=% 9.7e\n',k,a,p,b,f(a),f(p),f(b));
while abs(b-a)>tolerance & k<100
    if f(p)==0
        fprintf('exact solution=%9.7f\n',p);
        output=p;   
        break;
    elseif f(a)*f(p)<0
        b=p;
    else
        a=p;
    end
    k=k+1;
    p=(a+b)/2;
    fprintf('Step %2d,  a=%9.7f,  p=%9.7f,  b=%9.7f,  f(a)=% 9.7e,  f(p)=% 9.7e,  f(b)=% 9.7e\n',k,a,p,b,f(a),f(p),f(b));
end

%%%%%%%%%% variables used for testing the code %%%%%%%%%%%%
output=p;   %last value of the iteration - the output of this program
f1=f(a0);   %function value for testing the correctness of the definition of f
f2=f((a0+b0)/2);   %function value for testing the correctness of the definition of f
f3=f(b0);   %function value for testing the correctness of the definition of f
a0;         %initial interval [a0,b0]
b0;         %initial interval [a0,b0]
tolerance;  %tolerance value


function y=f(x)
y=exp(x)-2*cos(x);     % the formula of the function f
end