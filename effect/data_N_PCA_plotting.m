function [] = data_N_PCA_plotting(data,c)

[coeff,score,latent,tsquared,explained] = pca(data');

% figure
% subplot(3,2,1)
% scatter(score(:,1),score(:,2),[],c,'.')
% axis equal
% xlabel('1st Principal Component')
% ylabel('2nd Principal Component')
figure
scatter3(score(:,1),score(:,2),score(:,3),2,c,'o')
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')

% figure
% plot(data)

end

