function [par] = coherenceParameter(par,dataAdTempF)
% muHat is the sample mean
% sigmaHat is the square root of the unbiased estimator of the variance.
% mean and standard deviation in the arrays muCI and sigmaCI
% https://se.mathworks.com/help/stats/normfit.html

average = mean(dataAdTempF,2);

[~,sigmaHat,~,~] = normfit(average);
%y = normpdf(average,m,s);
%plot(average,y,'.');

par.stdValue = par.stdFactor*sigmaHat;
par.sigmaHat = sigmaHat;

fprintf('The coherency value of the signal: %2.0f\n',par.stdValue)

end

