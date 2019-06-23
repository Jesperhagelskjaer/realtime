function  Spike2Trigger_delay(par,data,varargin)

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

A_indexAP = [];

for i = start:endC
    
    [valueAP, indexAP] = max(data(1:par.samplesBefore,ch,i));
    value = indexAP-par.samplesBefore;
    A_indexAP = [A_indexAP value];
    
    
    if  0 && i == 2 || i == endC %&& value < 25
        h = figure;
        hold on
        plot(data(:,ch,i))
        plot([abs(par.samplesBefore) abs(par.samplesBefore)],[-50 50],'-r')
        plot(indexAP,valueAP,'gO')
        title([ num2str(i),' - ',num2str(endC) ])
        close(h)
        
    end
end
edges = -50.5:1:50.5;
figure
histogram(A_indexAP,edges)
title(['spikes - '  num2str(i)])
figureS_plot()
xlabel('Time [samples]')
ylabel('Counts')

end


