function rgauss(A,b)
    sA=size(A);
    sb=size(b);
    if sA(1)~=sA(2) | sA(1)~=sb(1) | sb(2)~=1
        fprintf('Nem jók a paraméterek!')
        return
    end
    n=sA(1);
    A=[A,b];
    disp('0. lépés:');
    disp(A)
    for k=1:n-1,
        [maxe,maxindex]=max(abs(A(k:n,k)));
        if maxindex>1,
            sorindex=maxindex+k-1;
            sor=A(sorindex,:);
            A(sorindex,:)=A(k,:);
            A(k,:)=sor;
            fprintf('A(z) %d. és %d. sor cseréje:\n',k,sorindex);
            disp(A)
        end
        for i=k+1:n,
            if A(k,k)==0,
                disp('Nem hajtható végre az elimináció, f?elem=0')
                return
            end
            l=A(i,k)/A(k,k);
            A(i,:)=A(i,:)-l*A(k,:);
        end
        fprintf('A(z) %d. eliminációs lépés:\n',k);
        disp(A)
    end
    if A(n,n)==0 & A(n,n+1)~=0
        fprintf('Nincs megoldás!')
        return
    elseif A(n,n)==0 & A(n,n+1)==0
        x(n)=1
        for i=n-1:-1:1,
            x(i)=A(i,n+1);
            for j=i+1:n,
                x(i)=x(i)-A(i,j)*x(j);
            end
            x(i)=x(i)/A(i,i);
        end
    else
        x(n)=A(n,n+1)/A(n,n);
        for i=n-1:-1:1,
            x(i)=A(i,n+1);
            for j=i+1:n,
                x(i)=x(i)-A(i,j)*x(j);
            end
            x(i)=x(i)/A(i,i);
        end
    end
    disp('A megoldás:')
    disp(x)
end