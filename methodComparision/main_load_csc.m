function [datum] = main_load_csc(par,datum)


for ii = 1:size(par.path,1)
    fprintf('Loading channels [csc]: ')
    for i = 1:length(par.template_LFP{2})
        ch = par.template_LFP{2}(i);
        
        %fprintf('loading channel: %d\n',ch)
        if i > 1
            fprintf(repmat('\b', 1, 10 ));
        end
        
        fprintf('%d out of %d',length(par.template_LFP{2}),i)
        [SamplesVectorUF,Timestamp,mBlockSize] = loadCSC(par,ch);
        
        if i == 1
            data_CSC = nan(length(SamplesVectorUF),length(par.template_LFP{2}));
        end
        
        data_CSC(:,i) = SamplesVectorUF;
    end
    data_CSC = invertSignal(par,data_CSC);
    %datum.CSC{ii} = filterSignal(par,data_CSC); %filterMain(par,datum,'CSC')
    
    datum.Timestamps_CSC = Timestamp;
    datum.CSC = data_CSC;
    fprintf('\n')
    
end

end


