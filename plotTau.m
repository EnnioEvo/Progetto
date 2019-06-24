function [] = plotTau(dh, tStep, tauPiuVR, typePV, colorPV, tauMenoVR, typeMV, colorMV, tauPiuSR, typePS, colorPS, tauMenoSR, typeMS, colorMS)
    
    trovaXInDhTime = @(x)find(dh.time==x,1);
    idxTauPiuV = cell2mat(arrayfun(trovaXInDhTime , tauPiuVR, 'un', 0));
    idxTauMenoV = cell2mat(arrayfun(trovaXInDhTime , tauMenoVR, 'un', 0));
    idxTauPiuS = cell2mat(arrayfun(trovaXInDhTime , tauPiuSR, 'un', 0));
    idxTauMenoS = cell2mat(arrayfun(trovaXInDhTime , tauMenoSR, 'un', 0));
    idxTStep = trovaXInDhTime(tStep);
    
    plot(dh);
    hold on
    plot(dh.time(idxTauPiuV+idxTStep),dh.data(idxTauPiuV+idxTStep),typePV,'MarkerEdgeColor',colorPV);
    hold on
    plot(dh.time(idxTauMenoV+idxTStep),dh.data(idxTauMenoV+idxTStep),typeMV,'MarkerEdgeColor',colorMV);
    hold on
    plot(dh.time(idxTauPiuS+idxTStep),dh.data(idxTauPiuS+idxTStep),typePS,'MarkerEdgeColor',colorPS);
    hold on
    plot(dh.time(idxTauMenoS+idxTStep),dh.data(idxTauMenoS+idxTStep),typeMS,'MarkerEdgeColor',colorMS);
    hold off
end

