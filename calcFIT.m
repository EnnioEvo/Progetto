%calcFIT(data,sim) Calcolo il valore di misura dell'errore tra dati e
%output del modello
function fit = calcFIT(data,sim)
    fit = 100*(1 - norm(data - sim)/norm(sim-mean(sim)));
end

