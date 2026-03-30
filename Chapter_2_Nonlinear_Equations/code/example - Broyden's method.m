p0=[-1.5;-1.5];     %initial vector as a column vector
tolerance=10^(-5);  % tolerance

%computation of A0:
h=0.001;     %stepsize for the approximation of A0
e1=[1;0];
e2=[0;1];
A0=[(f(p0+h*e1)-f(p0))/h,(f(p0+h*e2)-f(p0))/h]
%--------------------
A=inv(A0);
q=p0;
k=0;
fprintf('Step %2d,  p=[% 12.9f; % 12.9f], ||f(p)||=% 7.5e\n',k,q,norm(f(q),Inf));
while k<100
    s=-A*f(q);
    p=q+s; 
    if norm(s,Inf)<tolerance 
        break;
    end
    y=f(p)-f(q);
    A=A-(A*y-s)*s.'*A/(s.'*A*y);
    q=p;
    k=k+1;
    fprintf('Step %2d,  p=[% 12.9f; % 12.9f], ||f(p)||=% 7.5e\n',k,p,norm(f(p),Inf));
end

%%%%%%%%%% variables used for testing the code %%%%%%%%%%%%
output=p;   %last value of the iteration - the output of this program
f1=f([1.,0.]);   %function value for testing the correctness of the definition of f
f2=f([0.,2.]);   %function value for testing the correctness of the definition of f
f3=f([2.,3.]);   %function value for testing the correctness of the definition of f
p0;         %initial value
tolerance;  %tolerance value


function y=f(x)     % the formula of the function f (as a column vector)
y=[4*x(1)-exp(x(1)*x(2))-3; x(1)-x(2)^2-3*x(2)-1];     
end


