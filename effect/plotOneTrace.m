%function [] = plotOneTrace(par,data,TTL_number,total)
function [] = plotOneTrace(par,data,varargin)


% 'tace', [7] single trace - [1 5] plot the range of TTL  or all  - which
% TTL to take out all the TTL of the recording
% 'path', 2 or all- which recording to look at


%xAxis : time -> samples,ms 

if find(strcmp(varargin,'trace'))
    TTL_number = varargin{find(strcmp(varargin,'trace')) + 1}; %create better method
    if size(TTL_number,2) > 1
        TTL_Start = TTL_number(1);
        TTL_End = TTL_number(2);
    else
        TTL_Start = TTL_number(1);
        TTL_End   = TTL_number(1);
        
    end
else
    TTL_number = 'all'; %not made yet
    TTL_Start = 1;
end

if find(strcmp(varargin,'time'))
    xVariable = varargin{find(strcmp(varargin,'time')) + 1};
    if strcmp(xVariable,'sample')
        xAxis = par.interval(1):par.interval(2);
    elseif strcmp(xVariable,'ms')
        xAxis = (par.interval(1):par.interval(2))/30;
    end
end




if find(strcmp(varargin,'path'))
    pathNr = varargin{find(strcmp(varargin,'path'))+1}; %create better method
    pathStart = pathNr;
    if size(data,2) > pathNr
        pathNr = 1;
        fprintf('Error acquired in the path set to the first path')
    end
else
    pathNr = size(data,2);
    pathStart = 1;
end


for i = pathStart:pathNr %figure for each path
    figure
    if strcmp(TTL_number,'all')
        TTL_End = size(data{1,i},3);
    end
    for ii = 1:size(data{1,i},2) %the number of channels
        subplot(size(data{1,pathNr},2),1,ii)
        hold on
        handleFigurePlot(xVariable)
        for iii = TTL_Start:TTL_End
            plot(xAxis,data{1,i}(:,ii,iii))
        end
    end
end



for i = 1:size(data,2) 
    figure
    for ii = 1:size(data{1,i},2)  %the number of channels
        hold on
        handleFigurePlot(xVariable)
        plot(xAxis,mean(data{1,i},3))
    end
end
end
%color = get(h,'Color');
%set(gca,'color','none')
%set(gca,'XColor',[1 1 1],'YColor',[1 1 1],'TickDir','out')
%set(gca,'XColor','none','YColor','none','TickDir','out')

% set(gca,'Visible','off')
%xticks([0 6000])
%xticklabels({'0','200'})
%xlabel('Time [ms]')
%box off