%valutazioniG confronta i dati predetti con i dati della simulazione.
%-carica un workspace TAUsvXXaXXdXXspXXXX[N].mat contenente i dati 
%topologici
%-identifico il modello G del sistema attraverso una regressione lineare 


clear variables;
close all;

%carico un workspace TAUsvXXaXXdXXspXXXX[N].mat
valueSezval = 50;
valueAlfa = 69;
valueDemand = 0.10;
valueSezpiezo = 1000;
segno = 'N';
filename = ['sv',num2str(valueSezval),'a',num2str(valueAlfa),'d',num2str(valueDemand*100),'sp',num2str(valueSezpiezo),segno];
load(['workspaces/TAU',filename,'.mat']);

%Regressione lineare per trovare i parametri theta di G
[phi,y] = calcolaPhiEY(dalfa, dh, tauPiuVR);
theta = pinv(phi)*y;

%Calcolo G
G = calcolaG(theta, tauPiuVR);

%Plotto Bode
figure(1)
[mag,phase,wout] = bode(G);
subplot(2,1,1)
semilogx(wout, 20*log10(squeeze(mag)), 'LineWidth',2)
grid
subplot(2,1,2)
semilogx(wout, squeeze(phase), 'LineWidth',2)
grid
title('Bode di G');

%Plotto Nyquist
figure(2);
nyquist(G);
grid on;

%Plotto il confronto tra il modello predetto e la simulazione
figure(3);
[y,fit, cod, rmse] = compareSOD(G, dalfa, dh);
title(['SezVal=',num2str(WDS.sezval),', alfa=',num2str(valueAlfa/100),', D=',num2str(valueDemand),', SezPiezo=',num2str(valueSezpiezo)]);

%salvo nel formato IDsvXXaXXdXXspXXXX[N].mat
filename = ['sv',num2str(WDS.sezval),'a',num2str(WP.alfa*100),'d',num2str(WP.D*100),'sp',num2str(WDS.sezpiezo),segno];
savefig(['figures/PicSim',filename,'.fig']);
save(['workspaces/ID',filename,'.mat']);