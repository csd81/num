x=[0, 1, 1.5, 2, 3, 4];           %x values
y=[0.3, 0.7, 0.9, 1.2, 1.8, 2.7];  %y values

n=length(x);
A=zeros(2);
d=[0;0];
for i=1:n
    A(1,1)=A(1,1)+x(i)^2;
    A(1,2)=A(1,2)+x(i);
    d(1)=d(1)+x(i)*log(y(i));
    d(2)=d(2)+log(y(i));
end
A(2,1)=A(1,2);
A(2,2)=n;
fprintf('normal equation:\n')
fprintf('%7.5fA%+7.5fB=%7.5f\n',A(1,1),A(1,2),d(1))
fprintf('%7.5fA%+7.5fB=%7.5f\n',A(2,1),A(2,2),d(2))
u=A\d;
AA=u(1);
BB=u(2);
fprintf('\nsolution: A=%10.8f,  B=%10.8f\n',AA,BB)
a=AA;
b=exp(BB);
fprintf('coefficients: a=%10.8f,  b=%10.8f\n',a,b)
err=0;
err2=0;
for i=1:n
    err=err+(expf(x(i),a,b)-y(i))^2;
    err2=err2+(AA*x(i)+BB-log(y(i)))^2;
end

fprintf('nonlinear least square error: % 10.8f\n',err)
fprintf('linearized least square error: % 10.8f\n',err2)

t=x(1):0.05:x(n);
z=expf(t,a,b);
hold on
plot(x,y,'ro','MarkerSize',10,MarkerFaceColor='r')
plot(t,z,'b-','LineWidth',3)
ttl=sprintf('$%10.8f\\cdot e^{%10.8fx}$',b,a);
title(ttl,'Interpreter','latex','FontSize',16)


function z=expf(t,a,b)
    z=b*exp(a*t);
end