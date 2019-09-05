function [] = plotCorredTemplate(par,datum)

if ~exist('datum.error','var')
    
    m = length(datum.shufleVector_DS);
    n = length(datum.shufleVector_MS);
    
    if m > n
        lgt = m;
    else
        lgt = n;
    end
    
    for i = 1:lgt
        
        figure
        subplot(2,1,1)
        try
            surf(mean(datum.spikes_DSort_cor{i},3))
            %view(90,0)
            title({'DSort ',num2str(i)})
        catch
        end
        subplot(2,1,2)
        try
            surf(mean(datum.spikes_MClust_cor{i},3))
            %view(90,0)
            title({'MClust ',num2str(i)})
        catch
        end
        
    end
end
end

