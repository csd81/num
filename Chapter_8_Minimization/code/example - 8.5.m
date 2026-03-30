A=[4, 2, -1;
   2, 5, 0;         % coefficient matrix
   -1, 0, 3];       
b=[0;8;1];          %right-hang side as a column vector
tolerance=0.001;    % tolerance
p0=[3;3;3];          %initial vector as a column vector


k=0;
p=p0;
r=b-A*p;
fprintf('Step %2d:  p=[% 10.8f; % 10.8f; % 10.8f]\n',k,p)
while norm(r,Inf)>=tolerance & k<100
    r=b-A*p;
    alpha=(r.'*r)/(r.'*A*r);
    p=p+alpha*r;
    k=k+1;
    fprintf('Step %2d:  p=[% 10.8f; % 10.8f; % 10.8f]\n',k,p)
end
output=p;

%%%%%%%%%% variables used for testing the code %%%%%%%%%%%%
output;     %the output of the iteration
p0;         %starting value of the sequence
A;          %coefficient matrix
b;          %right-hand side
tolerance;  %tolerance
