%Eliminációs elárások egyenletrendszerek megoldására
%Gauss elimináció
%A kapott egyenletrendszer egyik oldalából képezzünk un. együttható
%mátrixot (el elsz A paraméter). A másik oldalból képezzünk egy
%oszlopvektort (b paraméter). Fontos, hogy A négyzetes mátrix, b pedig
%oszlopvektor legyen.
% Képzésük:

A=[1,1,-1,1;2,1,-1,-1;1,-2,-2,3;1,1,-1,-2];
b=[8,3,12,0]';

%Az elkészült paraméterekkel futtassuk le az eljárást
gauss(A,b)

%Az egyenetrendszer megoldása a végén kapott 4 érték lesz, vagyis :
%x1=0.3333
%x2=1.5833
%x3=-3.4167 
%x4=2.6667

%Az eljárás hátránya, ha a lépések közben a fõátlóban bárhol 0 érték lesz, akkor
%a megoldás nem kapható meg. Ennek kiküszöbölésére használjuk a
%fõelemkiválasztásos stratégiákat. A Részleges fõelemkiválasztásos Gauss
%elimináció a rgauss.m fálban, a teljes fõelemkiválasztásos a tgauss.m
%fájlban található. A futtatáskor szükséges paraméterek megegyeznek a Gauss
%elemináció paramétereivel
%--------------------
%Példa a  Részleges fõelemkiválasztásos Gauss
%eliminációra
A=[3,1,2,-3;2,0,3,-3;1,1,1,0;1,-4,1,3];
b=[-2,-4,0,3]';
rgauss(A,b)
%--------------------
% A  teljes fõelemkiválasztásos Gauss
%elimináció esetében oszlopok cseréje is megengedett, ezért a végeredmény
%két vektor lesz. Az elsõ tartalmazza a változók sorrendjét, a második
%pedig a megoldást.

A=[1,1,0,3;2,1,-1,1;3,-1,-1,2;-1,2,3,-1];
b=[4,1,-3,4]';
tgauss(A,b)

%A kapott megoldás tehát:
%x1=-1
%x2=2
%x3=0 
%x4=1
%--------------------

%A Gauss Jordan elemináció hasonlóan mûködik, mint a Gauss, de itt az utolsó
%lépésben megkapott mátrixból olvasható ki a megoldás.
GaussJordan(A,b)

%A Gauss-Jordan elimiáció némi átalakítás után használható mártix
%invertálásra is(minv.m). A mátrixnak négyzetesnek kell lennie. Az inv
%utasítás a Matlab beépített utasítása mátrixok invertálására.
minv(A)
inv(A)

%----------------------------------------------
%A feladatok megoldása során elegendõ 3 sort beírni egy különálló fájlba
%(pl. eleminaci.m). Ez a három sor az együtthatókból képzett "A" mártix, az
%egyenletrendszer másik oldalából képzett "b" oszlopvektor, illetve a
%futtatóparancs. Ennek a fájlnak kell egy könyvtárban lennie a használt
%eljárást tartalmazó fájllal.
