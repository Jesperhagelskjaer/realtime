
clc
clear all
close all
templateSize = 3;

spatialSize = 32;
rank = 3;
template = ones(1,templateSize);
dataU = zeros(1,(templateSize)*rank);
U = ones(spatialSize,rank);
W = ones(1,(templateSize)*rank);
weights = ones(1,3);
templateSizeRank = templateSize*rank; 
data = zeros(32,40);
indexData = 1;
sumData = 0;
indexUMod = 0;
indexWMod = 0;

while(true) 
    checkSum = 0;
    for i = 0:templateSize-1 %loop for the U times the sata    
        indexU = mod(indexUMod,templateSizeRank);      
        for r = 1:rank
            for n = 1:spatialSize
                sumData = sumData + data(n,indexData)*U(n,r); %correspond to the U times data
            end
            dataU(:,r + indexU ) = sumData;
            sumData = 0;
        end
        sum = 0;
        for m = 0:templateSize-1  
            indexW = mod(indexWMod+indexU,templateSizeRank)
            for r = 1:rank
                sum = sum + dataU(indexW+r)*W(indexW+r)*weights(r);
            end
            indexWMod = indexWMod + 3;
        end
        indexUMod = indexUMod + 3;
        indexData = indexData + 1;
    end
    U = U + ones(1,rank);
end
