function [y,fit, cod, rmse] = compareSOD(G, dalfa, dh)
   
    y = lsim(G, dalfa.data, dalfa.time);
    
    rmse = sqrt(mean((dh.data - y).^2));
    cod = 1 - norm(dh.data-y)^2/norm(dh.data-mean(dh.data))^2;
    fit = 100*(1 - norm(dh.data - y)/norm(y-mean(y)));
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.4, 0.6]);
    plot(dalfa.time,y,'red','LineWidth',2);
    title(['Simulazione, RMSE=',num2str(rmse),', COD=',num2str(cod), ' FIT=',num2str(fit)]);
    hold on
    grid on
    plot(dh,'--','Color','blue','LineWidth',2);
    legend('Model Prediction','Identification Data');
end

