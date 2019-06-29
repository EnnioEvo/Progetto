function [phi,y] = calcolaPhiEY(dalfa,dh, tau)
    
%   Controllo il campionamento di dalfa e dh
%   tSamp = round(mean(diff(dh.time)));
%    if min(diff(dh.time))<max(diff(dh.time))
%        disp(['Ricampiono a ', num2str(tSamp), 's']);
%        vetTUniform = tSamp*(0:numel(dh.time)-1);
%        dalfa = resample(dalfa,vetTUniform);
%        dh = resample(dh,vetTUniform);
%    end
   
    resampleTS(dalfa,dh);
    tSamp = round(mean(diff(dh.time)));
    %Ricampiono tau in ogni caso
    tau = roundTau(tau,tSamp);
    
    %tauPiuVR = tauPiuVR(1:4);
    %trovaXInDhTime = @(x)find(dh.time==x,1); %sostituire con una divisione
    %idxTauPiuV = cell2mat(arrayfun(trovaXInDhTime , tauPiuVR, 'un', 0));
    idxTau = tau/tSamp + 1;
    
    u = dalfa.data;
    y = dh.data;
    
    phi = zeros(numel(dalfa.data),numel(tau));
    for i=1:numel(tau)
        phi(idxTau(i)+1:end,i)=u(1:end-idxTau(i));
    end
    
end

