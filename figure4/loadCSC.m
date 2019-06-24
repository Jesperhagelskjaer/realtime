function [data,Timestamps,m] = loadCSC(par,i,chEnd)
    
    i = par.channels(i);

    fullNameCNS = strcat(par.path,'/csc/CSC',num2str(i),'.ncs');
    [Timestamps, ChannelNumbers, SampleFrequencies,NumberOfValidSamples, Samples, Header] = Nlx2MatCSC(fullNameCNS,[1 1 1 1 1], 1, 1, [] );
    %[Timestamps1,Samples1] = Nlx2MatCSC(fullNameCNS,[1 0 0 0 1],0,1,[]);
    
    Samples = Samples * str2double(Header{17,1}([13:end]))/1e-6;
    [m,n] = size(Samples);
    data = reshape(Samples,[1,n*m]);
    
    if i == chEnd
    test = find(NumberOfValidSamples(:) ~= 512);
    g=sprintf('%d ', test);fprintf('Block: %s\n', g)
    test = NumberOfValidSamples(find(NumberOfValidSamples(:) ~= 512));
    g=sprintf('%d ', test);fprintf('NumberOfValidSamples: %s\n', g)
    end
end

