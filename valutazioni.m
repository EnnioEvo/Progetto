%rilevo nel vettore Hcampionato(sezpiezo,:) le variazioni tra un elemento e
%il successivo maggiori di una certa quantità.
tauOsservati = vetT(find( Hcampionato(sezpiezo,1:end-1) - Hcampionato(sezpiezo,2:end)>0.3))-9
%calcolo i ritardi
[tauPiuV, tauPiuS, tauMenoV, tauMenoS] = (calcolaTau(5,WDS))

