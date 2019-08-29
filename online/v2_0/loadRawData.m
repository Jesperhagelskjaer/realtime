function [datum,par] = loadRawData(par,datum)

tic
%fprintf('%-20s','Loading started')



if strcmp(par.dataLoad,'OE')
    
    Fid = fopen(strcat(par.path,par.data),'r');
    dataRAW = fread(Fid, [par.spatial inf], '*int16')'; %inf
end

if any(strcmp(par.dataLoad,'csc'))
    
    fprintf('Loading channels [csc]: ')
    for i = 1:par.spatial
        printChannel(par,i)
        
        fullNameCNS = strcat(par.path,'\csc\CSC',num2str(i),'.ncs');
        [Timestamps, ChannelNumbers, SampleFrequencies,NumberOfValidSamples, Samples, Header] = Nlx2MatCSC(fullNameCNS,[1 1 1 1 1], 1, 1, [] );
        
        [m,n] = size(Samples);
        Samples = reshape(Samples,[1,n*m]);
        if (i ==1 )
            dataRAW = zeros(length(Samples),par.spatial,'double');
        end
        dataRAW(:,i) = Samples;
        
    end
    par.bitmVolt = str2double(Header{17,1}([13:end]))/1e-6;
    [dataRAW] = invertSignal(par,dataRAW);
    datum.data_CSC_RAW = dataRAW;
    fprintf('\n')
end

if ~isfield(datum,'data_NRD_RAW')
    if any(strcmp(par.dataLoad,'nrd'))
        
        fprintf('Loading channels [nrd]: ')
        for i = 1:par.spatial
            
            printChannel(par,i)
            
            %fprintf('%0.0f - ', i )
            NameNRD = '\nrd\CheetahRawData.nrd';
            fullNameNRD = strcat(par.path,NameNRD);
            [~, SamplesNRD, Header] = Nlx2MatNRD(fullNameNRD,i-1 ,[1 1], 1, 1, [] );
            %         figure
            %         plot(SamplesNRD(i,:))
            
            if (i == 1 )
                dataRAW = zeros(length(SamplesNRD),par.spatial,'double');
            end
            %convert from int24 from int16
            dataRAW(:,i) = round(SamplesNRD/2^4);
            
        end
        
        datum.data_NRD_RAW = dataRAW;
        fprintf('\n')
    end
end

time = toc;
%fprintf('%-20s %2.2f %-10s\n', '- finished   - Elepased time',time,'seconds')

end






