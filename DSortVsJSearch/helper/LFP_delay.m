function [] = LFP_delay(par,data)
ch = 2;

A_indexAP = [];A_indexLFP = [];

for i = 1:size(data,3)

    
    [valueAP, indexAP] = max(data(1:par.samplesBefore,ch,i));
    [valueLFP, indexLFP] = max(data(par.samplesBefore:end,ch,i));
    A_indexAP = [A_indexAP indexAP];
    A_indexLFP = [A_indexLFP (indexLFP +par.samplesBefore-1)];
    
    
    if  1 && i == 152
    h = figure;
    hold on
    plot(data(:,1,i))
    plot([abs(par.samplesBefore) abs(par.samplesBefore)],[-50 50],'-r')
    close(h)
    end
end
figure
histogram(A_indexAP,50)
hold on
histogram(A_indexLFP,50)

end

