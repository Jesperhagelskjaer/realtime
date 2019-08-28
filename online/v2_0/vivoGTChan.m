function [f1W] = vivoGTChan(par,dataFilt,rez)

reCalculatedTemplateChan = par.reCalculateTemplate;
jitter = par.jitter;


windowT = par.lengthTemplate;
windowT = -windowT:-1;


if (~isempty(par.passed))
    JSortTime = par.passed;
else
    JSortTime = 0;
    fprintf('There was no data in jsortTime => correct?/n')
end

endDraw = length(windowT);
[~, minI] =  min(par.reCalculateTemplate(:,par.chMain));
correction = par.lengthTemplate -minI;
 
timeStampsCluster = par.GT  + correction;

truePositive = 0;
falseNegative = 0;
trueNegative = 0;
falsePositive = 0;
ch = par.channelMapTo;

for i = 1:length(timeStampsCluster)
    if (sum(ismembc(JSortTime,timeStampsCluster(i)+[-jitter:jitter])))
        truePositive = truePositive + 1;
    else
        falseNegative = falseNegative + 1;
        if (0 && falseNegative < 15)
            figure('units','normalized','outerposition',[0 0 1 1])
            subplot(2,2,1)        
            for m = 1:length(ch)
                hold on
                plot3([m m],[1 endDraw],[par.voltageSTD_A(m); par.voltageSTD_A(m)],'r-*')
                plot3([m m],[1 endDraw],[par.voltageSTD_B(m); par.voltageSTD_B(m)],'r-*')
            end
            surf(dataFilt(windowT+timeStampsCluster(i)+10,par.channelMapTo))
            title(['False Negative'])
            view(0,0)
            subplot(2,2,2)
            surf(reCalculatedTemplateChan)
            zlabel('voltage [um]')
            title('reCalculated template')
            view(0,0)
            subplot(2,2,3)
            %surf(par.dataF(timeStampsCluster(i)+[-40:40],par.channelMapTo))
            zlabel('voltage [um]')
            title('Filtered Signal no template')
            zlim([-280 250])
            view(90,0)
            subplot(2,2,4)
            surf(dataFilt((-20:20)+timeStampsCluster(i),par.channelMapTo))
            view(90,0)
            zlim([-280 250])
             title('Filtered Signal template added')
            zlabel('voltage [um]')
        end
    end
end


for i = 1:length(JSortTime)
    if (sum(ismembc(timeStampsCluster,JSortTime(i)+[-jitter:jitter])))
        trueNegative = trueNegative + 1;
    else
        falsePositive = falsePositive + 1;
        if (0 && falsePositive < 10)
            figure('units','normalized','outerposition',[0 0 1 1])
            subplot(2,2,1)        
            for m = 1:length(ch)
                hold on
                plot3([m m],[1 endDraw],[par.voltageSTD_A(m); par.voltageSTD_A(m)],'r-*')
                plot3([m m],[1 endDraw],[par.voltageSTD_B(m); par.voltageSTD_B(m)],'r-*')
            end
            surf(dataFilt(windowT+JSortTime(i)+8,par.channelMapTo))
            title(['False Positive   number = ',num2str(JSortTime(i)-par.WindowN(iCHT))])
            view(0,0)
            subplot(2,2,2)
            surf(reCalculatedTemplateChan)
            title('reCalculated template')
            view(0,0)
            subplot(2,2,4)
            surf(dataFilt((-20:20)+JSortTime(i),:))
            title('Filtered Signal Template added')
            view(90,0)
            subplot(2,2,3)
           % surf(par.dataF(JSortTime(i)+[-40:40],:))
            title('Filtered Signal no template')
            view(90,0)
        end
    end
end

PPV = truePositive/(truePositive + falseNegative);%presision
TPR = truePositive/(truePositive + falsePositive); %True positive
f1W = (par.wR + par.wP)/((par.wP/PPV) + (par.wR/TPR));

h = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,3,1)
bar([truePositive,falseNegative])
set(gca,'xticklabel',{'True','False Negative'})
title(['T.pld = ',num2str(par.spikesTotal),' T.foud = ', num2str(truePositive)])
subplot(2,3,2)
bar([trueNegative,falsePositive])
title(['jSort found    falsePositive = ',num2str(falsePositive)])
set(gca,'xticklabel',{'True','False postive'})
subplot(2,3,3)
title(num2str(f1W))
subplot(2,3,4)
surf(par.reCalculateTemplate )
%title(['template used scaled: ',num2str(par.scalingTemplate(ScaledTemple))])
subplot(2,3,5)
%surf(par.templateBigF)
drawnow



end

