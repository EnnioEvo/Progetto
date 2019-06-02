function [tauPiuVR, tauPiuSR, tauMenoVR, tauMenoSR] = roundTau(tauPiuV, tauPiuS, tauMenoV, tauMenoS, tSamp)
    round1vector = @(tau)unique(round(tau/tSamp)*tSamp,'first');
    
    tauPiuVR = round1vector(tauPiuV);
    tauPiuSR = round1vector(tauPiuS);
    tauMenoVR = round1vector(tauMenoV);
    tauMenoSR = round1vector(tauMenoS);
    
end

