function [dataCSC,Timestamps] = main_load_csc(par,path)

for ii = 1:size(par.path,1)

for i = 1:length(par.chs{2})
    ch = par.chs{2}(i);
    fprintf('loading channel: %d\n',ch) 
    [SamplesVectorUF,Timestamp,mBlockSize] = loadCSC(par.path{ii},ch);
    
        if i == 1
            data_CSC = nan(length(SamplesVectorUF),length(par.chs));
        end

        data_CSC(:,i) = SamplesVectorUF;     
end
data_CSC = invertSignal(par,data_CSC);
dataCSC{ii} = filterSignal(par,data_CSC); %filterMain(par,datum,'CSC')

Timestamps{ii} = Timestamp;
end
end

