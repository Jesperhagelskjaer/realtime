function [data] = data_N_PCA(par,data,c,str )

figure
subplot(2,1,1)
plot(data)
hold on


if strcmp(str,'P_same_trace')
    data = data./(sum(data.^2,1)/length(par.xAxis));
elseif strcmp(str,'P_part_trace')
   
    data_M = reshape(data,[size(data,1)/4 size(data,2)*4]);
    data_M = data_M./(sum(data_M.^2,1)/length(par.xAxis)); 
    data = reshape(data_M,[size(data,1) size(data,2)]);      
   
end

subplot(2,1,2)
plot(data)

end

