function [dataJSearchF] = TTL_data(par,TTL_T,TTL_I,dataF)

timeC = TTL_T - TTL_T(1); %Substract to find the timestamp for the start of the recording

time = timeC(logical(TTL_I == 1)); %one correspond to laserPulse on
%sample = ceil(time/(1/30*1000)); %TTL is in time -> change into samples
sample = round(time/(17066/512));
for i = 1:length(time)

    dataJSearchF(:,:,i) = dataF(par.xAxis+sample(i),:);
    
    if 0 && i < 10
        h = figure;
        %subplot(2,1,1)
        hold on
        plot(dataJSearchF(:,1,i))
        plot([abs(par.samplesBefore) abs(par.samplesBefore)],[-50 50],'-r')
        %subplot(2,2,2)
        %surf(dataJSearchF(:,:,i))
        xlabel('time [samples]')
        ylabel('voltage [uV]')
        drawnow
        close(h)
        
    end
end
end

