function [template] = setValuesToZeroTemplate(par,template)

value = par.sigmaHat* cell2mat(par.Template_zero(2));
%can be made faster/smarter
if strcmp(par.Template_zero(1),'Y')
    for m = 1:size(template,1)
        for n = 1:size(template,2)
            
            if (abs(template(m,n)) < value)
                template(m,n) = 0;
            end
        end
        
    end
end
end

