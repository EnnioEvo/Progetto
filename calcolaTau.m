function [tauPiuV, tauPiuS, tauMenoV, tauMenoS] = calcolaTau(n, wds)
    viaggioMonteSerbatoio = (wds.sezpiezo - 1)*wds.deltaX/wds.c;
    viaggioMonteValvola = (wds.sezpiezo - wds.sezval)*wds.deltaX/wds.c;
    viaggioValle = (wds.N - wds.sezpiezo)*wds.deltaX/wds.c;
    
    calcolaUnTauPiuV = @(m) viaggioMonteValvola + (m-1)*2*(viaggioValle + viaggioMonteValvola);
    calcolaUnTauMenoV = @(m) calcolaUnTauPiuV(m) + 2*(viaggioValle);
    calcolaUnTauPiuS = @(m) viaggioMonteValvola + (m-1)*2*(viaggioValle + viaggioMonteSerbatoio);
    calcolaUnTauMenoS = @(m) calcolaUnTauPiuS(m) + 2*(viaggioValle);
    
    tauPiuV = calcolaUnTauPiuV(1:ceil(n/2)); %ceil(n/2)= 1->1, 2->1, 3->2, 4->2
    tauMenoV = calcolaUnTauMenoV(1:floor(n/2)); %floor(n/2) 1->0, 2->1, 3->1
    tauPiuS = calcolaUnTauPiuS(1:ceil(n/2));
    tauMenoS = calcolaUnTauMenoS(1:floor(n/2));
    
end