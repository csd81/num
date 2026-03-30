% =========================================================
% Legacy Hungarian Educational Script
% Historical problem set for fixed-point iteration learning
% This file demonstrates fixed-point iteration methods for solving
% equations of the form f(x) = g(x) by transforming to h(x) = x
% =========================================================


%1. Feladat 
% Keresse meg a ln(3+3x+x^2) függvény fixpontját

%1. lépésként hozzuk létre a függvényt (fgv.m) és ábrázoljuk a fixpont
%egyenessel együtt. Mentsük is az ábrát fgv.jpg formában
% Ügyeljünk, hogy az fgv.m fájlban a hatványozás koordinátánként legyenek
% végrehajtva (pontozott mûvelet). Az ábrázolás miatt fontos.

x = -5:0.01:5;
y = fgv(x);
plot(x,y,x,x)
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.YLim=[-5, 5]

%2. lépésként futtassuk le a fixpont eljárást. A kezdõpontot futás közben
%kéri az eljárás. A kezdõ két paraméter:
% f - a függvény, aminek a fixpontját keressük
% t - tolerancia (pontosság), ha nincs megadva, akkor minden esetben 10^-4
% az értéke.

%Érdemes a kezdõpontot az ábrán látható metszéspont közelépen választani (bár ez nem garantálja a  találatot)

fixpont(@fgv, 10^-4)

% x0= 2 kezdõpontot megadva: 11 lépés után 3.077354
% x0= 3 kezdõpontot megadva: 8 lépés után 3.077376

%2. feladat
% Oldjuk meg az alábbi egyenletet fixpont iteráció segítségével:
% exp(x)/(1-x^(1/3)) = x^4-3x^3+2x-1

%1. lépés Készítsük el a két függvényt külön fájlokba (fixfg1.m és
%fixfg2.m). 
%2. lépés ábrázoljuk a függvényeket közös koordináta rendszerben. Most az
%fplot utasítást használva látható, hogy a szintaxis kicsit más, itt a
%függvény elkészítésénél nem fontos, hogy pontozott-e a mûvelet vagy sem.

fplot(@fixfg1)
hold on
fplot(@fixfg2)
hold off
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.YLim=[-5, 5]

%3. lépés Az eredeti f(x)=g(x) alakú egyenletet át kell alakítani
%valamilyen h(x)=x alakú egyenletté.
% 5 ilyen lehetséges átalakítást tartalmaznak a fixfg_a1-a5 fájlok
%Ezeknek a fixpontjai ugyanazok a pontok, amik az eredeti függvény
%megoldásai.

%4. lépés futtatás

fixpont(@fixfg_a1, 10^-4)

% x0= 0 kezdõpontot megadva: hibás lépések a gyökfüggvény és a logaritmus miatt

fixpont(@fixfg_a2, 10^-4)

% x0= 0 kezdõpontot megadva: hibás lépések a gyökfüggvény miatt

fixpont(@fixfg_a3, 10^-4)

% x0= 0 kezdõpontot megadva: 6 lépés után -Inf (- végtelen)
% x0= -1 kezdõpontot megadva: 8 lépés után 6 lépés után -Inf (- végtelen)

fixpont(@fixfg_a4, 10^-4)

% x0= -1 kezdõpontot megadva: 32 lépés után -Inf (- végtelen)

fixpont(@fixfg_a5, 10^-4)

% x0= 1 kezdõpontot megadva: 3 különbözõ érték körül ingadozik az érték

% Mind az 5 átalakítás divergens lett ilyen vagy olyan módon. A dolgozatra
% nézve elegendõ 2 átalakítást megcsinálni és lefuttatni. Amennyiben mind
% divergens (mind a fenti példában), a válasz akkor a divergencia lesz.
