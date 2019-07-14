function [dataJSearchF,dataJSearchF_shift] = TTL_data_Index(par,timestamps,TTLs,TTLs_time,dataF)
mBlockSize = 512;
time = TTLs_time(logical(TTLs == 1)); %one correspond to laserPulse on

indexVector = 17066/512 * (0:511); %creates the time vector for a block
for i = 1:length(time)
    indexBlock = find(time(i) <= timestamps,1) - 1; %%check to find better way
    %the minus we need to start at the back of the block
    
    createTimeVector = timestamps(indexBlock) + indexVector;
    %create the timeseries for the block
    indexTimeBlock = find(time(i) <= createTimeVector,1)-1;
    if isempty(indexTimeBlock)
        indexTimeBlock = 512;% check up on
    end
    indexSampleLight(i) = (indexBlock-1) * mBlockSize + indexTimeBlock;
    dataJSearchF(:,:,i) = dataF(par.xAxis+indexSampleLight(i),:);
    dataJSearchF_shift(:,:,i) = dataF(par.xAxis+indexSampleLight(i)-par.shifted,:);
    %dataRAW_NRD_mat(:,:,i-1) = dataRAW_NRD(par.xAxis+indexSampleLight(i-1),:);
    
    
    if 0 && i < 10
        h = figure;
        subplot(2,2,1)
        plot(dataJSearchF(:,1,i))
        subplot(2,2,2)
        surf(dataJSearchF(:,:,i))
%         subplot(2,2,3)
%         plot(dataRAW_NRD(:,par.channels(1),i-1))
%         subplot(2,2,4)
%         surf(dataRAW_NRD_mat(:,par.channels,i-1))
        %indexBlock
        drawnow
        close(h)
        
    end
end
end

