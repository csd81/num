function tgauss(A,b)

sA=size(A);
sb=size(b);
if sA(1) ~= sA(2) | sA(1) ~= sb(1) | sb(2) ~= 1
    disp('Rossz dimenziók!')
    return
end
n=sA(1);
A=[A,b];
oind=1:n;
fprintf('0. lépés:\n');
disp(A)
for k=1:n-1
   [maxek,maxok]=max(abs(A(k:n,k:n)));
   [maxe,maxo]=max(maxek);
   maxs=maxok(maxo);
   sorindex=maxs+k-1;
   oszlopindex=maxo+k-1;
   if sorindex>k
        sor=A(sorindex,:);
        A(sorindex,:)=A(k,:);
        A(k,:)=sor;
    end
    if oszlopindex>k
        oszlop=A(:,oszlopindex);
        A(:,oszlopindex)=A(:,k);
        A(:,k)=oszlop;
        oi=oind(k);
        oind(k)=oind(oszlopindex);
        oind(oszlopindex)=oi;
    end
    if sorindex>k & oszlopindex==k
        fprintf('A(z) %d. és %d. sor cseréje:\n',k,sorindex);
    elseif  sorindex==k & oszlopindex>k
        fprintf('A(z) %d. és %d. oszlop cseréje:\n',k,oszlopindex);
    elseif  sorindex>k & oszlopindex>k
        fprintf('A(z) %d. és %d. sor, %d. és %d. oszlop cseréje:\n',k,sorindex,k,oszlopindex);
    end
    if sorindex>k | oszlopindex>k
        disp(A)
    end
    for i=k+1:n
        if A(k,k)==0
            disp('Nem hajtható végre az elimináció, föelem=0')
            return
        end
        l=A(i,k)/A(k,k);
        A(i,:)=A(i,:)-l*A(k,:);
    end
    fprintf('A(z) %d. eliminációs lépés:\n',k);
    disp(A)
end
x(n)=A(n,n+1)/A(n,n);
for i=n-1:-1:1
    x(i)=A(i,n+1);
    for j=i+1:n
        x(i)=x(i)-A(i,j)*x(j);
    end
    x(i)=x(i)/A(i,i);
end
disp('A változók sorrendje')
disp(oind)
disp('A megoldás')
disp(x)
end