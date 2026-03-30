x=[-1, 0, 0.5, 1, 2, 2.5, 3];           %x values
y=[1.4, 1.9, 1.6, 1.7, 0.2, -0.1, -2];  %y values

n=length(x);
A=zeros(3);
b=[0;0;0];
for i=1:n
    A(1,1)=A(1,1)+x(i)^4;
    A(1,2)=A(1,2)+x(i)^3;
    A(1,3)=A(1,3)+x(i)^2;
    A(2,3)=A(2,3)+x(i);
    b(1)=b(1)+x(i)^2*y(i);
    b(2)=b(2)+x(i)*y(i);
    b(3)=b(3)+y(i);
end
A(2,1)=A(1,2);
A(2,2)=A(1,3);
A(3,1)=A(1,3);
A(3,2)=A(2,3);
A(3,3)=n;
fprintf('normal equation:\n')
fprintf('%9.5fA%+9.5fB%+9.5fC=%9.5f\n',A(1,1),A(1,2),A(1,3),b(1))
fprintf('%9.5fA%+9.5fB%+9.5fC=%9.5f\n',A(2,1),A(2,2),A(2,3),b(2))
fprintf('%9.5fA%+9.5fB%+9.5fC=%9.5f\n',A(3,1),A(3,2),A(3,3),b(3))
u=A\b;
a2=u(1);
a1=u(2);
a0=u(3);
fprintf('\nsolution: A=%10.8f,  B=%10.8f,  C=%10.8f\n',a2,a1,a0)
err=0;
for i=1:n
    err=err+(poly(x(i),a2,a1,a0)-y(i))^2;
end

fprintf('coefficients: a2=%10.8f,  a1=%10.8f,  a0=%10.8f\n',a2,a1,a0)
%fprintf('parabola: % 10.8f*x^2%+10.8f*x%+10.8f\n',a2,a1,a0)
fprintf('least square error: % 10.8f\n',err)

t=x(1):0.05:x(n);
z=poly(t,a2,a1,a0);
hold on
plot(x,y,'ro','MarkerSize',10,MarkerFaceColor='r')
plot(t,z,'b-','LineWidth',3)
ttl=sprintf('$%10.8f\\cdot x^2%+10.8f\\cdot x%+10.8f$',a2,a1,a0);
title(ttl,'Interpreter','latex','FontSize',16)


function z=poly(t,a2,a1,a0)
    z=a2*t.^2+a1*t+a0;
end