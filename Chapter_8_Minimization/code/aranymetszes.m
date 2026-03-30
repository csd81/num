function aranymetszes(f,a,b,t)
r=(sqrt(5.)-1)/2;
x=a+r*(b-a);
y=a+(1-r)*(b-a);
fx=f(x);
fy=f(y);
l=0;
while b-a>t
    if fx>fy
        b=x;
        x=y;
        fx=fy;
        y=a+(1-r)*(b-a);
        fy=f(y);
    else
        a=y;
        y=x;
        fy=fx;
        x=a+r*(b-a);
        fx=f(x);
    end
    l=l+1;
end
x=(a+b)/2;
y=f(x);    
fprintf('Minimumhely = %6f\n',x);
fprintf('Minimális függvényérték = %6f\n',y);
fprintf('Lépésszám =%d\n',l);
end 

