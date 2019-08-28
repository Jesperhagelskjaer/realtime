function [par] = allChlsMean(par,dataF,rez)

tic
fprintf('%-20s','AllChlsMean started')


[par] = allChannelsMean(par,dataF,'with');
%[par] = plottingGT(par,dataF_Temp,rez,'Coherence');
%PlotMinMaxHeight2D(par,dataF,rez,'coherence',0)

time = toc;
fprintf('%-20s %2.2f %-10s\n', ' - finished - elepased time:',time,'seconds')

fprintf('passed coherency: %d\n',length(par.passed))
end

