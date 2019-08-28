function [par,rez] = loadRez(par)


try
    load(strcat(par.path,'\nrd\',par.rezName));
catch
    fprintf('The Rez file does not exist - creating a empty rez file\n')
    rez = [];
    par.rez = 'nan';
end



end
