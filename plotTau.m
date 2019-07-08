%plotTau plotta uno o più vettori di ritardi in sovraimpressione al plot
%della timeserie variazione di pressione dh.
%
%   plotTau(DH, TSTEP, TAU, MARKERTYPE, MARKERCOLOR) plotta un solo vettore
%   di ritardi.
%
%   plotTau(DH, TSTEP, TAU, MARKERTYPE1, MARKERCOLOR1, TAU2, MARKERTYPE2, 
%   MARKERCOLOR2) plotta due vettori di ritardi.
%
%   plotTau(DH, TSTEP, TAU1, MT1, MC1, ... , tauN, MTN, MCN) plotta N
%   vettori dei ritardi.
%
%   Esempio
%   plotTau(dh, tstep, tau1, 'ro', 'red').

function [] = plotTau(varargin)
    nTau = (nargin - 2)/3;
    %Controllo che nargin = 2 + 3k, con k>0
    if (nTau ~= round(nTau))||(nTau<=0)
       disp("Gli argomenti sono nel formato sbagliato.");
       return;
    end
    
    %rinomino gli argomenti
    dh = varargin{1};
    tStep = varargin{2};
    
    %trovo l'indice di tStep nel vettore dei tempi
    idxTStep = tStep/(dh.time(2)-dh.time(1))+1;
    
    %plotto la timeSerie
    plot(dh,'LineWidth',2);
    hold on
    
    for i=1:nTau
        tau = varargin{3*i};
        type = varargin{3*i + 1};
        color = varargin{3*i + 2};
        idxTau = tau/(dh.time(2)-dh.time(1)) + 1;
        plot(dh.time(idxTau+idxTStep-1),dh.data(idxTau+idxTStep-1),type,'MarkerEdgeColor',color,'LineWidth',2);
        hold on
    end
    hold off
end

