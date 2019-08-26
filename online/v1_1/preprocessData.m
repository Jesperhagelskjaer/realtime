function preprocessData(fslow,fshigh,dataRAW,jesper)

tic;

filterType = jesper.filType;
fs = jesper.fs;

if strcmp(filterType,'bandpass')
    [b1, a1] = butter(3, [fshigh/fs,fslow/fs]*2, 'bandpass');
else
    [b1, a1] = butter(3, fshigh/fs*2, 'high');
end



if strcmp(jesper.useGPU,'YES')
    
    
    
    d = whos('dataRAW');
    GPU = gpuDevice;
    totalBlock = ceil((d.bytes*500)/GPU.AvailableMemory);
    offset = ceil(size(dataRAW,1) / (totalBlock));
    datcpu = zeros(size(dataRAW,1),size(dataRAW,2));    
    offsetOld = 0;
    
    for i = 1:totalBlock
        i
        matrix = single(dataRAW(1+offsetOld:offsetOld+offset,:));
        dataRAWGPU = gpuArray(matrix);
        
        datr = filter(b1, a1, dataRAWGPU);
        datr = flipud(datr);
        datr = filter(b1, a1, datr);
        datr = flipud(datr);
        
        
        datcpu(1+offsetOld:offsetOld+offset,:)  = gather_try(int16(datr));
        offsetOld = offsetOld + offset;
        
        if (i == (totalBlock-1))
            offset = offsetOld - size(dataRAW,1);
        end
        
    end
    
else
    
    datr = filter(b1, a1, dataRAW);
    datr = flipud(datr);
    datr = filter(b1, a1, datr);
    datr = flipud(datr);
    
end
toc


end
