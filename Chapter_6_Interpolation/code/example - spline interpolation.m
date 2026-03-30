global x y a b c d n

x=[0., 0.5, 1.5, 2.0, 3.0, 4.0];         % x values as a row vector
y=[0.9, 0.1, 1.5, 0.0, -0.8, -0.2];      % y values as a row vector

n=length(x);
dx=diff(x);
dy=diff(y);
A=zeros(n);     % n x n-dimensional matrix
bb=zeros(n,1);  % column vector
a=y(1:(n-1));     % row vector,  we do not need the last element of y
b=zeros(1,n-1);   % row vector
d=zeros(1,n-1);   % row vector
A(1,1)=1;
A(n,n)=1;
for i=2:n-1
    A(i,i-1)=dx(i-1);
    A(i,i)=2*(dx(i-1)+dx(i));
    A(i,i+1)=dx(i);
    bb(i)=3*(dy(i)/dx(i)-dy(i-1)/dx(i-1));
end
cc=A\bb;     %solution of the linear system Ax=bb, a column vector
for i=1:(n-1)
    b(i)=dy(i)/dx(i)-(2*cc(i)+cc(i+1))/3*dx(i);
    d(i)=(cc(i+1)-cc(i))/(3*dx(i));
end
%the coefficients of the cubic polynomial functions
fprintf('the coefficients of the cubic polynomials:\n')
a
b
c=cc(1:n-1).'       % we do not need the last element of the vector cc, and transform it into a row vector
d

%plot of the interpolating spline function and the data points 
t=x(1):0.01:x(n);
for i=1:length(t),
    z(i)=S(t(i));
end
hold on
plot(x,y,'ro','MarkerSize',10,MarkerFaceColor='r')
plot(t,z,'b-','LineWidth',3)


function yy=S(t)    % evaluation of the spline function
global x y a b c d n
    if t<x(1) | t>x(n),
        error('wrong argument of S')
    end
    for i=1:n-1,
        if t>=x(i) & t< x(i+1),
            yy=a(i)+b(i)*(t-x(i))+c(i)*(t-x(i))^2+d(i)*(t-x(i))^3;
            break
        end
    end
    if t==x(n),
        yy=a(n-1)+b(n-1)*(t-x(n-1))+c(n-1)*(t-x(n-1))^2+d(n-1)*(t-x(n-1))^3;
    end
end
