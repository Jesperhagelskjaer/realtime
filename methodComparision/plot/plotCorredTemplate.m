function [] = plotCorredTemplate(par,datum)

for i = 1:length(datum.shuffleVector)
    figure
    subplot(2,1,1)
    try
    surf(mean(datum.spikes_DSort_cor{i},3))
    view(90,0)
    title('DSort')
    catch; end
    subplot(2,1,2)
    try
        surf(mean(datum.template_mean_MClust{i},3))
        view(90,0)
        title('MClust')
    catch;end
        
end

