function [NSSD,datum] = norm_Sum_of_squred_diff(par,datum)


try
    datum.template_mean_DSort;
catch
    datum.error = 1;
    datum.errorTxt = 'NO_T_DS';
end

try
    datum.template_mean_MClust;
catch
    datum.error = 1;
    datum.errorTxt = 'NO_T_MC';
end
NSSD = [];

if ~exist('datum.error','var')
    
for i = 1:size(datum.template_mean_DSort,2)
    template = datum.template_mean_DSort{i};
    T_n = size(template,1);
    
    for j = 1:size(datum.template_mean_MClust,2)
        
        signal = [zeros(10,4); datum.template_mean_MClust{j}; zeros(10,4)];

        for k = 1:size(signal,1)-T_n
            
            sgn = signal(1+k:T_n+k,:);
            
            top = sum(sum((sgn-template).^2));
            buttom = sqrt(sum(sum(sgn.^2)).*sum(sum(template.^2)));
            %buttom = sqrt(sum(sum(sgn)).^2*sum(sum(template)).^2) %check if this is the correct formula
            value{i,j}(k) = top/buttom;
            %top_t{i,j}(k) = top;
        end
        NSSD(i,j) = min(value{i,j}(:));
        
    end
end

end
end

