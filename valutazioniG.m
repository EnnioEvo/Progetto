clear variables;
close all;

valueSezval = 50;
valueAlfa = 69;
valueDemand = 0.10;
valueSezpiezo = 1000;
segno = 'N';
filename = ['sv',num2str(valueSezval),'a',num2str(valueAlfa),'d',num2str(valueDemand*100),'sp',num2str(valueSezpiezo),segno];
load(['TAU',filename,'.mat']);

[phi,y] = calcolaPhiEY(dalfa, dh, tauPiuVR);
theta = pinv(phi)*y;
    
G = calcolaG(theta, tauPiuVR);

figure(1)
bode(G);
grid on;
title('Bode di G');

figure(2);
[y,fit, cod, rmse] = compareSOD(G, dalfa, dh);
title(['SezVal=',num2str(valueSezval),', alfa=',num2str(valueAlfa/100),', D=',num2str(valueDemand),', SezPiezo=',num2str(valueSezpiezo)]);

figure(3);
nyquist(G);

filename = ['sv',num2str(valueSezval),'a',num2str(valueAlfa),'d',num2str(valueDemand*100),'sp',num2str(valueSezpiezo),segno];
savefig(['PicSim',filename,'.fig']);
save(['SIM',filename,'.mat']);