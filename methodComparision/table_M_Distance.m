function [] = table_M_Distance(par,datum)

intry_Text = [];
value = datum.label_WS_All;
a = 1;b = 1; c = 1;
for i = 1:length(value)

    %1 agreement, 2 NSI_Mc, 3 NSI_DS
    if (value(i) == 1)
        intry_Text{i} = strcat('Agreement ',num2str(a));
        a = a + 1;
    elseif (value(i) == 2)
        intry_Text{i} = strcat('NSI_MC',num2str(b));
        b = b + 1;
    elseif (value(i) == 3)
        intry_Text{i} = strcat('NSI_DS',num2str(c));
        c = c +1;
    end

end
test = datum.mahal_d;
test = test(:,~all(isnan(test))); %remove all nan in columns
out = test(all(~isnan(test),2),:); % remove all nan - rows

sTable = array2table(out ,'RowNames',intry_Text,'VariableNames',intry_Text)

filename = strcat(par.path,'\jesper\bundle',num2str(ceil(max(par.template_LFP{2})/4)-1),'_distance.xlsx');   
writetable(sTable,filename,'WriteRowNames',true)


end

