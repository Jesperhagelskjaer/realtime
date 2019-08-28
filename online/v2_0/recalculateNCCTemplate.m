function  par = recalculateNCCTemplate(par,datum_,rez,varargin)


if find(strcmp(varargin,'ext'))
    version = varargin{find(strcmp(varargin,'ext')) + 1}; %create better method
    if strcmp(version,'nrd')
        dataF = datum_.data_NRD_F;
    elseif strcmp(version,'csc')
        dataF = datum.data_CSC_F;
    end
end

spatial = par.spatial;
spikeCluster = rez.st(:,8); % Cluster ID

timeStamps = rez.st(:,1);

spikeCluster = spikeCluster(1:length(timeStamps));


windowSmall = par.window(1):par.window(2);
windowBig = -50:50;
temporalSmall = length(windowSmall);
temporalBig = length(windowBig);
addV = 5; %chance this value to proper paramter

temporal = abs(par.window(1))+ par.window(2);

timeStampsCluster = timeStamps(find(spikeCluster == par.template));

templateStackSmall = nan(temporalSmall,spatial,length(timeStampsCluster));
templateStackBig = nan(temporalBig,spatial,length(timeStampsCluster));

for k = 1:length(timeStampsCluster)-1
    templateStackSmall(:,:,k) = dataF(timeStampsCluster(k)+addV+windowSmall,:);
    templateStackBig(:,:,k) = dataF(timeStampsCluster(k)+addV+windowBig,:);
end

templateAverageSmall = nanmean(templateStackSmall,3);
templateAverageBig = nanmean(templateStackBig,3);


par.templateAverageBig = templateAverageBig;


figure
subplot(2,1,1)
surf(templateAverageSmall)
title('template to search for')
subplot(2,1,2)
surf(templateAverageBig)
title('Larger view of the smaller template to use')

par.reCalculateTemplate = templateAverageSmall;
par.lengthTemplate = temporal;
end




