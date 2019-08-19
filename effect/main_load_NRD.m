function [datum] = main_load_NRD(par,datum,path)

if any(strcmpi(par.datatype,'nrd'))
    for ii = 1:size(par.path,1)
        
        for i = 1:length(par.chs{2})
            ch = par.chs{2}(i);
            fprintf('%0.0f - ', i )
            NameNRD = 'CheetahRawData.nrd';
            fullNameNRD = strcat(path{ii},'\nrd\',NameNRD);
            [Timestamps, SamplesNRD, Header] = Nlx2MatNRD(fullNameNRD,ch-1 ,[1 1], 1, 1, [] );
            %         figure
            %         plot(SamplesNRD(i,:))
            
            if (i == 1 )
                dataRAW = zeros(length(SamplesNRD),length(par.chs{2}),'double');
            end
            %convert from int24 from int16
            %dataRAW(:,i) = round(SamplesNRD/2^4);
            dataRAW(:,i) = SamplesNRD;
        end
        if strcmp(par.useBitmVolt,'Y')
            dataRAW = dataRAW * str2double(Header{14,1}([13:end]))/1e-6;
        end
        
        datum.NRD{ii} = dataRAW;
    end
    datum.Timestamps_NRD{ii} = Timestamps;
    
end