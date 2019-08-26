function  jesper = recalculateNCCTemplate(dataFilt,jesper,rez,iCHT,iCHTre)

spatial = jesper.spatial;
spikeCluster = rez.st(:,8); % Cluster ID

timeStamps = rez.st(:,1);
timeStamps = timeStamps(timeStamps< jesper.lengthrecording);

spikeCluster = spikeCluster(1:length(timeStamps));


windowSmall = jesper.WindowN(iCHT):jesper.WindowP(iCHTre);
windowBig = -50:50;
temporalSmall = length(windowSmall);
temporalBig = length(windowBig);
addV = 30; %chance this value to proper paramter

temporal = abs(jesper.WindowN(iCHT))+ jesper.WindowP(iCHTre)+1;

for i = 1:length(jesper.template)
    
timeStampsCluster = timeStamps(find(spikeCluster == jesper.template(i)));

templateStackSmall = nan(temporalSmall,spatial,length(timeStampsCluster));
templateStackBig = nan(temporalBig,spatial,length(timeStampsCluster));

for k = 1:length(timeStampsCluster)-1
    templateStackSmall(:,:,k) = dataFilt(timeStampsCluster(k)+addV+windowSmall,:);
    templateStackBig(:,:,k) = dataFilt(timeStampsCluster(k)+addV+windowBig,:);
end

templateAverageSmall = nanmean(templateStackSmall,3);
templateAverageBig = nanmean(templateStackBig,3);


jesper.templateAverageBig{i} = templateAverageBig;

if strcmp(jesper.pSmallTemplate,'Y')
    figure
    subplot(2,1,1)
    surf(templateAverageSmall)
    title('template to search for')
    subplot(2,1,2)
    surf(templateAverageBig)
    title('Larger view of the smaller template to use')
   
end
[minV, minI]=min(templateAverageSmall(:,jesper.mainChannel{1}(1)));

jesper.reCalculateTemplate{i} = templateAverageSmall;
jesper.minIndexReCalculateTemplate{i} = temporal-minI;
jesper.GT{i} = timeStampsCluster(find(timeStampsCluster < jesper.lengthGroundt));
end
end



