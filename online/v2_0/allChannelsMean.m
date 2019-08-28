function [par] = allChannelsMean(par,data,strV)
%tic;
%fprintf('Coherent check started    - ')

%The template length for the NCC
windowT = 1:par.lengthTemplate;

value = par.stdValue;
chN = par.mainChannel;
indexCheck = par.passed;
allChMinusMain = 1:par.spatial;
allChMinusMain(chN) = [];

for i = 1:length(indexCheck)
    [~,indexMin] = min(min(data(indexCheck(i)-windowT,chN)));
    [~,indexMax] = max(max(data(indexCheck(i)-windowT,chN)));
    meanHolderMin = mean(data(indexCheck(i)-indexMin,allChMinusMain));
    meanHolderMax = mean(data(indexCheck(i)-indexMax,allChMinusMain));
    if (meanHolderMin < -value(1) || meanHolderMax > value(2))
        indexCheck(i) = nan; %if not a valid spike
    end

end

indexCheck(isnan(indexCheck)) = [];


par.passed = indexCheck;





%time = toc;
%fprintf('finished. Elapsed time: %0.2f seconds\n',time)
end
