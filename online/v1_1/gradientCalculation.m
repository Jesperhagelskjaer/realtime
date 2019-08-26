function [par] = gradientCalculation(par,dataFilt,rez)


WindowN = par.WindowN;
WindowP = par.WindowP;
temporal = abs(WindowN)-abs(WindowP);

backward = 5;

for ii = 1:length(par.template)
    
    indexCheck = par.NCCpassed{ii};
    
    GT = par.GT{ii}(:);
    
    mChls = par.mainChannel{ii};
    valuesToPassM = par.gradVal{ii};
    indexpassedGradient = []; indexpassedAmplitudeAll = [];matrixHolderPassed = [];kk = 1;
    
    holder = zeros(length(indexCheck),length(mChls));
    for i = 1:length(indexCheck)
        for m = 1:length(mChls)
            [value, index]   = min(dataFilt(indexCheck(i)-[1:temporal],mChls(m)));
  
            holder(i,m)      = value-dataFilt(indexCheck(i)-index-backward,mChls(m));
        end
    end

    minHolder = min(min(holder));
    
    for k = 1:length(indexCheck)
        if all(holder(k,:) < valuesToPassM  )
            indexpassedGradient(kk) = indexCheck(k); %can be made better
            indexpassedAmplitudeAll{ii}(kk) = indexCheck(k);
            matrixHolderPassed(kk,:) = holder(k,:);
            kk = kk + 1;
        end
    end
    
    holderGT = zeros(length(GT),length(mChls));
    
    for i = 1:length(GT)
        for m = 1:length(mChls)
            [value, index]         = (min(dataFilt(GT(i)+[-5:5],mChls(m))));
            holderGT(i,m)          = value-dataFilt(GT(i)+index-5-backward,mChls(m));
        end
    end
 
lgt1 = length(par.mainChannel{ii});

if 1
    figure
    for i = 0:length(par.mainChannel{ii})-1
        
        if strcmp(par.useBitmVolt,'Y')
            binranges = -400:10:50;
            xString = 'Volt [uV]';
        else
            binranges = minHolder:1:250;
            xString = '[Bits]';
        end
        
        [bincounts1] = histc(holderGT(:,i+1),binranges);
        [bincounts2] = histc(holder(:,i+1),binranges);
        [bincounts3] = histc(matrixHolderPassed(:,i+1),binranges);
        length(matrixHolderPassed(:,i+1))
        subplot(lgt1,3,1+3*i)
        bar(binranges,bincounts1,'histc')
        title('DSort')
        xlabel(xString)
        subplot(lgt1,3,2+3*i)
        bar(binranges,bincounts2,'histc')
        title('gradient JSearch')
        xlabel(xString)
        subplot(lgt1,3,3+3*i)
        bar(binranges,bincounts3,'histc')
        title('gradint passed JSearch')
        xlabel(xString)
    end
    
end



end
par.indexpassedAmplitudeAll = indexpassedAmplitudeAll;
par.passedGradient = indexpassedAmplitudeAll;
end





