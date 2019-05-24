filename = 'prova1.mat'

tScalino = find(veta == (veta(1) + DeltaA));
tScalino = tScalino(1); 
vetT = vetT(tScalino-2:end);
veta = veta(tScalino-2:end);
vetH = vetH(tScalino-2:end);

e = tsdata.event('Scalino',1);
alfa = timeseries(veta, vetT);
alfa.name = 'alfa';
alfa.datainfo.units = '-';
addevent(alfa,e);
h = timeseries(vetH, vetT);
h.name = 'h';
h.datainfo.units = 'm';
addevent(h,e);

WDS = struct('N',N,'scabrezza', scabrezza, 'diametro', Ddato, 'c', c, 'sezval', sezval, 'sezpiezo', sezpiezo, 'Velreg', Velreg, 'deltaX', deltaX);
WP = struct('alfa',a,'H',mean(serbatoio),'D',mean(portata),'h',mean(vetH));
film = struct('N',N, 'Tfin', Tfin, 'H', Hcampionato, 'Q',Qcampionato);

vetT(find( Hcampionato(sezpiezo,1:end-1) - Hcampionato(sezpiezo,2:end)>0.3))
[tau1,tau2] = calcolaTau(5,WDS)

subplot(2,1,1);
plot(alfa);
title('alfa della valvola nel tempo')

subplot(2,1,2);
plot(h);
title('Pressione h nel tempo')

save(filename,'film','WP','WDS');