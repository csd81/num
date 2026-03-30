function minv(A)
s=size(A);
if s(1)~=s(2)
  fprintf('Invertálni négyzetes mátrixot lehet!')
  return
elseif det(A)==0
  fprintf('Szinguláris mátrix!')
  return  
end
n=s(1);
A=[A,eye(n,n)];
disp('0. lépés:')
disp(A)
for i=1:n
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
  A(i,:)=A(i,:)/A(i,i)
end
fprintf('Az inverz mátrix:\n')
disp(A(:,n+1:2*n))
end