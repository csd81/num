%Közelítõ integrálás Összetett trapéz és összetett Simpson szabály
%segítségével
%Alapfeladat: Számoljuk ki az integral(from a to b) értéket.
%A közelítõ integrálok az alapintervallum felosztása segítségével számolják
%a közelítõ értéket.
%Mindkét eljárás 3 paraméter megadásával használható:
% f a függvény
% a az integrálás elsõ végpontja
% b a második végpont
%Indítés után mindkét eljárás vár még 1 paramétert. A trapéz szabály a
%részintervallumok számára, a Simpson az elemi szabály alkalmazásainak
%számára kérdez rá. Utóbbi amiatt nem a részintervallumok számát kérdez,
%mert az elemi szabály már felezi az eredeti intervallumot.
% A megoldás során elõször el kell készíteni a függvényt, amit integrálni
% szeretnénk (fgv.m fájlban található). Ha kéri a feldat, akkor ábrázoljuk
% is.
% Második lépésben kell fefuttani az eljárásokat, két mintafuttatást
% találunk itt.

trapez(@fgv,1,2)
simpson(@fgv,1,2)


% Két görbe közötti korlátos síkidom területének kiszámítása
%Feladat: Adott két függvény, aminek minimum két metszéspontja van.
%Számoljuk ki a közrezárt terület nagyságát.
% 1. lépés léterhozzuk a két függvényt (f.m és g.m fájlokban
% 2. lépés ábrázoljuk õket oly módon, hogy a mezszéspontok látszódjanak
% (erre a metszéspontokat kiszámító közelítõ eljárás - általában
% intervallumfelezés - miatt van szükség, hiszen ott kezdõ intervallumot
% meg kell adnunk).
% 3. lépés fg.m fájlba elkészítjük a a két függvény különbségét (f-g, feltéve, hogy f>g). A
% területszámítás miatt a "felül haladó" függvénybõl vonjuk ki a kisebbet. 
% 4. lépés Lefuttatjuk a gyökkeresõ iterációs eljárást (intervallum
% felezés) kétszer (a két metszéspontot megkeresve). A kapott két pont
% legyen a és b.
% 5. lépés Lefuttatjuk az integrált számoló eljárást, megkapva a területet
% (pozitív szám!).
% A felada megoldásakor a következõ fájlok keletkeztek:
% - f.m és g.m
% - ábra.jpg ( a két függvény ábrája)
% - fg.m
% - integralas.m (a futtató utasítások)

% Mintafeladat
% Számolja ki az exp(3cos(c)) és a x^4-6x-4 függvények által közrezárt
% korlátos síkidom területét.

% 1. lépés létrehozuk f .m és g.m fájlokban az f és a g függvényeket
% 2. lépés ábrázolunk

fplot(@f)
hold on
fplot(@g)
hold off
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.XLim = [-5 5]
ax.YLim = [-10 10]

% Az ábrán látható, hogy az elsõ metszéspont [-1,0] intervallumon, a
% második az [1,3] intervallumon van. A két függvény közül az f a nagyobb
% az adott intervallumon.

% 3. lépés fg.m fájl elkészítése

% 4. lépés metszéspontok megkeresése intervallumfelezõ eljárás segítségével
% (ugyanabban a mappában kell lennie, ahol az fg.m és az integralas.m fájl
% van).

intfel(@fg,-1,0,10^-4)
intfel(@fg,1,3,10^-4)

% a két megoldás: 
% a = -0.666321 (14 lépés után)
% b = 1.947205 (15 lépés után)

% 5. lépés az integrálás lefuttatása 100 részre osztva z intervallumot

trapez(@fg,-0.666321,1.947205)

% A megoldás: T = 14.749968

% Simpson szabállyal 50szer alkalmazva az elemi szabályt

simpson(@fg,-0.666321,1.947205)

% A megoldás: T = 14.751830
