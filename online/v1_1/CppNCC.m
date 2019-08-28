function [ par ] = CppNCC(par,dataFilt,iCHT,iCHTre,iNNC,rez)

%tic
temporal = abs(par.WindowN(iCHT))+ par.WindowP(iCHTre)+1;




for ii = 1:length(par.template)

timeDSortSearch = rez.st(find(rez.st(:,8) == par.template(ii)),1);
%timeDSortSearch( timeDSortSearch > par.lengthGroundt) = [];   
    
mChls = par.mainChannel{ii};  
figure
surf(par.reCalculateTemplate{ii})
title('Template used')
hold on
surf(par.reCalculateTemplate{ii},mChls)

template = double(par.reCalculateTemplate{ii}(:,mChls));
data = double(dataFilt(:,mChls));
NCC = normxcorr2_mex(template,data , 'full');
NCC = NCC(:,floor(size(NCC,2)/2)+1);
NCC = NCC(1:end-temporal+1);
NCC(temporal-NCC(end):NCC(end)) = [];
result = NCC;

if 1 
   test1 = normxcorr2(template,data);
   test1 = test1(:,floor(size(test1,2)/2)+1);
end

passed = find(result >par.threshold(iNNC));
test = diff(passed);
for i = 1:length(test)
    if (test(i) == 1)
        test(i) = nan;
    end
end
passed = passed(~isnan(test));

passed = passed(passed > 40);
passed = passed(passed < length(NCC)-40);
par.NCC{ii} = result;
par.passed{ii} = passed;
par.NCCpassed{ii} = passed;
%time = toc;
%fprintf(' - finished. Elapsed time: %0.2f seconds\n',time);
end

