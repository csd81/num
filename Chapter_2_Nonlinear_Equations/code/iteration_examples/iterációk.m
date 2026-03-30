% Iterációs eljárások 
% Általánosságban a ffeladatok megoldási lépései a következõk
% 1. Ábrázoljuk a függvény(eke)t
% 2. Ábra segítségével futtatjuk az eljárást
% Feltételezem, hogy az eljárások ismertek és a Matlab alapokkal tisztában van mindenki
% Ebben a fájlban egy feladaton keresztül mutatom meg a 4 gyökkeresõ
% iterációs eljárást

% A feladat:
% Keresse meg az alábbi függvények metszéspontjait!
%e^x*actg(x) és az x^4 + 2x - 1 függvények
% Intervallumfelezés módszere

% Külön fájlokba (f.m és g.m) hozzuk létre a két függvényt 
function y=f(x)
  y=exp(x)*atan(x);
end
function y=g(x)
  y=x^4+2*x-1;
end

% Ábrázoljuk a két függvényt közös koordináta rendszerbena következõ
% utasítással

fplot(@f)
hold on
fplot(@g)
hold off
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.XLim = [-5 5]
ax.YLim = [-10 10]

% Látható, hogy két metszéspontja van a függvényeknek, egyik -2 és -1
% között, a másik0 és 2 között

% Az elkészült képet mentsük el fg.jpg formátumban

% Készítsük el a gyökkeresõ algoritmusokhoz a függvényt (0-ra rendezett
% alak)

function y=fg(x)
  y=exp(x)*atan(x)-(x^4+2*x-1);
end

% Futtassuk le két intervallumon a z eljárást
% Az intervallumfelezõ és a Húr módszer futtatása között nincs különbség

disp('Intervallumfelezõ módszer')
disp('1. metszéspont')
intfel(@fg,-2,-1,10^-4)
disp('2. metszéspont')
intfel(@fg,0,2,10^-4)
disp('húrmódszer')
disp('1. metszéspont')
hur(@fg,-2,-1,10^-4)
disp('2. metszéspont')
hur(@fg,0,2,10^-4)

% A kapott metszéspontok:
% itervallumfelezõ módszer:
% 14 lépés -1.367371
% 15 lépés 1.049500
% Húrmódszer
% 18 lépés -1.367316
% 39 lépés 1.049489

% Newton módszer

% A megoldás eleje hasonló az elõzõhöz. A paraméterezésben tér el, 
% mivel itt kezdõpontot kell megadni, 
% illetve szükségünk lesz a függvény deriváltjára.
% 
% Készítsük el az fg függvény deriváltját a dfg.m fájlba

function y=dfg(x)
  y=exp(x)*(atan(x)+1/(1+x^2))-(4*x^3+2);
end

% Futtatáskor 3 paramétert kér a függvény: 
% fg - függvény
% dfg - a deriváltja
% 10^-4 - megoldás pontossága

%Futtatás közben fogja kérni a kezdpõpontot
%(fontos, hogy ameddig nem adjuk meg, addig nem csinál semmit a Matlab).

newton(@fg,@dfg,10^-4)

% Kétszer lefuttatva az eljárást a következõ eredményeket kapjuk:
% -1 kezdõponttal futtatva: 5 lépés -1.367332
% 1 kezdõponttal futtatva: 2 lépés után 1.049547

% Szelõmódszer

% Hasonló az elsõ kettõhöz, de itt tetszõleges kezdõ intervallumot használhatunk, ahol a függvény értelmezve van.
% A kezdõ intervallumot futás közben kell megadnunk:

szelo(@fg,10^-4)

% Kétszer futtatva szándékoltan nem túl közeli intervallumot választva:
% [-5 -3] intervallumból futtatva: 9 lépés  -1.367326
% [5 10] intervallumból futtatva: 14 lépés 1.049517

