%Feladat: Adott n+1 db pont a síkon, ezekre szeretnénk illeszteni egy
%polinomot, ami átmegy mindegyik ponton. A Lagrange interpoláció megad egy
%olyan n-ed fokú polinomot, ami teljesíti ezt. 
% A LagrIntV eljárás megadja a Lagrange polinom együtthatóit. Ha a polinom
% felírható L=c0+c1*x+c2*x^2+...cn*x^n alakban, akkor az eljárás
% végeredménye a c0, c1, c2, ... cn értékek lesznek ebben a sorrendben.
%Futtatáshoz a kapott n+1 pont x (elsõ) koordinátáiból kell képeznünk egy x
%oszlopvektort, a második koordinátákból pedig egy y oszlopvektort.

%Mintafeladat

%Adottak az alábbi pontok: (-2,96), (-1,21), (0,6), (1,3), (2,12)
%Adjuk meg a pontokon átmenõ polinomot, ás ábrázoljuk is a pontokkal
%együtt.

%1. lépés, elkészítjük az x és y oszlopvektorokat

x=[-2,-1,0,1,2]';
y=[96,21,6,3,12]';

%Lefuttatjuk az eljárást

LagrIntV(x,y)

% a kapott értékek: c0=6, c1=-5, c2=4, c3=-4, c4=2
%Ezek alapján a kapott polinom: 
% L=6-5*x+4*x^2-4*x^3+2*x^4
%Ezt a polinomot készítsük el az interpfgv.m fájlban. A hatványozás és a
%szorzás során használjuk a koordinátánkénti mûveleteekt (pontozott
%mûveletek) az ábrázolás miatt.
x1=-5:0.01:5;
y1=interpfgv(x1);
plot(x1,y1,x,y,'*')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.XLim = [-5 5]
ax.YLim = [-5 100]

%Végezetül mentsük el az ábrát .jpg kiterjesztéssel
%-----------------
%A Newton féle alakja a Lagrange interpolációnak ugyanazt a polinomot adja
%meg, de a kiszámítás módja kevesebb mûveletet igényel. Az osztott
%differenciák segítségével kapjuk meg a függvényt.
%A NewtIntp eljárás végeredménye az osztott differenciák lesznek. Ezek
%segítségével írjuk fel a függvényt a következõ módon:
%N=f[x0]+f[]x0,x1*(x-x0)+f[x0,x1,x2]*(x-x0)*(x-x1)+...+f[x0,x1,..,xn]*(x-x0)*(x-x1)*...*(x-x(n-1))

% Az eljárás paraméterezése ugyanaz, mint a Lagrange interpolációs
% eljárásé.

NewtIntp(x,y)

%A kapott értékek:
% f[x0]=96, f[x0,x1]=-75, f[x0,x1,x2]=30, f[x0,x1,x2,x3]=-8,
% f[x0,x1,x2,x3,x4]=2
%Ezek alapján a polinom:
%y=96-75*(x--2)+30*(x+2)*(x--1)-8*(x+2)*(x+1)*(x-0)+2*(x+2)*(x+1)*x*(x-1)
%Ez a polinom található a newtonfgv.m fájlban.
%Ha ábrázoljuk a függvényt, akkor figylejünk itt is a koordinátánkénti
%szorzásra.
x1=-5:0.01:5;
y1=newtonfgv(x1);
plot(x1,y1,x,y,'*')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.XLim = [-5 5]
ax.YLim = [-5 100]
%-----------------
%A Hermite interpolációs feladatban a megadott pontokon a polinom irányát is
%megadjuk, vagyis a pontokban vett derivált értékét. Ekkor n db ponton egy
%2n-1-edfokú polinom illesztõdni. Ennek a polinomnak az osztott
%differenciáit kapjuk meg a Hermint eljárással.
%Feladat
%Adott három pont (-1,1), (1,1) és ((2,29). Ezekben a pontokban aderivált
%értéke rendre -5, 7, 61. Adjuk meg a Hermite polinomot, ami a kért módon megy át a pontokon.

%A Hermint eljárás 3 paramétere egy-egy oszlopvektor.

x=[-1;1;2]
y=[-1;1;29]
yd=[-5;7;61]

%Futtatóutasítás:
Hermint(x,y,yd)

%A szükséges osztott differencia értékek a végeredmény fõátlójából
%olvashatók ki.
% f[x0]=-1, f[x0,x1]=-5, f[x0,x1,x2]=3, f[x0,x1,x2,x3]=0,
% f[x0,x1,x2,x3,x4]=2, f[x0,x1,x2,x3,x4,x5]=0
%Ezek alapján a polinom:
% y=-1-5*(x--1)+3*(x+1)^2+0*(x+1)^2*(x-1)+2*(x+1)^2*(x-1)^2+0*(x+1)^2*(x-1)^2*(x-2);
%Ábrázolás:

x1=-3:0.01:3;
y1=hermfgv(x1);
plot(x1,y1,x,y,'*')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.XLim = [-3 3]
ax.YLim = [-5 40]

