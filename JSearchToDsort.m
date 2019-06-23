function [true,falseNegative,par] = JSearchToDsort(timeDsort,timeJSearch,par)


jitter = par.jitter;
true = 0;falseNegative = 0;true_I = [];falseN_I = [];
for i = 1:length(timeJSearch)
    index = floor(find(timeJSearch(i)- jitter < timeDsort  & timeJSearch(i) + jitter > timeDsort)); %the floor is more than one value is present
    if (isempty(index) == 0)
        true_I = [true_I [timeJSearch(i); i ]];
        true = true + 1;
    else
        falseN_I = [falseN_I [timeJSearch(i); i]];
        
        falseNegative = falseNegative + 1;
        if (0 && falseNegative < 50)
            figure
            surf(dataFilt([-10:30]+timeStampsCluster(i),:))
            title(['dataFilt  ', num2str(timeStampsCluster(i))])
            view(0,0)
        end
    end
end
par.true_I_1 = true_I;
par.falseN_I = falseN_I;


end

