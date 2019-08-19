function [rez,par] = loadRez(par)


try
    load(strcat(par.path{1},'csc\',par.rezName));
catch
    fprintf('The Rez file does not exist - creating a empty rez file\n')
    rez = [];
    par.rez = 'nan';
end

