function hur(f,a,b,t) 
    if f(a)*f(b)>0 
       fprintf('Nem ellentétes elõjelû az intervallum!')
       return
    end
    
    if f(a)==0 
        fprintf('Az intervallum elsõ végpontja megoldás! (%6f)\n',a)
        return
    end
    if f(b)==0 
        fprintf('Az intervallum második végpontja megoldás! (%6f)\n',b)
        return
    end
    
    l=0;
    c=a-f(a)*(a-b)/(f(a)-f(b));
    if f(c)==0 
        fprintf('%d lépésben a pontos gyök: %6f\n',l,c);
        return
    end
    while abs(f(c))>t & l < 100

        c=a-f(a)*(a-b)/(f(a)-f(b));
        if f(a)*f(c) < 0
            b=c;
        elseif f(b)*f(c) < 0
            a=c;
        else
            fprintf('%d lépésben a pontos gyök: %6f\n',l,c)
            return
        end
        l=l+1;
        fprintf('%d lépésben a közelítõ gyök: %6f\n',l,c)
    end  
end
