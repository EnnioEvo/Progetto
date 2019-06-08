function tauRounded = roundTau(tau, tSamp)
    tauRounded = unique(round(tau/tSamp)*tSamp,'first');
    
end

