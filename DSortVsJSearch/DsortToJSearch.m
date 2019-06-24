function [true,falsePositive,par] = DsortToJSearch(timeDsort,timeJSearch,par)

jitter = par.jitter;
true = 0;falsePositive = 0;true_I = [];falseP_I = [];
for i = 1:length(timeDsort)
    index = floor(find(timeDsort(i)- jitter < timeJSearch  & timeDsort(i) + jitter > timeJSearch)); %the floor is more than one value is present
    if (isempty(index) == 0)
        true = true + 1;
        true_I = [true_I [timeDsort(i);i]];
    else
        falseP_I = [falseP_I [timeDsort(i);i]];
        falsePositive = falsePositive + 1;
        if (0 && falsePositive < 50)
            figure
            surf(dataFilt([-10:30]+timeStampsCluster(i),:))
            title(['dataFilt  ', num2str(timeStampsCluster(i))])
            view(0,0)
        end
    end
end
par.true_I_2 = true_I;
par.falseP_I = falseP_I;
end

