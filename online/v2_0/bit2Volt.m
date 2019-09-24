function [data] = bit2Volt(par,data)

if strcmp(par.useBitmVolt,'Y' )

    data = data*par.bitmVolt;
    
end
    
end

