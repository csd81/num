function gauss(A,b)

sA=size(A);
sb=size(b);
if sA(1) ~= sA(2) | sA(1) ~= sb(1) | sb(2) ~= 1
    disp('Rossz dimenziók!')
    return
end
n=sA(1);
A=[A,b];
fprintf('0. lépés:\n');
disp(A)
for k=1:n-1,
    for i=k+1:n,
        if A(k,k)==0,
            disp('Nem hajtható végre az elimináció, fõelem=0')
            return
        end
        l=A(i,k)/A(k,k);
        A(i,:)=A(i,:)-l*A(k,:);
    end
    fprintf('A(z) %d. eliminációs lépés:\n',k);
    disp(A)
end
x(n)=A(n,n+1)/A(n,n);
for i=n-1:-1:1,
    x(i)=A(i,n+1);
    for j=i+1:n,
        x(i)=x(i)-A(i,j)*x(j);
    end
    x(i)=x(i)/A(i,i);
end
disp('A megoldás:')
disp(x)
end

