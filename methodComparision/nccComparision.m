function [NCC_value2] = nccComparision(par,datum)

for i = 1:size(datum.template_mean_DSort,2)
    template = datum.template_mean_DSort{i};
    
    for j = 1:size(datum.template_mean_MClust,2)
        signal = [zeros(20,4); datum.template_mean_MClust{j}; zeros(20,4)];
        
        NCC_value = normxcorr2_mex(template,signal);
        NCC_value1 = NCC_value(:,4); %change the 3
        NCC_value2(i,j) = max(NCC_value1); %i = dsort, j MCLust

    end
end

end

