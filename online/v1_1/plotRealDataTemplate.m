function [] = plotRealDataTemplate(par,dataF,rez)

if strcmp(par.AllTemplate,'Y')
    
    clusters = unique(rez.st(:,end));
    
    
    for i = 1:length(clusters)
        time = rez.st(find(rez.st(:,end) == clusters(i)),1);
        trace = zeros(30,size(dataF,2),length(time));
        for ii = 1:length(time)
            trace(:,:,ii) = dataF(time(ii)+[-15:14],:);
        end
        
        figure
        surf(mean(trace,3))
        title(num2str(clusters(i)))
        view(0,0)
        
    end
    
end

end
