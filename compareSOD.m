%compareSOD confronto tra un modello lineare e una coppia ingresso uscita.
%
%   compareSOD(G,DALFA,DH) esegue il plot del dato e dell'uscita del 
%   modello.

function [y,fit, cod, rmse] = compareSOD(G, dalfa, dh)
   
    %calcolo l'output del modello in corrispondenza dell'ingresso dalfa
    y = lsim(G, dalfa.data, dalfa.time);
    
    %calcolo varie metriche di misura dell'errore
    rmse = calcRMSE(dh.data,y);
    cod = calcCOD(dh.data,y);
    fit = calcFIT(dh.data,y);
    
    %eseguo i plot sovrapposti del dato e dell'uscita del modello
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.4, 0.6]);
    plot(dalfa.time,y,'red','LineWidth',2);
    title(['Simulazione, RMSE=',num2str(rmse),', COD=',num2str(cod), ' FIT=',num2str(fit)]);
    hold on
    grid on
    plot(dh,'--','Color','blue','LineWidth',2);
    legend('Model Prediction','Identification Data');
end

