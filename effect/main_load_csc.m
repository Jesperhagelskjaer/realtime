function [datum,Timestamps] = main_load_csc(par,path,datum)

if any(strcmpi(par.datatype,'csc')) 
for ii = 1:size(par.path,1)
fprintf('Loading channels [csc]: ')
for i = 1:length(par.chs{2})
    ch = par.chs{2}(i);
    
    %fprintf('loading channel: %d\n',ch) 
            if i > 1
                fprintf(repmat('\b', 1, 10 ));
            end
            
            fprintf('%d out of %d',length(par.chs{2}),i)
    [SamplesVectorUF,Timestamp,mBlockSize] = loadCSC(par,par.path{ii},ch);
    
        if i == 1
            data_CSC = nan(length(SamplesVectorUF),length(par.chs));
        end

        data_CSC(:,i) = SamplesVectorUF;     
end
data_CSC = invertSignal(par,data_CSC);
datum.CSC{ii} = filterSignal(par,data_CSC); %filterMain(par,datum,'CSC')

datum.Timestamps_CSC{ii} = Timestamp;
fprintf('\n')

end

end
end

