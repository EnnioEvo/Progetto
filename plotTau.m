function [] = plotTau(varargin)
    nTau = (nargin - 2)/3;
    if (nTau ~= round(nTau))||(nTau<=0)
       disp("Gli argomenti sono nel formato sbagliato.");
       return;
    end
    
    
    dh = varargin{1};
    tStep = varargin{2};
    trovaXInDhTime = @(x)find(dh.time==x,1);
    idxTStep = trovaXInDhTime(tStep);
    plot(dh);
    hold on
    
    for i=1:nTau
        tau = varargin{3*i};
        type = varargin{3*i + 1};
        color = varargin{3*i + 2};
        idxTau = cell2mat(arrayfun(trovaXInDhTime , tau, 'un', 0));
        plot(dh.time(idxTau+idxTStep),dh.data(idxTau+idxTStep),type,'MarkerEdgeColor',color);
        hold on
    end
    hold off
end

