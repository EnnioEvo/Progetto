function [tauPiuV, tauMenoV, tauPiuS, tauMenoS] = calcolaTau(tFin, wds)
    viaggioMonteSerbatoio = (wds.sezpiezo)*wds.deltaX/wds.c;
    viaggioMonteValvola = (wds.sezpiezo - wds.sezval)*wds.deltaX/wds.c;
    viaggioValle = (wds.N - wds.sezpiezo)*wds.deltaX/wds.c;
    viaggioValvolaSerbatoio = (wds.sezval)*wds.deltaX/wds.c;
    
    calcolaUnTauPiuV = @(m) viaggioMonteValvola + floor((m-1)/2)*2*(viaggioValle + viaggioMonteValvola) + mod(m+1,2)*2*viaggioValle;
    calcolaUnTauMenoV = @(m) 2*viaggioValvolaSerbatoio + calcolaUnTauPiuV(m);
    calcolaUnTauPiuS = @(m) viaggioMonteValvola + floor((m-1)/2)*2*(viaggioValle + viaggioMonteSerbatoio) + mod(m+1,2)*2*viaggioValle;
    calcolaUnTauMenoS = @(m) 2*viaggioValvolaSerbatoio + calcolaUnTauPiuS(m);
    
    tauPiuV = calcolaUnTauPiuV(1:n); 
    tauMenoV = calcolaUnTauMenoV(1:n);
    tauPiuS = calcolaUnTauPiuS(1:n);
    tauMenoS = calcolaUnTauMenoS(1:n);
end