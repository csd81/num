function Hermint(x,y,yd)
if length(x)~=length(y) | length(y)~=length(yd)
  fprintf('Rossz vektorokat adott meg!')
  return
end
n=length(x);
fo=zeros(2*n);
for i=1:n
  xx(2*i -1)= x(i);
  xx(2*i)=x(i);
  fo(2*i-1 ,1)=y(i);
  fo(2*i,1)= y(i);
  fo(2*i,2)= yd(i);
end
for i=2:n
  fo(2*i-1,2)=(fo(2*i-1,1)-fo(2*i-2,1))/(xx(2*i-1)-xx(2*i-2));
end
for j =3:2* n
  for i=j :2*n
    fo(i,j)=(fo(i,j-1)-fo(i-1,j-1))/(xx(i)-xx(i-j+1));
  end
end
fprintf ('A megoldás :\n')
disp (fo)
end