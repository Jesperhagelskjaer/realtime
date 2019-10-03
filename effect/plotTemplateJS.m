function [] = plotTemplateJS(par,dataTraceJ_NRD_shift,varargin)


if find(strcmp(varargin,'time'))
    xVariable = varargin{find(strcmp(varargin,'time')) + 1};
    if strcmp(xVariable,'sample')
        xAxis = par.interval(1):par.interval(2);
    elseif strcmp(xVariable,'ms')
        xAxis = (par.interval(1):par.interval(2))/30;
    end
end

m = mean(size(dataTraceJ_NRD_shift{1},1));
n = mean(size(dataTraceJ_NRD_shift{1},2));

data_M = mean(dataTraceJ_NRD_shift{1},3);

[X,Y] = meshgrid(1:n,xAxis);

figure
surf(X,Y,data_M)
handleFigurePlot
end

