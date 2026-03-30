y0=1;       % initial value
t0=0;       % initial time
T=1;        % end of the interval
h=0.2;      % stepsize

%----------------------------------
n=floor(T/h);
t=zeros(1,n+1);
z=t;
t(1)=t0;
z(1)=y0;
fprintf('Step %2d,  t=%4.3f,    z=% 10.8f,    error=% 10.8f\n',0,t(1),z(1),abs(z(1)-exact_solution(t(1))))
for i=1:n
    z(i+1)=z(i)+h*f(t(i),z(i));
    t(i+1)=i*h;
    fprintf('Step %2d,  t=%4.3f,    z=% 10.8f,    error=% 10.8f\n',i,t(i+1),z(i+1),abs(z(i+1)-exact_solution(t(i+1))))
end
output=z(n+1);
hold on
tt=t0:0.01:T;
y=exact_solution(tt);
plot(tt,y,'-b','Linewidth',1.5)
plot(t,z,'-r','Marker','o','Markerfacecolor','r','Linewidth',2)
legend('exact sol.','approx. sol.','location','northwest')

%%%%%%%%%% variables used for testing the code %%%%%%%%%%%%
output;             % the last value of the Euler sequence
y0;                 % initial value
t0;                 % initial time
T;                  % end of the time interval
h;                  % stepsize

function w=f(t,y)       %right-hand side of the differential equation
    w=2*y-10*t.^2+2*t;
end

function y=exact_solution(t)       %exact solution of the IVP
    y=5*t.^2+4*t+2-exp(2*t);
end
