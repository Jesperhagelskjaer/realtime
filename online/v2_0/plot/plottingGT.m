function [par] = plottingGT(par,dataFilt,rez,dataShort,stringToPrint)


if strcmp(par.changeChannels,'Y')
jitter = par.jitter;

timeStampsCluster = par.GT;
JSortTime = par.passed-par.lengthTemplate;

trueJsearch = 0; falsePositive = 0; true = 0; falseNegative = 0;

trueJsearch_T = [];falsePositive_T = [];true_T = [];falseNegative_T = [];

for i = 1:length(JSortTime)
    if (sum(ismembc(timeStampsCluster,JSortTime(i)+[-jitter:jitter])))
        trueJsearch = trueJsearch + 1;
        trueJsearch_T = [trueJsearch_T JSortTime(i)];
    else
        falsePositive = falsePositive + 1;
        falsePositive_T = [falsePositive_T JSortTime(i)];
    end
end

for i = 1:length(timeStampsCluster)
    if (sum(ismembc(JSortTime,timeStampsCluster(i)+[-jitter:jitter])))
        true = true + 1;
        true_T = [true_T timeStampsCluster(i)];
    else
        falseNegative = falseNegative + 1;
        falseNegative_T = [falseNegative_T timeStampsCluster(i)];
    end
end

plotSpikes(par,trueJsearch_T,falsePositive_T,true_T,falseNegative_T,dataFilt,dataShort)



% par.statistisk(1,end+1) = trueJsearch;
% par.statistisk(1,end+1) = true;
% par.statistisk(1,end+1) = falsePositive_T;
% par.statistisk(1,end+1) = falseNegative;
% par.statistisk(1,end+1) = nan;
% first =  ['True Positive:  ',num2str(trueJsearch,'%4.0f')];
% second = ['what to call:   ',num2str(true,'%4.0f')];
% third =  ['False Positive: ',num2str(falsePositive_T,'%4.0f')];
% fourth = ['Misses: ',num2str(falseNegative,'%4.0f')];
% 
% 
% 
% figure
% plot(true_T,ones(1,length(true_T))*1.005,'.c');
% hold on
% plot(trueJsearch_T,ones(1,length(trueJsearch_T))','.g');
% plot(falseNegative_T,ones(1,length(falseNegative_T))*1.015,'.k');
% plot(v2,ones(1,length(v2))*1.01,'.b');
% 
% 
% 
% plot(par.passed)
% ylim([0.93 1.02])
% title(stringToPrint)
% 
% h = legend({first,second,third,fourth},'Location','southwest');
% set(h,'Interpreter','none')
% drawnow
else
    fprintf('PlottingGT is done yet for not moving')
end







