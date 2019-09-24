function [par] = allChlsMean(par,datum_,rez,varargin)


if find(strcmp(varargin,'ext'))
    version = varargin{find(strcmp(varargin,'ext')) + 1}; %create better method
    if strcmp(version,'nrd')
        dataF = datum_.data_NRD_F;
    elseif strcmp(version,'csc')
        dataF = datum_.data_CSC_F;
    end
end



tic
fprintf('%-20s','AllChlsMean started')


[par] = allChannelsMean(par,dataF,'with');
%[par] = plottingGT(par,dataF_Temp,rez,'Coherence');
%PlotMinMaxHeight2D(par,dataF,rez,'coherence',0)

time = toc;
fprintf('%-20s %2.2f %-10s\n', ' - finished - elepased time:',time,'seconds')

fprintf('passed coherency: %d\n',length(par.passed))
end

