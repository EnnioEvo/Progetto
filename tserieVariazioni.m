function tsOut = tserieVariazioni(tsIn,scalar)
    tsOut = tsIn;
    tsOut.data = tsOut.data - scalar;
    tsOut.name = ['d',tsOut.name];
end

