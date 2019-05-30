clear all
close all
load WSsezval300.mat
filename = 'TSsezval300.mat'
offset=0;
idx = find(vetT>=Tstep,1);

vetT = vetT(idx-offset:end);
vetT = vetT-vetT(1);
veta = veta(idx-offset:end);
vetH = vetH(idx-offset:end);

diffa = diff(veta);
idx2 = find(max(diffa)==diffa);
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

WDS = struct('N',N,'scabrezza', scabrezza, 'diametro', Ddato, 'c', c, 'sezval', sezval, 'sezpiezo', sezpiezo, 'Velreg', Velreg, 'deltaX', deltaX);
WP = struct('alfa',mean(alfa.data(1:idx2)),'H',mean(serbatoio),'D',mean(portata),'h',mean(h.data(1:idx2)));
film = struct('N',N, 'Tfin', Tfin, 'H', Hcampionato, 'Q',Qcampionato);

subplot(2,1,1);
plot(alfa);

subplot(2,1,2);
plot(h);

save(filename,'film','WP','WDS','alfa','h');