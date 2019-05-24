function [tauPiu, tauMeno] = calcolaTau(n, wds)
    viaggioMonte = (wds.sezpiezo - wds.sezval)*wds.deltaX/wds.c;
    viaggioValle = (wds.N - wds.sezpiezo)*wds.deltaX/wds.c;
    calcolaUnTauPiu = @(m) viaggioMonte + (m-1)*2*(viaggioValle + viaggioMonte);
    calcolaUnTauMeno = @(m) calcolaUnTauPiu(m) + 2*(viaggioValle);
    tauPiu = calcolaUnTauPiu(1:ceil(n/2));
    tauMeno = calcolaUnTauMeno(1:floor(n/2));
end