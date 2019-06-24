function [timeStamp] = timeStampDsort(par)
rez = loadRez(par);

timeStamp = rez.st(find(rez.st(:,8) == par.loadRez{3}),1);

if 0
   for i = 1:size(rez.M_template,3)
    wv_ccg(rez,i)
   end
end


end

