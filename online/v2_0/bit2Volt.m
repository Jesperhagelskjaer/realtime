function [data] = bit2Volt(jesper,rez,data)

if strcmp(jesper.useBitmVolt,'Y' )

    data = data*rez.ops.bitmVolt;
    
end
    
end

