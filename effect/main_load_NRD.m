function [data] = main_load_NRD(par,path)

for i = 1:length(par.template_LFP{2})
    ch = par.template_LFP{2}(i);
    fprintf('%0.0f - ', i )
    NameNRD = 'CheetahRawData.nrd';
    fullNameNRD = strcat(path,'\nrd\',NameNRD);
    [~, SamplesNRD, Header] = Nlx2MatNRD(fullNameNRD,ch-1 ,[1 1], 1, 1, [] );
    %         figure
    %         plot(SamplesNRD(i,:))
    
    if (i == 1 )
        dataRAW = zeros(length(SamplesNRD),length(par.template_LFP{2}),'double');
    end
    %convert from int24 from int16
    dataRAW(:,i) = round(SamplesNRD/2^4);
end

data.NRD = dataRAW;
end
