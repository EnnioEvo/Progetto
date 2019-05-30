function tsOut = tserieVariazioni(tsIn,scalare)
    %tsOut = tsIn...
    tsOut = timeseries(tsIn.data - scalare,tsIn.time);
    tsOut.name = ['d',tsIn.name];
    tsOut.events = tsIn.events;
end

