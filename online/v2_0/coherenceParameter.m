function [par] = coherenceParameter(par,datum_,varargin)
% muHat is the sample mean
% sigmaHat is the square root of the unbiased estimator of the variance.
% mean and standard deviation in the arrays muCI and sigmaCI
% https://se.mathworks.com/help/stats/normfit.html

if find(strcmp(varargin,'ext'))
    version = varargin{find(strcmp(varargin,'ext')) + 1}; %create better method
    if strcmp(version,'nrd')
        dataF = datum_.data_NRD_RAW;
    elseif strcmp(version,'csc')
        dataF = datum_.data_CSC_RAW;
    end
end



average = mean(dataF,2);

[~,sigmaHat,~,~] = normfit(average);
%y = normpdf(average,m,s);
%plot(average,y,'.');

par.stdValue = par.stdFactor*sigmaHat;
par.sigmaHat = sigmaHat;

fprintf('The coherency value of the signal: %2.0f\n',par.stdValue)

end

