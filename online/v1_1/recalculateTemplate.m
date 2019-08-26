function [jesper,data] = recalculateTemplate(dataRAW,jesper,rez,iCHT,iCHTre,data,ScaledTemple)

spatial = jesper.spatial;
st = rez.st;
spikeCluster = st(:,8); % Cluster ID
timeStamps = st(:,1);
windowBig = -jesper.sizeTemplateIntoRawData:jesper.sizeTemplateIntoRawData;
%old code puts only the window into the data
windowSmall = jesper.WindowN(iCHT):jesper.WindowP(iCHTre);
temporalBig = length(windowBig);
GT = 0;


timeStampsCluster = timeStamps(find(spikeCluster == jesper.template));%+jesper.filtershift;
timeStampsCluster(timeStampsCluster > size(dataRAW,1)) = [];

templateStackBig = nan(temporalBig,spatial,length(timeStampsCluster));


i = 1;
%Wi will filter
[dataF2Butter] = filterButter2(dataRAW,jesper);

if strcmp(jesper.vTCleaning,'Y')
    for k = 1:length(timeStampsCluster)
        if 0
            figure
            surf(dataF(timeStampsCluster(k)+windowSmall,:))
            view(90,0)
        end
        if all(any(dataF2Butter( timeStampsCluster(k)+windowSmall,jesper.mainChannel) <  jesper.voltageCalThreshhold(1) ))
            if ~all(any(dataF2Butter(timeStampsCluster(k)+windowSmall,jesper.mainChannel) <  jesper.voltageCalThreshhold(2) ))
                templateStackBig(:,:,i) = dataF2Butter(timeStampsCluster(k)+windowBig,:);
                GT(i) = timeStampsCluster(k);
                
                if 0
                    figure
                    surf(templateStackBig(:,:,i))
                    view(90,0)
                end
                i = i + 1;
            end
        end
    end
    
elseif strcmp(jesper.vTCleaning,'false')
    for k = 1:length(timeStampsCluster)
        templateStackBig(:,:,k) = dataF2Butter(timeStampsCluster(k)+windowBig,:);
        if 0
            figure
            surf(templateStack(:,:,k))
            view(90,0)
            drawnow
        end
    end
    GT = timeStampsCluster;
else
    printf("Wrong threshold filter type")
    exit();
end
jesper.GTDSort = GT;

templateAverageBig = nanmean(templateStackBig,3)*jesper.scalingTemplate(ScaledTemple);

if strcmp(jesper.pTemplateAverageBig,'Y')
    figure
    surf(templateAverageBig)
    view(90,0)
    title(['Recal Temp Jsort ,scaled: ',num2str(jesper.scalingTemplate(ScaledTemple)),' spike:', num2str(i)])
    zlabel(['Voltage [uV]']);ylabel('Samples'),xlabel('Channels')
    zlim([-250 125])
    zticks([-250 -125 0 125])
    set(0,'defaultAxesFontSize',20);
    %grid off
end
jesper.templateAverageBig = templateAverageBig;
data.dataF2Butter = dataF2Butter;
end

