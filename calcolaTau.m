%calcolaTau calcola un vettore di ritardi per ognuno dei quattro tipi.
%
%   [tauPiuV, tauMenoV, tauPiuS, tauMenoS] = calcolaTau(tFin, wds) data una
%   struttura contenente i dati topologici della condotta calcola i
%   ritardi, ovvero il tempo in cui un onda di pressione che parta dalla
%   valvola raggiunga la seziona piezometrica. I ritardi sono classificati
%   secondo i due parametri
%   Verso di partenza:  
%       Più -> l'onda è partita verso destra
%       Meno-> l'onda è partita verso sinistra
%   Punto di riflessione verso destra dell'onda:
%       Valvola   -> l'onda viene riflessa verso destra dalla valvola
%       Serbatoio -> l'onda viene riflessa verso destra dal serbatoio
%

function [tauPiuV, tauMenoV, tauPiuS, tauMenoS] = calcolaTau(tFin, wds)

    %Ogni ritardo è combinazione lineare delle quattro seguenti costanti
    viaggioMonteSerbatoio = (wds.sezpiezo)*wds.deltaX/wds.c;
    viaggioMonteValvola = (wds.sezpiezo - wds.sezval)*wds.deltaX/wds.c;
    viaggioValle = (wds.N - wds.sezpiezo)*wds.deltaX/wds.c;
    viaggioValvolaSerbatoio = (wds.sezval)*wds.deltaX/wds.c;
    
    %Ognuna di queste funzioni calcola l'm° ritardo del suo tipo
    calcolaUnTauPiuV = @(m) viaggioMonteValvola + floor((m-1)/2)*2*(viaggioValle + viaggioMonteValvola) + mod(m+1,2)*2*viaggioValle;
    calcolaUnTauMenoV = @(m) 2*viaggioValvolaSerbatoio + calcolaUnTauPiuV(m);
    calcolaUnTauPiuS = @(m) viaggioMonteValvola + floor((m-1)/2)*2*(viaggioValle + viaggioMonteSerbatoio) + mod(m+1,2)*2*viaggioValle;
    calcolaUnTauMenoS = @(m) 2*viaggioValvolaSerbatoio + calcolaUnTauPiuS(m);
        
    tauPiuV = []; 
    tauMenoV = [];
    tauPiuS = [];
    tauMenoS = [];
    n = 1;
    while true
        %Aggiungo un ritardo fino a quando tutti non superano il valore di
        %soglia tFin
        tauPiuV = [tauPiuV,calcolaUnTauPiuV(n)]; 
        tauMenoV = [tauMenoV,calcolaUnTauMenoV(n)];
        tauPiuS = [tauPiuS,calcolaUnTauPiuS(n)];
        tauMenoS = [tauMenoS,calcolaUnTauMenoS(n)];
        if min([tauPiuV(n), tauMenoV(n), tauPiuS(n), tauMenoS(n)]) >= tFin
            break
        end
        n = n + 1;
    end
    
    %Prendo solo quelli < tFin
    tauPiuV = tauPiuV(find(tauPiuV <= tFin)); 
    tauMenoV = tauMenoV(find(tauMenoV <= tFin));
    tauPiuS = tauPiuS(find(tauPiuS <= tFin));
    tauMenoS = tauMenoS(find(tauMenoS <= tFin));
    
end