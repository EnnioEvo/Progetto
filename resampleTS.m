function varargout = resampleTS(varargin)
    
    tMean = zeros(nargin);
    for i=1:nargin
       tMean(i)=mean(diff(varargin{i}.time));
    end
    idxTSFitta = find(tMean == min(tMean),1);
    TSFitta = varargin{idxTSFitta};
    tSamp = round(mean(diff(TSFitta.time)));
    vetTUniform = tSamp*(0:numel(TSFitta.time)-1);
    
    varargout = varargin;
    disp(nargin);
    for i=1:nargin
        ts = varargout{i};
        disp(['Ricampiono a ', num2str(tSamp), 's']);
        ts = resample(ts,vetTUniform);
        varargout{i} = ts;
    end
    
end

