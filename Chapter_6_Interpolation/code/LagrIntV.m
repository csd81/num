function LagrIntV(x,y)
if length(x)~=length(y)
  fprintf('Rossz vektorokat adott meg!\n')
  return
end
n=length(x);
for i=1:n
  for j=1:n
    V(i,j)=x(i)^(j-1);
  end
end
if det(V)==0
  disp('Két azonos x értéket adott meg!')
  abort
  else
    disp('A Vandermonde mátrix:')
    disp(V)
    disp('A Vandermonde mátrix determinánsa:')
    disp(det(V))
    a=V\y;
    disp('A polinom együtthatói:')
    disp(a)
end
end
