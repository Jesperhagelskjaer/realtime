function [ par ] = CppNCC(par,dataFilt,stringValue)

temporal = par.lengthTemplate;
mChls = par.mainChannel;

template = double(par.reCalculateTemplate(:,mChls));
data = double(dataFilt(:,mChls));
NCC = normxcorr2_mex(template,data , 'full');
NCC = NCC(:,floor(size(NCC,2)/2)+1);
NCC = NCC(1:end-temporal+1);
NCC(temporal-NCC(end):NCC(end)) = [];
result = NCC;


passed = find(result >par.threshold);
resultPassed = result(passed);
test = diff(passed);
test = [10; test]; %correct the test to resultpassed vector

%find the maximum value of NCC score
for i = 1:length(test)
    if (test(i) == 1 )
        if resultPassed(i) > holder
            passed(i-1) = nan;
        else
            passed(i) = nan;
        end
    else
        holder = resultPassed(i);
    end
end

%passed = passed(~isnan(test));

passed = passed(~isnan(passed));


passed = passed(passed > 60);
passed = passed(passed < length(NCC)-60);

par.passed = passed;



end

