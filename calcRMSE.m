%calcRMSE(data,sim) Calcolo dello scarto quadratico medio
function rmse = calcRMSE(data,sim)
    rmse = sqrt(mean((data - sim).^2));
end

