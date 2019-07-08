%resampleTS ricampiono uniformemente le timeseries al tempo di
%campionamento medio più basso tra le timeseries.
%
%    TSOUT = resampleTS(TS) ricampiono al tempo medio di ts.
%    
%    [TSOUT1, TSOUT2] = resampleTS(TS1,TS2) ricampiono al tempio della 
%    timeserie al tempo di campionamento medio della timeseries tra ts1 e 
%    ts2 che ha il tempo di campionamento medio più basso.
%    
%    [TSOUT1, ... , TSOUTN] = resampleTS(TS1,...,TSN) ricampiono al tempio 
%    della timeserie al tempo di campionamento medio della timeseries tra 
%    ts1 e ts2 che ha il tempo di campionamento medio più basso.

function varargout = resampleTS(varargin)
    
    %trovo il tempo di campionamento medio più basso
    tMean = zeros(nargin);
    for i=1:nargin
       tMean(i)=mean(diff(varargin{i}.time));
    end
    idxTSFitta = find(tMean == min(tMean),1);
    tSamp = tMean(idxTSFitta);
    
    
    
    %Ricampiono con la funzione resample delle timeseries
    TSFitta = varargin{idxTSFitta};
    vetTUniform = tSamp*(0:numel(TSFitta.time)-1);
    varargout = varargin;
    for i=1:nargin
        ts = varargout{i};
        disp(['Ricampiono a ', num2str(tSamp), 's']);
        ts = resample(ts,vetTUniform);
        varargout{i} = ts;
    end
    
end

