%roundTau arrotonda ogni componente di un vettore ad un multiplo di una
%costante.
%   
%   TAUROUNDEND = roundTau(TAU, TSAMP)
function tauRounded = roundTau(tau, tSamp)
    tauRounded = unique(round(tau/tSamp)*tSamp,'first');
    
end

