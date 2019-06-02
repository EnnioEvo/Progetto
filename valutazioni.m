clear all
load TSsezval50.mat
filename = 'TAUsezval50.mat';
dh = tserieVariazioni(h,WP.h);
dalfa = tserieVariazioni(alfa,WP.alfa);
nTau = 5; %numero di tau da calcolare
tSamp = h.time(2)-h.time(1);

%rilevo nel vettore h.data le variazioni tra un elemento e
%il successivo maggiori di thresholdWave e distanti almeno t.
thresholdWave = 0.3;
thresholdTime = 10;
tauObservedRaw = dh.time(find(dh.data(1:end-1) - dh.data(2:end)>0.3))'
tauObserved = [tauObservedRaw(1),tauObservedRaw(find(tauObservedRaw(2:end)-tauObservedRaw(1:end-1)>thresholdTime)+1)]
%calcolo i ritardi
[tauPiuV, tauPiuS, tauMenoV, tauMenoS] = calcolaTau(nTau,WDS);
[tauPiuV, tauPiuS, tauMenoV, tauMenoS] = roundTau(tauPiuV, tauPiuS, tauMenoV, tauMenoS,tSamp);

%mixo i vettori per confrontarli con tauObserved
tauV = mixTau(tauPiuV,tauMenoV)
tauS = mixTau(tauPiuS,tauMenoS)


save(filename, 'tauObserved', 'tauPiuV', 'tauPiuS', 'tauMenoV', 'tauMenoS');
