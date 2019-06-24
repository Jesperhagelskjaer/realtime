function [] = averageSum(data)

figure
for i = 1:size(data,3)
    
    average = mean(data(:,:,1:i),3);
     
    subplot(2,2,1)
    surf(average)
    subplot(2,2,2)
    plot(average(:,1))
    subplot(2,2,3)
    plot(data(:,1,i))
    
end

