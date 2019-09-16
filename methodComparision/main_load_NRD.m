function [datum] = main_load_NRD(par,datum,path)
    
    for ii = 1:size(par.path,1)
       fprintf('Loading channels [nrd]: ') 
        for i = 1:length(par.chs{2})
            ch = par.chs{2}(i);
            
            %fprintf('%0.0f - ', i )
            if i > 1
                fprintf(repmat('\b', 1, 10 ));
            end
            
            fprintf('%d out of %d',length(par.chs{2}),i)
            
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
        fprintf('\n')
    end
    datum.Timestamps_NRD{ii} = Timestamps;
    
end