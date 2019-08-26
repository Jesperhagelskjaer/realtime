function [jesper] = allChannelsCoherenct(dataF,jesper)

for ii = 1:length(jesper.template)
    
volt = jesper.voltage;
indexCheck = jesper.passed{ii};
temporal = abs(jesper.WindowN)-abs(jesper.WindowP);  

for i = 1:length(indexCheck)
    minData(i,:) = min(dataF(indexCheck(i)-[1:temporal],:));
    maxData(i,:) = max(dataF(indexCheck(i)-[1:temporal],:));
end

for i = 1:length(indexCheck)
    if (all(minData(i,:)) < -volt || all(maxData(i,:)) > volt )
        indexCheck(i) = nan; %if not a valid spike
    end
end


indexCheck = indexCheck(~isnan(indexCheck));

jesper.passCoherrent = indexCheck;
jesper.passed{ii} = indexCheck;

end

end