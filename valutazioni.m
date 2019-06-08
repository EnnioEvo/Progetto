clear all
load TSsezval50alfa67.mat
filename = 'TAUsezval50alfa67.mat';
dh = tserieVariazioni(h,WP.h);
dalfa = tserieVariazioni(alfa,WP.alfa);
nTau = 5; %numero di tau da calcolare
tSamp = h.time(2)-h.time(1);

%rilevo nel vettore h.data le variazioni tra un elemento e
%il successivo maggiori di thresholdWave e distanti almeno t.
%thresholdWave = 0.3;
%thresholdTime = 10;
%tauObserved = dh.time(find(abs(diff(dh.data))>thresholdWave))'
%tauObserved = [tauObservedRaw(1),tauObservedRaw(find(tauObservedRaw(2:end)-tauObservedRaw(1:end-1)>thresholdTime)+1)]
%calcolo i ritardi
[tauPiuV, tauMenoV, tauPiuS, tauMenoS] = calcolaTau(nTau,WDS);

tauPiuV = roundTau(tauPiuV,tSamp);
tauMenoV = roundTau(tauMenoV,tSamp);
tauPiuS = roundTau(tauPiuS,tSamp);
tauMenoS = roundTau(tauMenoS,tSamp);
%tauCalcolati = sort([tauPiuV,tauMenoV,tauPiuS,tauMenoS]);

trovaInDhTime = @(x)find(dh.time==x,1);
idxTauPiuV = cell2mat(arrayfun(trovaInDhTime , tauPiuV, 'un', 0));
idxTauMenoV = cell2mat(arrayfun(trovaInDhTime , tauMenoV, 'un', 0));
idxTauPiuS = cell2mat(arrayfun(trovaInDhTime , tauPiuS, 'un', 0));
idxTauMenoS = cell2mat(arrayfun(trovaInDhTime , tauMenoS, 'un', 0));

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);
subplot(3,1,[1,2]);
plot(dh);
hold on
plot(dh.time(tauPiuV),dh.data(tauPiuV),'ro','MarkerEdgeColor','red');
hold on
plot(dh.time(tauMenoV),dh.data(tauMenoV),'ro','MarkerEdgeColor','magenta');
hold on
plot(dh.time(tauPiuS),dh.data(tauPiuS),'rs','MarkerEdgeColor','blue');
hold on
plot(dh.time(tauMenoS),dh.data(tauMenoS),'rs','MarkerEdgeColor','cyan');
legend('Simulazione','Valvola+','Valvola-','Serbatoio+','Serbatoio-');
hold off
subplot(3,1,3);
plot(dalfa);

save(filename,'tauPiuV', 'tauPiuS', 'tauMenoV', 'tauMenoS');
