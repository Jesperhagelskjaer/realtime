function [] = loadRawNRD_Data(ops)
tic
fprintf('%-20s','Loading started')



for i = 1:length(par.chs)

    fullNameNRD = strcat(par.path{1},par.e_str,'\CheetahRawData.nrd');
    
    [~, SamplesNRD, Header] = Nlx2MatNRD(fullNameNRD,par.chs(i-1) ,[1 1], 1, 1, [] );
    SamplesNRD = round(SamplesNRD/2^4);
     
    if (i == 1 )
        ops.bitmVolt = str2double(Header{14,1}([13:end]))/1e-6;
        dataRAW = zeros(length(SamplesNRD),ops.NchanTOT,'double');
    end
    
    dataRAW(:,i) = SamplesNRD;

end

dataRAW = useBit2VoltParameter(dataRAW,ops);
dataRAW = invertSignal(dataRAW,ops);
    
        
Samples         = dataRAW';
fwrite(fidout, Samples, 'int16');   %Samples must in channel x time (as with openEphys)

time = toc;
fprintf('%-20s %2.2f %-10s\n', '- finished   - Elepased time',time,'seconds')

    
end



