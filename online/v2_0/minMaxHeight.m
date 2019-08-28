function [jesper] = minMaxHeight(jesper,dataFilt,rez)

%close all

temporal = abs(jesper.WindowN(1))+ jesper.WindowP(1)+1;

for ii = 1:length(jesper.template)
    
if length(jesper.template) == 1
    indexCheck = jesper.passed{ii};
  else
     indexCheck = cell2mat(jesper.passed{ii});
 end
       

    mChls = jesper.mainChannel{ii};
    
    valuesToPassM = jesper.gradMinMax{ii};
    indexpassedGradient = []; indexpassedAmplitudeAll = [];matrixHolderPassed = [];
    kk = 1;
    
    %The index is calcualted from the hits of the NCC
    
    [minV, minI] = min(jesper.reCalculateTemplate{ii}(:,mChls(1)));
    [maxV, maxI] = max(jesper.reCalculateTemplate{ii}(:,mChls(1)));
    
    figure
    plot(jesper.reCalculateTemplate{ii}(:,mChls(1)))
    hold on
    plot(minI,minV,'r*',maxI,maxV,'r*')
    title('Index min max is found on the template')
    
    matrixHoldergrad2 = dataFilt(indexCheck(:)-11,mChls(:));
    matrixHoldergrad1 = dataFilt(indexCheck(:)-28,mChls(:));
    holder = matrixHoldergrad1 -  matrixHoldergrad2;
    
    for k = 1:length(indexCheck)
        if all(holder(k,:) < valuesToPassM  )
            indexpassedGradient(kk) = indexCheck(k); %can be made better
            indexpassedAmplitudeAll(kk) = indexCheck(k);
            matrixHolderPassed(kk,:) = holder(k,:);
            kk = kk + 1;
            
        end

    end
       
    matrixHoldergrad1 = dataFilt(jesper.GT{ii}(:),mChls(:));
    matrixHoldergrad2 = dataFilt(jesper.GT{ii}(:)+15,mChls(:));
    
    holderGT = matrixHoldergrad1-matrixHoldergrad2;
    
    jesper.indexpassedAmplitudeAll{ii} = indexpassedAmplitudeAll;
    jesper.passed{ii} = indexpassedAmplitudeAll;
    lgt1 = length(jesper.mainChannel{ii});
    
    if 1
        figure
        for i = 0:length(jesper.mainChannel{ii})-1
            
            binranges = -400:2:50;
            [bincounts1] = histc(holderGT(:,i+1),binranges);
            [bincounts2] = histc(holder(:,i+1),binranges);
            [bincounts3] = histc(matrixHolderPassed(:,i+1),binranges);
            subplot(lgt1,3,1+3*i)
            bar(binranges,bincounts1,'histc')      
            
            plottingParameter(i,1)
            subplot(lgt1,3,2+3*i)
            bar(binranges,bincounts2,'histc')
            plottingParameter(i,0)
            subplot(lgt1,3,3+3*i)
            bar(binranges,bincounts3,'histc')
            plottingParameter(i,0)
                     
        end   
    end   
end
findMinimum(holder)

end




