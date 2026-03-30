% Legacy Hungarian educational script - function definition
% Historical implementation of Newton's method with input prompt

function newton(f,df,t)
    a=input('Kérem a kezdőpontot: ')
    if f(a)==0 | abs(f(a))<t
        fprintf('A kezdőpont megoldás!')
        return
    end
    l=1;
    while abs(f(a))>=t & l < 100
    if df(a) == 0
        fprintf('Nem található megoldás, az érintő párhuzamos az x tengellyel!')
        return
    end
    a=a-f(a)/df(a);
    fprintf('%d. lépés után a közelítő megoldás: %6f\n',l,a)
    l=l+1;
    end
end
