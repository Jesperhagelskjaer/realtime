function [par] = calMinMax(par,dataF,rez)

temporal    = par.lengthTemplate;
mChls       = par.template{2};
indexCheck  = par.passed;


for i = 1:length(indexCheck)
    matrixHoldergrad2(i,:) = min(dataF(indexCheck(i)-[1:temporal],mChls(:)));
    matrixHoldergrad1(i,:) = max(dataF(indexCheck(i)-[1:temporal],mChls(:)));
end

par.holder = matrixHoldergrad2 - matrixHoldergrad1;


end







