%Szélsõértékszámítás aranymetszés és szimplex módszer segítségével

%Aranymetszés
%Függvény minimumhelyének keresésére szolgáló közelítõ eljárás. A kezdõ
%intervallum tartalmazza a minimumhelyet. Ábrából olvassuk le.
%Paraméterezés:
% f - a függvény
% a - kezdõ intervallum elsõ pontja
% b - kezdõ intervallum második pontja
% t - közelítõ megoldás pontossága
%Feladat Keressük meg az f(x)=-x.*(1-0.3*x) függvény minimumhelyét.
%1. lépés ábrázoljuk

x=-5:0.01:5;
y=fgv(x);
plot(x,y)
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.YLim=[-10,10];

% Az ábrán látszik a szélsõérték helye, az [1,3] kezdõ intervallumon belül
% van, ezért ez választható kezõ intervallumnak.
% Futtatás (a pontosság 10^-4)
aranymetszes(@fgv,1,2,0.0001)
%A közelítõ megoldás 20 lépésben: 1.666678

% Szimplex módszer
% Minimumhely meghatározására használjuk
%Paraméterezés:
% f - a függvény
% A - kezdõpontokból képzett n+1*n méretû mátrix
% m - lépésszám

%1. feladat Keressük meg az f(x)=2*x^2+x-4 függvény minimumhelyét.
% 1. lépés Ábrázoljuk

x=-5:0.01:5;
y=szimpfgv(x);
plot(x,y)
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.YLim=[-10,10];

% A kezdõ értékek egyváltozós függvény esetén 
a=[0;1];
szimplexmodszer(@szimpfgv,a,30)

%A megoldás: -0,25

%2. feladat Kétváltozós szimplex eljárás
% Adja meg az f(x,y)=2*(0.5*x(1)^2-x(2))^2+(x(1)-1)^2 függvény
% minimumhelyét szimplex módszerrel. Az eljárást ötvenszer ismételje, a
% kezdõ szimplex három csúcs legyen a következõ három pont:
% (-1;6), (0;6), (-0,5;5)

% Kezdõ mátrix megkonstsuálása
a=[-1,6];
b=[0,6];
c=[-0.5,5];
A=[a;b;c];

% Futtatás
szimplexmodszer(@fgv2,A,30)

%Megoldás: P(0,9375 ; 0,4167) pontban van a függvénynek minimuma.
