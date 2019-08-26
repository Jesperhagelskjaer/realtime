function [par] = guiMain(par)

for i = 1:length(par.mainChannel{1})
    str = ['Channel ', num2str(par.mainChannel{1}(i))];
    prompt{i} = str;
    definput{i} = num2str(par.gradVal{1}(i));

end
prompt{end+1} = 'NCC score';
definput{end+1} = num2str(par.threshold);

dlgtitle = 'Input';
dims = [1 35];
answer = inputdlg(prompt,dlgtitle,dims,definput);

if ~isempty(answer)
for i = 1:length(par.mainChannel{1})
    par.gradVal{1}(i) = str2double(answer{i});
end

par.threshold = str2double(answer{4});
end
par.answer = answer;

end




