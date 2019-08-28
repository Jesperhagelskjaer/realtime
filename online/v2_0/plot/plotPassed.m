function [] = plotPassed(dataToPlot,index,jesper)

temporal = jesper.lengthTemplate;

for i = 1:length(index)
    if i < 10
        
        h = figure;
        surf(dataToPlot(index(i)-[1:temporal],:));
        close(h)
    end
end

