function [data,Timestamps,m] = loadCSC(par,ch)
    path = par.path;
    fullNameCNS = strcat(path,'/csc/CSC',num2str(ch),'.ncs');
    [Timestamps, ChannelNumbers, SampleFrequencies,NumberOfValidSamples, Samples, Header] = Nlx2MatCSC(fullNameCNS,[1 1 1 1 1], 1, 1, [] );
    if strcmp(par.useBitmVolt,'Y')  
        Samples = Samples * str2double(Header{17,1}([13:end]))/1e-6;
    end
    [m,n] = size(Samples);
    data = reshape(Samples,[1,n*m]);
    
    %if i == chEnd
    %test = find(NumberOfValidSamples(:) ~= 512);
    %g=sprintf('%d ', test);fprintf('Block: %s\n', g)
    %test = NumberOfValidSamples(find(NumberOfValidSamples(:) ~= 512));
    %g=sprintf('%d ', test);fprintf('NumberOfValidSamples: %s\n', g)
    %end
end

