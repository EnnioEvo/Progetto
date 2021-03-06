%salvarisultati estrapola i risultati della simulazione acquedottoOL.m e li
%riorganizza.
%-carica un workspace WSsvXXaXXdXXspXXXX.mat contenente le variabili topologiche
% e del working point desiderate, calcolate durante la simulazione.
%-seleziona il periodo precedente allo scalino
%-crea due timeseries della sezione della valvola e della pressione nella
%sezione piezometrica
%-le ricampiona
%-salva: le caratteristiche topologiche nella struttura WDS
%        il working point nella struttura WP
%       l'occorrente per riprodurre visivamente la simulazione nella
%           struttura film
%-esegue il plot delle timeseriese
%in un file TSsvXXaXXdXXspXXXX.mat

clear variables
close all

%carico un workspace WSsvXXaXXdXXspXXXX[N].mat
valueSezval = 300;
valueAlfa = 69;
valueDemand = 0.10;
valueSezpiezo = 1000;
segno = '';
filename = ['sv',num2str(valueSezval),'a',num2str(valueAlfa),'d',num2str(valueDemand*100),'sp',num2str(valueSezpiezo),segno];
load(['workspaces/WS',filename,'.mat']);
%Input:WS, Output: TS

%Seleziono un tempo limitato prima dello
offset=50;
idx = find(vetT>=tStep,1);

vetT = vetT(idx-offset:end);
vetT = vetT-vetT(1);
veta = veta(idx-offset:end);
vetH = vetH(idx-offset:end);

%trovo il tempo a cui � applicato un ingresso a scalino
diffa = diff(veta);
idx2 = find(max(abs(diffa))==abs(diffa));
tScalino = vetT(idx2);

%costruisco le due timeseres alfa e h
e = tsdata.event('Scalino',tScalino);
alfa = timeseries(veta, vetT);
alfa.name = 'alfa';
alfa.datainfo.units = '-';
addevent(alfa,e);
h = timeseries(vetH, vetT);
h.name = 'h';
h.datainfo.units = 'm';
addevent(h,e);

%ricampiono
resampleTS(h,alfa);

%salvo in tre strutture la topologia, il punto di lavoro e l'occorrente per
%il filmino
WDS = struct('N',N,'scabrezza', scabrezza, 'diametro', Ddato, 'c', c, 'sezval', sezval, 'sezpiezo', sezpiezo, 'Velreg', Velreg, 'deltaX', deltaX);
WP = struct('alfa',mean(alfa.data(1:idx2-1)),'H',mean(serbatoio),'D',mean(portata),'h',mean(h.data(1:idx2)));
film = struct('N',N, 'Tfin', Tfin, 'H', Hcampionato, 'Q',Qcampionato);

%plotto le due timeseries
subplot(2,1,1);
plot(alfa,'LineWidth',2);
grid on
subplot(2,1,2);
plot(h,'LineWidth',2);
grid on

%salvo nel formato TSsvXXaXXdXXspXXXX[N].mat
filename = ['sv',num2str(WDS.sezval),'a',num2str(WP.alfa*100),'d',num2str(WP.D*100),'sp',num2str(WDS.sezpiezo),segno];
save(['workspaces/TS',filename,'.mat'],'film','WP','WDS','alfa','h','tStep');