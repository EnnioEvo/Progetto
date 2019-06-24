function [phi,y] = calcolaPhiEY(dalfa,dh, tauPiuVR)

   %Controllo il campionamento di dalfa e dh
   tSamp = round(mean(diff(dh.time)));
   if min(diff(dh.time))<max(diff(dh.time))
        disp(['Ricampiono a ', num2str(tSamp), 's']);
        vetTUniform = tSamp*(0:numel(dh.time)-1);
        dalfa = resample(dalfa,vetTUniform);
        dh = resample(dh,vetTUniform);
   end
   
   %Ricampiono tau in ogni caso
   tauPiuVR = roundTau(tauPiuVR,tSamp);
    
    %tauPiuVR = tauPiuVR(1:4);
    %trovaXInDhTime = @(x)find(dh.time==x,1); %sostituire con una divisione
    %idxTauPiuV = cell2mat(arrayfun(trovaXInDhTime , tauPiuVR, 'un', 0));
    idxTauPiuV = tauPiuVR/tSamp + 1;
    
    u = dalfa.data;
    y = dh.data;
    
    phi = zeros(numel(dalfa.data),numel(tauPiuVR));
    for i=1:numel(tauPiuVR)
        phi(idxTauPiuV(i)+1:end,i)=u(1:end-idxTauPiuV(i));
    end
    
end

