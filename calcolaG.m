function G = calcolaG(theta, tau)
    s = tf('s');
    G = tf(0);
    for i=1:numel(theta)
        G = G + theta(i)*exp(-s*tau(i));
    end
end

