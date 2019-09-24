function [datum] = traceJSearch(par,datum,varargin)

if find(strcmp(varargin,'type'))
    if strcmp(varargin{find(strcmp(varargin,'type')) + 1},'csc')
        dataF =  datum.CSC;
        timestamps = datum.Timestamps_CSC;
    elseif strcmp(varargin{find(strcmp(varargin,'type')) + 1},'nrd')
        dataF = datum.NRD_F;
        timestamps = datum.Timestamps_CSC;
    end
end

xAxis = par.xAxis;

for ii = 1:size(par.path,1)
    
    TTLs = datum.TTLs{ii};
    TTLs_time = datum.TimestampsEvent{ii};
    timestamps = datum.Timestamps_CSC;
    
    mBlockSize = 512;
    time = TTLs_time(logical(TTLs == 1)); %one correspond to laserPulse on
    indexSampleLight = [];
    
    indexVector = 17066/512 * (0:511); %creates the time vector for a block
    for i = 1:length(time)
        indexBlock = find(time(i) <= timestamps,1) - 1; %%check to find better way
        if (indexBlock == 0)
            
        else
            %the minus we need to start at the back of the block
            
            createTimeVector = timestamps(indexBlock) + indexVector;
            %create the timeseries for the block
            indexTimeBlock = find(time(i) <= createTimeVector,1)-1;
            if isempty(indexTimeBlock)
                indexTimeBlock = 512;% check up on
            end
            indexSampleLight(i) = (indexBlock-1) * mBlockSize + indexTimeBlock;
            dataJSearchF(:,:,i) = dataF(xAxis+indexSampleLight(i)+par.indexShift,:);
            %dataJSearchF_shift{ii}(:,:,i) = dataF{ii}(xAxis+indexSampleLight(i)-par.shifted,:);
            %dataRAW_NRD_mat(:,:,i-1) = dataRAW_NRD(par.xAxis+indexSampleLight(i-1),:);
        end
        
    end
    
end
 
    datum.CW_JS{1}          = dataJSearchF;
    datum.CW_t_JS{1}        = indexSampleLight;
    datum.CW_mean_JS{1}     = mean(dataJSearchF,3);
%     figure
%     surf(mean(datum.CW_JS,3))
%     
%     reshape(datum.CW_JS,[1 *] 
    
end
        
