function [] = compare2GUI(par,TTL_T,TTL_I,dataF)


timeStart = TTL_T(1); %Substract to find the timestamp for the start of the recording
timeEnd = TTL_T(end);
%time = timeC(find(TTL_I == 1)); %one correspond to laserPulse on
%test = round(time*(1/30*1000)); %TTL is in time correct into samples
interval = timeStart:(1/30*1000):timeEnd;
for i = 1:length(time)

    dataJSearchF(:,:,i) = dataF(par.xAxis+test(i),:);
    
    if 1  && i > 162
        h = figure;
        subplot(2,2,1)
        hold on
        plot(dataJSearchF(:,1,i))
        plot([abs(par.samplesBefore) abs(par.samplesBefore)],[-50 50],'-r')
        subplot(2,2,2)
        surf(dataJSearchF(:,:,i))
        drawnow
        close(h)
        
    end
end
end



