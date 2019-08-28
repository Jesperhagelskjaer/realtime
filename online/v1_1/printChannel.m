function [] = printChannel(par,i)

if i > 1  
    if i < 10
        fprintf(repmat('\b', 1, 11 ));
    else        
        fprintf(repmat('\b', 1, 12 ));
    end
end
fprintf('%d out of %d',par.spatial,i)

end

