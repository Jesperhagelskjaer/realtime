function [] = LFP_delay(par,data,varargin)
if nargin > 2
    if varargin{1} > varargin{2}
    fprintf('Error - start is coming after end')
    else
    start = varargin{1};
    end
    endC = size(data,3);
    if varargin{2} > size(data,3)
        endC = size(data,3);
    else
        endC = varargin{2};
    end
else
    start = 1;
    endC = size(data,3);
end

ch = 1;

A_indexAP = [];A_indexLFP = [];

for i = start:endC
    
    [valueAP, indexAP] = max(data(1:par.samplesBefore,ch,i));
    [valueLFP, indexLFP] = max(data(par.samplesBefore:end,ch,i));
    A_indexAP = [A_indexAP (indexAP-par.samplesBefore)];
    A_indexLFP = [A_indexLFP indexLFP];
    
    
    if  1 && i == 2 || i == 105
        h = figure;
        hold on
        plot(data(:,ch,i))
        plot([abs(par.samplesBefore) abs(par.samplesBefore)],[-50 50],'-r')
        plot(indexAP,valueAP,'gO')
        %close(h)
    end
end
edges = -50.5:1:50.5;
figure
hold on
histogram(A_indexLFP,edges,'displayname','LFP')
histogram(A_indexAP,edges,'displayname','AP')
xlabel('Time [samples]')
ylabel('Counts')
title(['spikes - ' , num2str(i)])
legend
%figureS_plot()
end

