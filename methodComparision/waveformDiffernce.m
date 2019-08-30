function [] = waveformDiffernce(par,datum)

t_MC = datum.tSpikes_MClust;
t_DS = datum.tSpikes_DSort;
jitter = par.jitter;

%%Which contains the largest number of cluster
if size(t_MC,2) > size(t_DS,2)
    mC_largest = size(t_MC,2);
    largest = mC_largest;
elseif size(t_MC,2) < size(t_DS,2)
    mD_largest = size(t_DS,2);
    largest = mD_largest;
else
    equalSize = size(t_DS,2);
    largest = size(t_DS,2);
end

%% In agreement 

for i = 1:largest
    c_1 = 1;
    c_2 = 1;
    t_MC = datum.tSpikes_MClust{i};
    t_DS = datum.tSpikes_DSort{datum.shuffleVector(i)};
    for ii = 1:length(t_DS)
        index = floor(find(t_DS(ii)- jitter < t_MC  & t_DS(ii) + jitter > t_MC)); %the floor is more than one value is present
        if index
            inAgreement1{i}(:,:,c_1) = datum.spikes_DSort{datum.shuffleVector(i)}(:,:,ii);
            c_1 = c_1 + 1;
        else
            notfoundInMClust{i}(:,:,c_2) = datum.spikes_DSort{datum.shuffleVector(i)}(:,:,ii);
            c_2 = c_2 + 1;
        end
    end
end

for i = 1:largest
    c_1 = 1;
    t_MC = datum.tSpikes_MClust{i};
    t_DS = datum.tSpikes_DSort{datum.shuffleVector(i)};
    for ii = 1:length(t_MC)
        index = floor(find(t_MC(ii) - jitter < t_DS  & t_MC(ii) + jitter > t_DS)); %the floor is more than one value is present
        if isempty(index)
            notfoundInDSort{i}(:,:,c_1) = datum.spikes_MClust{i}(:,:,ii);
            c_1 = c_1 + 1;
        end
    end
end



datum.inAgreement1 = inAgreement1;
%PCA_Mahanobilis_allCh(par,datum) 
figure
surf(mean(inAgreement1{1},3))
title('inAgreement1')
figure
surf(mean(inAgreement1{2},3))
title('inAgreement1')
figure
surf(mean(notfoundInMClust{1},3))
title('notfoundInMClust')
figure
surf(mean(notfoundInMClust{2},3))
title('notfoundInMClust')
figure
surf(mean(notfoundInDSort{1},3))
title('notfoundInDSort')
figure
surf(mean(notfoundInDSort{2},3))
title('notfoundInDSort')




end





