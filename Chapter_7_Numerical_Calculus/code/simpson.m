function simpson(f,a,b)
    n=input('Hányszor alkalmazzuk a Simpson szabályt? ');
    h=(b-a)/(2*n);
    x=a+h:h:b;
    m=f(a)+f(b);
    for i=1:2*n-1
        if mod(i,2) == 0
            m=m+2*f(a+i*h);
        else
            m=m+4*f(a+i*h);
        end
    end
    m=h/3*m;
    fprintf('A közelítõ integrál %d-szer alkalmazva a szabályt: %6f\n',n, m)
end