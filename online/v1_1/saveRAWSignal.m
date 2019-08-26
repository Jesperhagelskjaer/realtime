function [] = saveRAWSignal(jesper,dataRAW)

sPath = '';
dataRawS = dataRAW(1:jesper.saveLength,1:jesper.spatial);
dataRAWS_single = single(dataRawS);
name = strcat(sPath,'DATA.bin');
fid = fopen(name,'w');
fwrite(fid,dataRAWS_single','float');
fclose(fid);

end

