function [] = plotRealDataTemplate(par,datum_,rez,varargin)

if strcmp(par.AllTemplate,'Y')
    
    if find(strcmp(varargin,'ext'))
        version = varargin{find(strcmp(varargin,'ext')) + 1}; %create better method
        if strcmp(version,'nrd')
            dataF = datum_.data_NRD_F;
        elseif strcmp(version,'csc')
            try
            dataF = datum_.data_CSC_F;
            catch
               dataF = datum_.data_CSC_RAW;
            end
        end
    end
    
    
    
    
    clusters = unique(rez.st(:,end));
    
    
    for i = 1:length(clusters)
        time = rez.st(find(rez.st(:,end) == clusters(i)),1);
        trace = zeros(30,size(dataF,2),length(time));
        for ii = 1:length(time)
            trace(:,:,ii) = dataF(time(ii)+[-15:14],:);
        end
        
        %onlyDefined = trace(:,par.template{2},:);
        
        figure
        surf(mean(trace,3))
        title(num2str(clusters(i)))
        view(0,0)
%         figure
%         surf(mean(onlyDefined,3))
%         title(num2str(clusters(i)))
%         view(0,0)
        
    end
    
end

end
