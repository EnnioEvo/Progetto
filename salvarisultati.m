clear variables
close all

valueSezval = 300;
valueAlfa = 69;
valueDemand = 0.10;
valueSezpiezo = 1000;
segno = '';
filename = ['sv',num2str(valueSezval),'a',num2str(valueAlfa),'d',num2str(valueDemand*100),'sp',num2str(valueSezpiezo),segno];
load(['WS',filename,'.mat']);
%Input:WS, Output: TS

offset=50;
idx = find(vetT>=tStep,1);

vetT = vetT(idx-offset:end);
vetT = vetT-vetT(1);
veta = veta(idx-offset:end);
vetH = vetH(idx-offset:end);

diffa = diff(veta);
idx2 = find(max(abs(diffa))==abs(diffa));
tScalino = vetT(idx2);

e = tsdata.event('Scalino',tScalino);
alfa = timeseries(veta, vetT);
alfa.name = 'alfa';
alfa.datainfo.units = '-';
addevent(alfa,e);
h = timeseries(vetH, vetT);
h.name = 'h';
h.datainfo.units = 'm';
addevent(h,e);

resampleTS(h,alfa);

WDS = struct('N',N,'scabrezza', scabrezza, 'diametro', Ddato, 'c', c, 'sezval', sezval, 'sezpiezo', sezpiezo, 'Velreg', Velreg, 'deltaX', deltaX);
WP = struct('alfa',mean(alfa.data(1:idx2)),'H',mean(serbatoio),'D',mean(portata),'h',mean(h.data(1:idx2)));
film = struct('N',N, 'Tfin', Tfin, 'H', Hcampionato, 'Q',Qcampionato);

subplot(2,1,1);
plot(alfa);
grid on
subplot(2,1,2);
plot(h);
grid on

filename = ['sv',num2str(valueSezval),'a',num2str(valueAlfa),'d',num2str(valueDemand*100),'sp',num2str(valueSezpiezo),segno];
save(['TS',filename,'.mat'],'film','WP','WDS','alfa','h','tStep');