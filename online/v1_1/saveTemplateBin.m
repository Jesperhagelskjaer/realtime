function [jesper] = saveTemplateBin(jesper)

tempName = '11011608.bin';
template = jesper.reCalculateTemplate{1}(:,jesper.mainChannel{1});

if strcmp(jesper.signalInverted,'Y')
    template = template * -1;
    fprintf('Saved template is inverted\n')
end


fid = fopen(tempName,'w');
fwrite(fid,template','float');
fclose(fid);

jesper.templateToUpload = template;

% figure
% surf(template)
end

