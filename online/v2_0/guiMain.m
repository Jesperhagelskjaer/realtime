function [par] = guiMain(par)

for i = 1:length(par.template{2})
    str = ['Channel ', num2str(par.template{2}(i))];
    prompt{i} = str;
    definput{i} = num2str(par.cutRange(i));
    
end
prompt{end+1} = 'NCC score';
definput{end+1} = num2str(par.threshold);


prompt{end+1} = 'remove/add channels';
definput{end+1} = '';

dlgtitle = 'Input';
dims = [1 35];
answer = inputdlg(prompt,dlgtitle,dims,definput);

if ~isempty(answer)
    for i = 1:length(par.template{2})
        par.cutRange(i) = str2double(answer{i});
    end
    
    par.threshold = str2double(answer{length(par.template{2})+1});
    ch = str2num(answer{length(par.template{2})+2});
    
    [value, index] = intersect(ch,par.template{2});
    par.template{2}(index) = []; par.cutRange(index) = []; %remove channel and cutrange
    
    for i = 1:length(value)
        ch(find(ch == value(i))) = [];
    end
    
    par.template{2} = [par.template{2} ch];
    par.cutRange = [par.cutRange [1:length(ch)]*mean(par.cutRange)];
    
    [par.template{2}, shufle] = sort(par.template{2});
    par.cutRange = par.cutRange(shufle);

    
end


par.answer = answer;

end




