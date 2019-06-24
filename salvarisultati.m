clear variables
close all

valueSezval = 50;
valueAlfa = 70;
valueDemand = 10;
valueSezpiezo = 1900;
filename = ['sv',num2str(valueSezval),'a',num2str(valueAlfa),'d',num2str(valueDemand),'sp',num2str(valueSezpiezo)];
load(['WS',filename,'.mat']);
%Input:WS, Output: TS

offset=50;
idx = find(vetT>=tStep,1);

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


if min(diff(vetT))<max(diff(vetT))
    tSamp = round(mean(diff(vetT)));
    disp(['Ricampiono a ', num2str(tSamp), 's']);
    vetTUniform = tSamp*(0:numel(vetT)-1);
    alfa = resample(alfa,vetTUniform);
    h = resample(h,vetTUniform);
end

WDS = struct('N',N,'scabrezza', scabrezza, 'diametro', Ddato, 'c', c, 'sezval', sezval, 'sezpiezo', sezpiezo, 'Velreg', Velreg, 'deltaX', deltaX);
WP = struct('alfa',mean(alfa.data(1:idx2)),'H',mean(serbatoio),'D',mean(portata),'h',mean(h.data(1:idx2)));
film = struct('N',N, 'Tfin', Tfin, 'H', Hcampionato, 'Q',Qcampionato);

subplot(2,1,1);
plot(alfa);
subplot(2,1,2);
plot(h);

save(['TS',filename,'.mat'],'film','WP','WDS','alfa','h','tStep');