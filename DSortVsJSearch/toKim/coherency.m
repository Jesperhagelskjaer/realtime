

%The template length
windowT = -par.lengthTemplate;

%The index where the NCC score is above the threshold
indexCheck = par.passed;

% The values the signal has to be below and above 
value = par.stdValue;

%The template is defined on all 32 channels but we are only intersered in
%tetrode bundle
chN = par.channelMapTo;


%The minimum and maximum index of the template used for the NCC 
[~,indexTMMin] = min(par.reCalculateTemplate(:,par.chMain));
[~,indexTMax]  = max(par.reCalculateTemplate(:,par.chMain));

%Creates the spatial index for for which channels to calcualte the mean
%from
allChMinusMain = 1:par.spatial;
allChMinusMain(chN) = [];


for i = 1:length(indexCheck)
    newIndexMin = indexCheck(i) + windowT + indexTMMin;
    newIndexMax = indexCheck(i) + windowT + indexTMax;
    %data is the recorded session
    meanHolderMin = mean(data(newIndexMin,allChMinusMain));
    meanHolderMax = mean(data(newIndexMax,allChMinusMain));
    if (meanHolderMin < -value(1) || meanHolderMax > value(2))
        indexCheck(i) = nan; %if not a valid spike
    end

end
%remove all the nan (the one that did not pas this gate)
indexCheck(isnan(indexCheck)) = [];



end
