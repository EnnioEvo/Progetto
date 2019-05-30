clear all
load prova1.mat
dh = tserieVariazioni(h,WP.h);
dalfa = tserieVariazioni(alfa,WP.alfa);


%rilevo nel vettore Hcampionato(sezpiezo,:) le variazioni tra un elemento e
%il successivo maggiori di una certa quantità.
tauOsservati = h.time(find(h.data(1:end-1) - h.data(2:end)>0.3))
%calcolo i ritardi
[tauPiuV, tauPiuS, tauMenoV, tauMenoS] = (calcolaTau(5,WDS))

