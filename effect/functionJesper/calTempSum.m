function [] = calTempSum(par,rezT,dataRAW)

spatial = par.chs;

window = -par.before:par.after;

for i = 1:size(rezT,2)
    if strcmp(par.template_LFP,'all')
        templateSe = unique(rezT{1}.rez.st(:,8));
    else
        templateSe = par.template;
    end
    
    
    for ii = 1:length(templateSe)
        spikeCluster = rezT{i}.rez.st(:,8); % Cluster ID
        timeStamps = rezT{i}.rez.st(:,1);
        
        timeStampsCluster = timeStamps(logical(spikeCluster == templateSe(ii)));%+jesper.filtershift;
        
        templateStack = nan(length(window),length(spatial),length(timeStampsCluster));
        
        for k = 1:length(timeStampsCluster)
            templateStack(:,:,k) = dataRAW(timeStampsCluster(k)+window,:);
        end
        
        templateAve{i,ii} = mean(templateStack,3);
        
        %         figure
        %         if (spatial == 1)
        %             plot(templateAve{i,ii})
        %         else
        %             surf(templateAve{i,ii})
        %         end
    end
end

for ii = 1:size(templateAve,2)
    figure
    if (spatial == 1)
        subplot(2,1,1)
        title('Before')
        plot(templateAve{1,ii})
        subplot(2,1,2)
        plot(templateAve{2,ii})
        title('After')
    else
        subplot(2,1,1)
        title('Before')
        surf(templateAve{1,ii})
        subplot(2,1,2)
        surf(templateAve{2,ii})
        title('After')
    end
    sgtitle(['Templates - ',num2str(templateSe(ii))])
    
    name = strcat(par.path{1}(1:end-4),'figure\','LFP_effect_',num2str(par.template),'_',num2str(i));
    saveas(h,name,'fig')
    
end

end

