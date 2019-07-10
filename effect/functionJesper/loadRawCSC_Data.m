function [dataRAW] = loadRawCSC_Data(par)
tic
fprintf('%-20s','Loading started')

for i = 1:length(par.chs)
    fprintf('Loading Ch - %d\n',par.chs(i))
    fullNameCNS = strcat(par.path{1},par.e_str,'\CSC',num2str(par.chs(i)),'.ncs');
    [Timestamps, ChannelNumbers, SampleFrequencies,NumberOfValidSamples, Samples, Header] = Nlx2MatCSC(fullNameCNS,[1 1 1 1 1], 1, 1, [] );
    
    [m,n] = size(Samples);
    Samples = reshape(Samples,[1,n*m]);
    
    par.bitmVolt = str2double(Header{17,1}([13:end]))/1e-6;
    Samples = useBit2VoltParameter(Samples,par);
    Samples = invertSignal(Samples,par);
    
    
    if (i == 1 )
        dataRAW = zeros(length(Samples),length(par.chs),'int16');
    end
    
    dataRAW(:,i) = Samples;
end

dataRAW = double(dataRAW);
time = toc;
fprintf('%-20s %2.2f %-10s\n', '- finished   - Elepased time',time,'seconds')
end

