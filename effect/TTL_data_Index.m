function [dataJSearchF,dataJSearchF_shift,indexSampleLight] = TTL_data_Index(par,TTLs,TTLs_time,datum,varargin)

if find(strcmp(varargin,'type'))
    if strcmp(varargin{find(strcmp(varargin,'type')) + 1},'csc')
        dataF =  datum.CSC;
         timestamps = datum.Timestamps_CSC;
    elseif strcmp(varargin{find(strcmp(varargin,'type')) + 1},'nrd')
        dataF = datum.NRD_F;
        timestamps = datum.Timestamps_CSC;
    end
end



xAxis = par.interval(1):par.interval(2);

for ii = 1:size(par.path,1)
   
    mBlockSize = 512;
    time = TTLs_time{ii}(logical(TTLs{ii} == 1)); %one correspond to laserPulse on
    indexSampleLight = [];
    
    indexVector = 17066/512 * (0:511); %creates the time vector for a block
    for i = 1:length(time)
        indexBlock = find(time(i) <= timestamps{ii},1) - 1; %%check to find better way
        if (indexBlock == 0)
            
        else
            %the minus we need to start at the back of the block
            
            createTimeVector = timestamps{ii}(indexBlock) + indexVector;
            %create the timeseries for the block
            indexTimeBlock = find(time(i) <= createTimeVector,1)-1;
            if isempty(indexTimeBlock)
                indexTimeBlock = 512;% check up on
            end
            indexSampleLight(i) = (indexBlock-1) * mBlockSize + indexTimeBlock;
            dataJSearchF{ii}(:,:,i) = dataF{ii}(xAxis+indexSampleLight(i),:);
            dataJSearchF_shift{ii}(:,:,i) = dataF{ii}(xAxis+indexSampleLight(i)-par.shifted,:);
            %dataRAW_NRD_mat(:,:,i-1) = dataRAW_NRD(par.xAxis+indexSampleLight(i-1),:);
        end
        
        %     if 1 && i == 100
        %         h = figure;
        %         subplot(2,2,1)
        %         plot(dataJSearchF(:,1,i))
        %         subplot(2,2,2)
        %         surf(dataJSearchF(:,:,i))
        %         subplot(2,2,3)
        % %        plot(dataRAW_NRD(:,par.channels(1),i-1))
        % %        subplot(2,2,4)
        % %        plot(dataRAW_NRD_mat(:,par.channels,i-1))
        %         drawnow
        %         close(h)
        
    end
end
end

