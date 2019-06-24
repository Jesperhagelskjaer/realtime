function [] = plotAboveThreshold(par,data,strH)

if strcmp(strH,'Dsort')
    holder = find(par.counts_D > par.D);
else
    holder = find(par.counts_J > par.J);
end

for i = 1:length(holder)
    h = figure;
    surf(data(:,:,holder(i)))
    title([strH,' - spike ',num2str(holder(i))] )
    pause()
    close(h)
end


end


