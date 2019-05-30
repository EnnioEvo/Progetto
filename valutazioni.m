clear all
load TSsezval300.mat
filename = 'TAUsezval300.mat';
dh = tserieVariazioni(h,WP.h);
dalfa = tserieVariazioni(alfa,WP.alfa);


%rilevo nel vettore h.data le variazioni tra un elemento e
%il successivo maggiori di thresholdWave, t.
thresholdWave = 0.3;
thresholdTime = 10;
tauObservedRaw = h.time(find(h.data(1:end-1) - h.data(2:end)>0.3))';
tauObserved = [tauObservedRaw(1),tauObservedRaw(find(tauObservedRaw(2:end)-tauObservedRaw(1:end-1)>thresholdTime)+1)]
%calcolo i ritardi
[tauPiuV, tauPiuS, tauMenoV, tauMenoS] = (calcolaTau(5,WDS));
%mixo i vettori tauPiuV e tauMenoV
tauV(1:2:2*numel(tauPiuV)) = tauPiuV;
tauV(2:2:end) = tauMenoV;
%mixo i vettori tauPiuS e tauMenoS
tauS(1:2:2*numel(tauPiuS)) = tauPiuS;
tauS(2:2:end) = tauMenoS;

tauV
tauS

save(filename, 'tauObserved', 'tauV', 'tauS');
