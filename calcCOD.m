%calcCOD(data,sim) Calcolo il coefficiente di determinazione COD
function cod = calcCOD(data,sim)
    cod = 1 - norm(data-sim)^2/norm(data-mean(data))^2;
    
end

