p0=[-1.5;-1.5];     %initial vector as a column vector
tolerance=10^(-5);  % tolerance

p=p0;
q=p-1;      %artificial previous value of the sequence
k=0;
fprintf('Step %2d,  p=[% 12.9f; % 12.9f], ||f(p)||=% 7.5e\n',k,p,norm(f(p),Inf));
while norm(p-q,Inf)>tolerance & k<100
    q=p;               %previous element
    s=df(p)\f(p);      % solution of the linear system df(p)s=f(p) for s
    p=p-s;
    k=k+1;
    fprintf('Step %2d,  p=[% 12.9f; % 12.9f], ||f(p)||=% 7.5e\n',k,p,norm(f(p),Inf));
end

%%%%%%%%%% variables used for testing the code %%%%%%%%%%%%
output=p;   %last value of the iteration - the output of this program
f1=f([1.,0.]);   %function value for testing the correctness of the definition of f
f2=f([0.,2.]);   %function value for testing the correctness of the definition of f
f3=f([2.,3.]);   %function value for testing the correctness of the definition of f
df1=df([1.,0.]);   %function value for testing the correctness of the definition of f
df2=df([0.,2.]);   %function value for testing the correctness of the definition of f
df3=df([2.,3.]);   %function value for testing the correctness of the definition of f
p0;         %initial value
tolerance;  %tolerance value


function y=f(x)     % the formula of the function f (as a column vector)
y=[4*x(1)-exp(x(1)*x(2))-3; x(1)-x(2)^2-3*x(2)-1];     
end

function y=df(x)    %Jacobi matrix of f(x)
y=[4-x(2)*exp(x(1)*x(2)), -x(1)*exp(x(1)*x(2)); 
   1, -2*x(2)-3];     
end
