function [] = table_M_Distance(par,datum)

intry_Text = [];
value = datum.label_WS_All;
a = 1;b = 1; c = 1;
for i = 1:length(value)

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

sTable = array2table(datum.mahal_d ,'RowNames',intry_Text,'VariableNames',intry_Text)

filename = strcat(par.path,'\jesper\bundle',num2str(ceil(max(par.template_LFP{2})/4)-1),'_distance.xlsx');   
writetable(sTable,filename,'WriteRowNames',true)


end

