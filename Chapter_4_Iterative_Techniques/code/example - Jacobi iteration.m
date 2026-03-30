A=[4, 2, -1;        % the coefficient matrix
   5, -10, 2;
   -2, 3, -7];      
b=[9; 8; 3];        % right-hand side as a column vector
x0=[0; 0; 0;];      % initial value of the iteration
tolerance=10^(-5);  % tolerance value

k=0;            %step counter
x=x0;           %current value
y=x0-1;         %artificial past value
D=diag(diag(A));
T=-inv(D)*(A-D);
c=inv(D)*b;
fprintf('r=b-Ax is the residual vector\n');
fprintf('Step %2d,  x=[% 12.9f; % 12.9f; % 12.9f],   ||r||=% 7.5e\n',k,x,norm(b-A*x,Inf));
while norm(x-y,Inf)>tolerance & k<100
    y=x;
    x=T*x+c;
    k=k+1;
    fprintf('Step %2d,  x=[% 12.9f; % 12.9f; % 12.9f],   ||r||=% 7.5e\n',k,x,norm(b-A*x,Inf));
end

%%%%%%%%%% variables used for testing the code %%%%%%%%%%%%
output=x;   %the output of the iteration
A;          %coefficient matrix
b;          %right-hand side
x0;         %initial value
tolerance;  %tolerance value
