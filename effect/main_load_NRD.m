function [datum] = main_load_NRD(par,datum,path)

if any(strcmpi(par.filtertype,'nrd'))  
for ii = 1:size(par.path,2)
    
for i = 1:length(par.chs{2})
    ch = par.chs{2}(i);
    fprintf('%0.0f - ', i )
    NameNRD = 'CheetahRawData.nrd';
    fullNameNRD = strcat(path{ii},'\nrd\',NameNRD);
    [~, SamplesNRD, Header] = Nlx2MatNRD(fullNameNRD,ch-1 ,[1 1], 1, 1, [] );
    %         figure
    %         plot(SamplesNRD(i,:))
    
    if (i == 1 )
        dataRAW = zeros(length(SamplesNRD),length(par.chs{2}),'double');
    end
    %convert from int24 from int16
    dataRAW(:,i) = round(SamplesNRD/2^4);
end

datum.NRD{ii} = dataRAW;
end

end