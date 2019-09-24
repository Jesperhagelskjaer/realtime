function [] = plotTemplateJS(dataTraceJ_NRD_shift)

data_M = mean(dataTraceJ_NRD_shift{1},3);

figure
surf(data_M)
end

