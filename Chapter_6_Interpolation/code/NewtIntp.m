function NewtIntp(x,y)
if length(x)~=length(y)
  fprintf('Rossz vektorokat adott meg!')
  return
end
n=length(x);
for i = 1 : n
  a(i) = y(i);
end
for j=2:n
  for i=n:-1:j
    a(i)=(a(i)-a(i-1))/(x(i)-x(i-j+1));
  end
end
disp('A Newton-polinom együtthatói: ')
disp(a)
end