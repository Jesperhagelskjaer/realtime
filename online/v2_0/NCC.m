function [par] = NCC(par,datum_,rez,varargin)
tic
fprintf('%-20s','NCC started')

if find(strcmp(varargin,'ext'))
    version = varargin{find(strcmp(varargin,'ext')) + 1}; %create better method
    if strcmp(version,'nrd')
        dataF = datum_.data_NRD_F;
    elseif strcmp(version,'csc')
        dataF = datum.data_CSC_F;
    end
end


[par] = CppNCC(par,dataF,'with');
PlotMinMaxHeight2D(par,dataF,rez,'NCC',0)
%plotSumPassed(par,dataF,rez,'NCC',0)
time = toc;
fprintf('%-20s %2.2f %-10s\n', '- finished   - Elepased time',time,'seconds')


fprintf('Number passed NCC threshold: %d\n',length(par.passed))
end

