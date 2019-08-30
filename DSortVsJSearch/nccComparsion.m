function [outputArg1,outputArg2] = nccComparsion(par,datum)

if size(t_MC,2) > size(t_DS,2)
    mC_largest = size(t_MC,2);
    largest = mC_largest;
elseif size(t_MC,2) < size(t_DS,2)
    mD_largest = size(t_DS,2);
    largest = mD_largest;
else
    equalSize = size(t_DS,2);
    largest = size(t_DS,2);
end

for i = 1:size(datum.MCLust,2)
    for j = 1:size(datum.DSort,2)
       NCC_value(i,j) = normxcorr2_mex(template,signal); 
        
        
    end
end

end

