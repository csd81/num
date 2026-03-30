p0=0.4;    %initial value
tolerance=10^(-5);    %tolerance

x=p0;
k=0;
fprintf('Step %2d,  x=%7.5f\n',k,x);
while abs(g(x)-x)>tolerance & k<100  
    x=g(x);
    k=k+1;
    fprintf('Step %2d,  x=%7.5f\n',k,x); 
end
 
%%%%%%%%%% variables used for testing the code %%%%%%%%%%%%
output=x;   %last value of the iteration - the output of this program
g1=g(1.);   %function value for testing the correctness of the definition of g
g2=g(2.);   %function value for testing the correctness of the definition of g
g3=g(5.);   %function value for testing the correctness of the definition of g
p0;         %initial value
tolerance;  %tolerance value


function y=g(x)
y=-1/8*x^3+x+1;     % the formula of the function g
end
