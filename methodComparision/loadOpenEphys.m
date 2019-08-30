function [datum] = loadOpenEphys(par,datum)

ch = par.template_LFP{2};

for i = 1:length(ch)

    [d, timestamps, ~] = load_open_ephys_data(strcat(par.path,sprintf('/100_CH%d.continuous',ch(i))));
    
    if i == 1
        data = zeros(size(d,1),size(d,2));
        datum.First = timestamps(1);
    end
    
    data(:,i) = d;

end

datum.CSC_RAW = data;

end

%[d, timestamps, info] = load_open_ephys_data(strcat(par.path,sprintf('/100_CH%d.continuous',1)));

