function [jesper] = saveTemplateBin(jesper)

tempName = '33261004.bin';
template = jesper.reCalculateTemplate(:,jesper.mainChannel);

if strcmp(jesper.signalInverted,'Y')
    template = template * -1;
    fprintf('Saved template is inverted\n')
end


fid = fopen(tempName,'w');
fwrite(fid,template','float');
fclose(fid);

jesper.templateToUpload = template;

figure
surf(template)
end

