function [ ] = SaveFilterBinFile(  channels, y,fileName)

%fileName = 'FIR.bin';
% Save coefficeints to fileName
    numtabs = length(y);
    coeffBin = zeros(numtabs, channels);
    for i =1:channels
        coeffBin(:,i) = y;
    end
    fid = fopen(fileName, 'w');
    fwrite(fid, coeffBin, 'float');
    fclose(fid);
end

