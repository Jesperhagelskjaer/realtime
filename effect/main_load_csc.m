function [dataCSC,Timestamps] = main_load_csc(par,path)

for i = 1:length(par.chs)
    fprintf('loading channel: %d\n',par.chs(i)) 
    [SamplesVectorUF,Timestamps,mBlockSize] = loadCSC(par,path,i);
    
        if i == 1
            dataCSC = nan(length(SamplesVectorUF),length(par.chs));
        end

        dataCSC(:,i) = SamplesVectorUF;     
end
dataCSC = invertSignal(dataCSC,par);
dataCSC = filterSignal(par,dataCSC);

end

