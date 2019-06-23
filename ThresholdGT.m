function [par] = ThresholdGT(par,temp_J,temp_D,falseNegative)


jitter = par.jitter;
t_D = temp_D(par.indexAbove_D ); %temporal index above threshold
falseN_I = par.falseN_I(1,:);         %index false negative
falseP_I = falseN_I(1,:);
 
spikeAboveJ = temp_J(par.indexAbove_J);

%positive = 0;negative = 0;light = [];
for i = 1:length(t_D)
    index = floor(find(t_D(i)- jitter < falseN_I  & t_D(i) + jitter > falseN_I)); %the floor is more than one value is present
    if (isempty(index) == 0)
        %positive = positive + 1;
        light = [light t_D(i)];
    else
       % negative = negative + 1;
    end
end
%positive1 = 0;negative1 = 0;
for i = 1:length(spikeAboveJ)
    index = floor(find(spikeAboveJ(i)- jitter < light  & spikeAboveJ(i) + jitter > light)); %the floor is more than one value is present
    if (isempty(index) == 0)
        positive1 = positive1 + 1;
    else
        negative1 = negative1 + 1;
 
    end
end


for i = 1:length(t_D)
    index = floor(find(t_D(i)- jitter < falseN_I  & t_D(i) + jitter > falseN_I)); %the floor is more than one value is present
    if (isempty(index) == 0)
        %positive = positive + 1;
        light = [light t_D(i)];
    else
       % negative = negative + 1;
    end
end
%positive1 = 0;negative1 = 0;
for i = 1:length(spikeAboveJ)
    index = floor(find(spikeAboveJ(i)- jitter < light  & spikeAboveJ(i) + jitter > light)); %the floor is more than one value is present
    if (isempty(index) == 0)
        positive1 = positive1 + 1;
    else
        negative1 = negative1 + 1;
 
    end
end





fprintf('%d out of %d spikes above threshold is seen %d in the falseNegative pool\n',positive1,length(t_D),falseNegative)



end




