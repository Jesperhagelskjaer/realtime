function [dataRAW_NRD] = loadNRD(par)
NameNRD = '\nrd\CheetahRawData.nrd';
fullNameNRD = strcat(par.path,NameNRD);

for i = 1:length(par.channels)
    tic
    fprintf('loading nrd channel: %d',par.channels(i))
    
    
    %[~, SamplesNRD, Header] = Nlx2MatNRD(fullNameNRD,i-1 ,[1 1], 1, 1, [] );
    [SamplesNRD] = Nlx2MatNRD(fullNameNRD,par.channels(i)-1,[0 1], 0, 1, [] );
    
    if (i == 1 )
        dataRAW_NRD = zeros(length(SamplesNRD),length(par.spatial),'double');
    end
    
    dataRAW_NRD(:,i) = floor(SamplesNRD/16);
    time = toc;
    fprintf('   -   time %f.1\n',time)
    
end



end

