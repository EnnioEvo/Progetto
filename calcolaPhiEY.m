%calcolaPhiEY calcolo i due elementi necessari per la regressione lineare.
%
%   [PHI,Y] = calcolaPhiEY(DALFA, DH, TAU) supposto che DH sia ottenuto
%   come una somma di DALFA ritardati nel tempo, un contributo per ogni
%   ritardo nel vettore TAU, calcolo i parametri necessari alla regressione
%   lineare e quindi a trovare il coefficiente di ogni contributo.

function [phi,y] = calcolaPhiEY(dalfa,dh, tau)
    
%   Cancellare se funziona
%   Controllo il campionamento di dalfa e dh
%   tSamp = round(mean(diff(dh.time)));
%    if min(diff(dh.time))<max(diff(dh.time))
%        disp(['Ricampiono a ', num2str(tSamp), 's']);
%        vetTUniform = tSamp*(0:numel(dh.time)-1);
%        dalfa = resample(dalfa,vetTUniform);
%        dh = resample(dh,vetTUniform);
%    end
   
    %ricampiono per sicurezza
    resampleTS(dalfa,dh);
    tSamp = round(mean(diff(dh.time)));
    tau = roundTau(tau,tSamp);
    
    %trovo l'indice di tau in dh.time
    idxTau = tau/tSamp + 1;
    
    %rinomino per chiarezza
    u = dalfa.data;
    y = dh.data;
    
    phi = zeros(numel(dalfa.data),numel(tau));
    for i=1:numel(tau)
        phi(idxTau(i)+1:end,i)=u(1:end-idxTau(i));
    end
    
end

