function [] = plotSpikes(par,trueJsearch_T,falsePositive_T,true_T,falseNegative_T,dataFilt,dataShort)

mChls = par.channelMapTo;
xVector = [-8:par.lengthTemplate -8];

if strcmp(par.plotSpike(1),'trueJsearch_T')
    for i = 1:10
        figure
        subplot(3,1,1)
        surf(dataFilt(trueJsearch_T(i)+[xVector],mChls));
        title('true')
        subplot(3,1,2)
        surf(dataFilt(trueJsearch_T(i)+[xVector],:)); 
       subplot(3,1,3)
        surf(dataShort(trueJsearch_T(i)+[xVector],:));
    end
end

if strcmp(par.plotSpike(2),'Y')
    for i = 1:10
        figure
        subplot(3,1,1)
        surf(dataFilt(falsePositive_T(i)+[xVector],mChls));
        title('falseNegative')
        subplot(3,1,2)
        surf(dataFilt(falsePositive_T(i)+[xVector],:));
        subplot(3,1,3)
        surf(dataShort(falsePositive_T(i)+[xVector],:));
        
        %surf(data(timeIndex(i)+[-58+temporal:58+temporal],:));     
    end
end



if strcmp(par.plotSpike(3),'Y')
    for i = 1:10
        figure
        subplot(3,1,1)
        surf(dataFilt(true_T(i)+[xVector],mChls));
        title('true')
        subplot(3,1,2)
        surf(dataFilt(true_T(i)+[xVector],:)); 
       subplot(3,1,3)
        surf(dataShort(true_T(i)+[xVector],:));
    end
    
end





end