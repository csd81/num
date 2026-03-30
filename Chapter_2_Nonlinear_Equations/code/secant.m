function szelo(f,t)
    i=input('Kérem a kezdõ intervallumot:')
    a=i(1)
    b=i(2)
    if f(a)==0 
        fprintf('Az intervallum elsõ végpontja megoldás!')
        return
    end
    if f(b)==0 
        fprintf('Az intervallum második végpontja megoldás!')
        return
    end
    l=1;
    if f(a)-f(b) == 0
        fprintf('Nem található megoldás, a szelõ párhuzamos az x tengellyel!')
        return
    end
    p=b-f(b)*(b-a)/(f(b)-f(a));
    while abs(f(p))>=t & l < 100 
        if f(a)-f(b) == 0
            fprintf('Nem található megoldás, a szelõ párhuzamos az x tengellyel!')
            return
        end
        p=b-f(b)*(b-a)/(f(b)-f(a));
        fprintf('%d. lépésben a közelítõ gyök: %6f\n',l,p)
        a=b;
        b=p;
        l=l+1;
    end
end
