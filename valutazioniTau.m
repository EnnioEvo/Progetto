clear variables;
valuesSezval = 50;
valuesAlfa = 70;
valueDemand = 10;
valueSezpiezo = 1900;

%Input:TS, Output: TAU

count = 1;
for valueSezval = valuesSezval
    for valueAlfa = valuesAlfa
        
        filename = ['sv',num2str(valueSezval),'a',num2str(valueAlfa),'d',num2str(valueDemand),'sp',num2str(valueSezpiezo)];
        load(['TS',filename,'.mat']);
        
        
        dh = tserieVariazioni(h,WP.h);
        dalfa = tserieVariazioni(alfa,WP.alfa);
        nTau = 6; %numero di tau da calcolare
        tSamp = h.time(2)-h.time(1);

        %calcolo i ritardi
        [tauPiuV, tauMenoV, tauPiuS, tauMenoS] = calcolaTau(nTau,WDS);
        %approssimo i ritardi al tempo di campionamento
        tauPiuVR = roundTau(tauPiuV,tSamp);
        tauMenoVR = roundTau(tauMenoV,tSamp);
        tauPiuSR = roundTau(tauPiuS,tSamp);
        tauMenoSR = roundTau(tauMenoS,tSamp);
        tStep = roundTau(tStep, tSamp);
        
        %plotto i ritardi calcolati sopra il plot di h
        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);
        subplot(numel(valuesSezval),numel(valuesAlfa),count);
        plotTau(dh,tStep, tauPiuVR, 'ro', 'red', tauMenoVR, 'ro', 'magenta', tauPiuSR, 'rs', 'blue', tauMenoSR, 'rs', 'cyan');
        
        if count == 1
            legend('Simulazione','Valvola+','Valvola-','Serbatoio+','Serbatoio-');
        end
        count = count + 1;
        
        save(['TAU',filename,'.mat'],'dalfa','dh','tStep','tauPiuVR', 'tauPiuSR', 'tauMenoVR', 'tauMenoSR');
    end
end
