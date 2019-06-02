function [tau] = mixTau(tauPiu,tauMeno)
    tau(1:2:2*numel(tauPiu)) = tauPiu;
    tau(2:2:end) = tauMeno;
end

