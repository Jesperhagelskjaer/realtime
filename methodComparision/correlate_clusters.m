function [datum] = correlate_clusters(par,datum,varargin)

   
if any(strcmp(varargin,'method'))
    input = varargin{find(strcmp(varargin,'method')) + 1};
    if strcmp(input,'NSSD')
        [holder,datum] = norm_Sum_of_squred_diff(par,datum);
        bool = 0;
    elseif strcmp(input,'NCC')
        [holder,datum] = nccComparision(par,datum);
        bool = 1;
    end
end
    
if ~exist('datum.error','var')
    
    shufleVector_DS = nan(1,size(holder,1));
    shufleVector_MS = nan(1,size(holder,2));
    
    for j = 1:min(size(holder)) %look into which have fewer cluster
        if bool
            maximum = max(max(holder));
            [m,n]=find(holder==maximum);
        else
            minimum = min(min(holder));
            [m,n]=find(holder==minimum);
        end
        
        shufleVector_DS(1,j) =  m;
        shufleVector_MS(1,j) =  n;
        holder(m,:) = nan;
        holder(:,n) = nan;
    end
    
    for i = 1:length(shufleVector_MS)
        index = find(shufleVector_MS == i);
        if isempty(index)
            shufleVector_MS(find(isnan(shufleVector_MS), 1)) = i;
        end
    end
    
    for i = 1:length(shufleVector_DS)
        index = find(shufleVector_DS == i);
        if isempty(index)
            shufleVector_DS(find(isnan(shufleVector_DS), 1)) = i;
        end
    end
    
    
    datum.shufleVector_DS = shufleVector_DS;
    datum.shufleVector_MS = shufleVector_MS;
    
    datum.tSpikes_DSort_cor  = datum.tSpikes_DSort(shufleVector_DS);
    datum.spikes_DSort_cor   = datum.spikes_DSort(shufleVector_DS);
    
try
    datum.template_mean_MClust;
    fprintf('Test against MCLUST\n')
catch
    datum.CW_t_JS_cor  = datum.CW_t_JS(shufleVector_MS);
    datum.CW_JS_cor   = datum.CW_JS(shufleVector_MS);
end
    
    plotCorredTemplate(par,datum)
    
end

end

% for i = 1:size(datum.template_mean_MClust,2)
%     figure
%     surf(datum.template_mean_MClust{i})
%     title({'MC-',num2str(i)})
% end
%
% for i = 1:size(datum.template_mean_DSort,2)
%     figure
%     surf(datum.template_mean_DSort{i})
%     title({'D',num2str(i)})
% end
%
%     figure
%     subplot(2,1,1)
%     surf(datum.template_mean_MClust{n})
%     title({'MC-',num2str(n)})
%
% subplot(2,1,2)
%     surf(datum.template_mean_DSort{m})
%     title({'D',num2str(m)})


