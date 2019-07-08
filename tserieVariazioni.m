%tserieVariazioni calcola a partire da una timeserie TSIN la timeserie DTS
%delle variazioni rispetto ad uno scalare.
%
%   DTS = tserieVariazioni(TSIN,SCALAR).
function dTs = tserieVariazioni(tsIn,scalar)
    dTs = tsIn;
    dTs.data = dTs.data - scalar;
    dTs.name = ['d',dTs.name];
end