function [holderGT,holder,holder2] = calculateMinMax(jesper,dataAdTempF,dataF)

temporal = jesper.lengthTemplate;


GT_cor = jesper.GT;

for ii = 1:length(jesper.template)
    
    if length(jesper.template) == 1
        indexCheck = jesper.passed;
        indexCheckWithOut = jesper.passedWithout;
    else
        indexCheck = cell2mat(jesper.passed);
    end
    
    if strcmp(jesper.changeChannels,'Y')
        mChls = jesper.channelMapTo;
        chMain = jesper.chMain;
    else
        mChls = jesper.mainChannel;
        chMain = jesper.chMain;
    end
    
    for i = 1:length(GT_cor)
        matrixHoldergrad2_GT(i,:) = min(dataAdTempF(GT_cor(i)-[1:temporal],mChls(:)));
        matrixHoldergrad1_GT(i,:) = max(dataAdTempF(GT_cor(i)-[1:temporal],mChls(:)));
    end
    
    holderGT = matrixHoldergrad2_GT -  matrixHoldergrad1_GT;
    
    for i = 1:length(indexCheck)
        matrixHoldergrad2(i,:) = min(dataAdTempF(indexCheck(i)-[1:temporal],mChls(:)));
        matrixHoldergrad1(i,:) = max(dataAdTempF(indexCheck(i)-[1:temporal],mChls(:)));
    end
    
    holder = matrixHoldergrad2 -  matrixHoldergrad1;
    
    for i = 1:length(indexCheckWithOut)
        matrixHoldergrad2_out(i,:) = min(dataF(indexCheckWithOut(i)-[1:temporal],mChls(:)));
        matrixHoldergrad1_out(i,:) = max(dataF(indexCheckWithOut(i)-[1:temporal],mChls(:)));
        
    end
    holder2 = matrixHoldergrad2_out -  matrixHoldergrad1_out;
    
    
    
end







