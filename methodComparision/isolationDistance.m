function [] = isolationDistance(par,datum)

m = size(datum.CW_DS{1},1);
n = size(datum.CW_DS{1},2);

total = 0;
for i = 1:size(datum.CW_DS,2)
    total = total + size(datum.CW_DS{i},3);
end
waveform = zeros(total,m*n);

index = 0;c = [];
for i = 1:size(datum.CW_DS,2)
    for j = 1:size(datum.CW_DS{i},3)
        waveform(j+index,:) = reshape(datum.CW_DS{i}(:,:,j),[1 m*n]);
    end
    index = index + size(datum.CW_DS{i},3);
    c = [c ones(1,size(datum.CW_DS{i},3))*i];
end

[coeff,score,latent,tsquared,explained] = pca(waveform);

figure
hold on
xlabel('PC-1');ylabel('PC-2');zlabel('PC-3');
for i = 1:size(datum.CW_DS,2)
    score_h{i} = score(logical(c == i),1:3);
    scatter3(score_h{i}(:,1),score_h{i}(:,2),score_h{i}(:,3),0.02,'.')
end


mahal_d = mahal(score_h{1},score_h{2}); 

st = sort(mahal_d);
    
end