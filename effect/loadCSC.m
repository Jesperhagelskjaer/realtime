function [data,Timestamps,m] = loadCSC(path,ch)
    
    fullNameCNS = strcat(path,'csc/CSC',num2str(ch),'.ncs');
    [Timestamps, ChannelNumbers, SampleFrequencies,NumberOfValidSamples, Samples, Header] = Nlx2MatCSC(fullNameCNS,[1 1 1 1 1], 1, 1, [] );
    
    Samples = Samples * str2double(Header{17,1}([13:end]))/1e-6;
    [m,n] = size(Samples);
    data = reshape(Samples,[1,n*m]);
    
    %if i == chEnd
    %test = find(NumberOfValidSamples(:) ~= 512);
    %g=sprintf('%d ', test);fprintf('Block: %s\n', g)
    %test = NumberOfValidSamples(find(NumberOfValidSamples(:) ~= 512));
    %g=sprintf('%d ', test);fprintf('NumberOfValidSamples: %s\n', g)
    %end
end

