function [par] = recalculateTemplate(par,rez,datum_,varargin)

if find(strcmp(varargin,'ext'))
    version = varargin{find(strcmp(varargin,'ext')) + 1}; %create better method
    if strcmp(version,'nrd')
        dataF = datum_.data_NRD_F;
    elseif strcmp(version,'csc')
        dataF = datum.data_CSC_F;
    end
end





spatial = par.spatial;
st = rez.st;
spikeCluster = st(:,8); % Cluster ID
timeStamps = st(:,1);
windowBig = -par.sizeTemplateIntoRawData:par.sizeTemplateIntoRawData;
temporalBig = length(windowBig);

timeStampsCluster = timeStamps(find(spikeCluster == par.template));%+par.filtershift;


templateStackBig = nan(temporalBig,spatial,length(timeStampsCluster));

for k = 1:length(timeStampsCluster)
    templateStackBig(:,:,k) = dataF(timeStampsCluster(k)+windowBig,:);
    if 0
        figure
        surf(templateStack(:,:,k))
        view(90,0)
        drawnow
    end
end

templateAverageBig = nanmean(templateStackBig,3);

if strcmp(par.pTemplateAverageBig,'Y')
    figure
    surf(templateAverageBig)
    view(90,0)
    title('Recal Temp Jsort')
    zlabel('arb.U');ylabel('Samples'),xlabel('Channels')
    %zlim([-250 125])
    %zticks([-250 -125 0 125])
    %set(0,'defaultAxesFontSize',20);
    %grid off
end

par.templateAverageBig = templateAverageBig;
par.templateAverageBig_NRD = templateAverageBig;
end

