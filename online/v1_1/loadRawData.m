function [dataRAW,par] = loadRawData(par,datum)

tic
fprintf('%-20s','Loading started')

if ~exist('datum.dataRAW','var')
    
if strcmp(par.dataLoad,'OE')

   Fid = fopen(strcat(par.path,par.data),'r'); 
   dataRAW = fread(Fid, [par.spatial inf], '*int16')'; %inf
    
elseif strcmp(par.dataLoad,'DL')
    for i = 1:par.spatial
fprintf('%0.0f - ', i )
    fullNameCNS = strcat(par.path,'CSC',num2str(i),'.ncs');
    [Timestamps, ChannelNumbers, SampleFrequencies,NumberOfValidSamples, Samples, Header] = Nlx2MatCSC(fullNameCNS,[1 1 1 1 1], 1, 1, [] );
     
    [m,n] = size(Samples);
    Samples = reshape(Samples,[1,n*m]);
    if (i ==1 )
        dataRAW = zeros(length(Samples),par.spatial,'double');
    end
    dataRAW(:,i) = Samples;
    
    end
   par.bitmVolt = str2double(Header{17,1}([13:end]))/1e-6;
   [dataRAW] = invertSignal(dataRAW,par);
elseif strcmp(par.dataLoad,'NRD')
   
    for i = 1:par.spatial
        fprintf('%0.0f - ', i )
        NameNRD = 'CheetahRawData.nrd';
        fullNameNRD = strcat(par.path,NameNRD);
        [~, SamplesNRD, Header] = Nlx2MatNRD(fullNameNRD,i-1 ,[1 1], 1, 1, [] );
%         figure
%         plot(SamplesNRD(i,:))
   
    if (i == 1 )
        dataRAW = zeros(length(SamplesNRD),par.spatial,'double');
    end   
    %convert from int24 from int16
    dataRAW(:,i) = round(SamplesNRD/2^4);
    
%     figure
%     plot(dataRAW(:,i))
%     figure
%     plot(SamplesNRD(i,:))
%     drawnow
    
    
    end
end

datum.dataRAW = dataRAW;

time = toc;
fprintf('%-20s %2.2f %-10s\n', '- finished   - Elepased time',time,'seconds')


end
end

