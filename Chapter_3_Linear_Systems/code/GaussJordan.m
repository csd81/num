function GaussJordan(A,b)
sA=size(A);
sb=size(b);
if sA(1)~=sA(2) | sA(1)~=sb(1) | sb(2)~=1
  fprintf('Nem jók a paraméterek!')
  return
end
n=sA(1);
A=[A,b];
disp('0. lépés:')
disp(A)
for i=1:n
  if A(i,i)== 0
    fprintf('Fõátlóban 0 érték van, az elimináció leáll!')
    return
  end
  for j=1:n
    if i~=j
      kiv=A(j,i)/A(i,i);
      A(j,:)=A(j,:)-kiv*A(i,:);
    end
  end
  fprintf('%d. lépésben az iterációs mátrix:\n',i)
  disp(A)
end
for i=1:n
  A(i,n+1)=A(i,n+1)/A(i,i)
  A(i,i)=A(i,i)/A(i,i)
end
fprintf('A megoldás az alábbi mátrixból olvasható ki:\n')
disp(A)
end