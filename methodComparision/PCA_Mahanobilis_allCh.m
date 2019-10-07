function [] = PCA_Mahanobilis_allCh(par,datum,varargin)

%the length for the cut to take into the PCA calculation before and after
%the alignment peak
before = 10;
after = 10;
center = 100; %used for matrix to align must be smaller than par.Axis

if find(strcmp(varargin,'alignment'))
    input_alignment = varargin{find(strcmp(varargin,'alignment')) + 1};
end

if find(strcmp(varargin,'normalisation'))
    input_normalisation = varargin{find(strcmp(varargin,'normalisation')) + 1};
end

%the data load here cell array (time x channel x trace)
if 1
    data = datum.CW_All;
else
    stream1 = rand(50,4,500)*6;
    stream2 = rand(50,4,550)*6;
    for i = 1:4
        for k = 1:3
            stream1(25+k,i,:) = stream1(25+k,i,:)-10-1*k*i;
            if i > 1
                stream2(25+k,i,:) = stream2(25+k,i,:)-10-2*k*i;
            end
        end
    end
    data{1} = stream1;
    data{2} = stream2;
end

if strcmp(input_alignment,'min')
%find the index which to align each channel if the channels has minimum

%many many trace in total (smarter method???)
lgt = 0;
for cl = 1:size(data,2)
    lgt = lgt + size(data{cl},3);
end

% Create the matrix for the shifted waveform
j = size(data{1},2);
shiftMatrix = zeros(center*2,j,lgt);

%used for alignment
si = size(data{cl},1)-1;
count = 0; c = []; 

for cl = 1:size(data,2)
    for i = 1:size(data{cl},3)
    count = count + 1;
   
    %Finds the mimimum value of the trace over the four channels          
    [value,~] = min(min(data{cl}(:,:,i)));   
    [m, ~] = find(data{cl}(:,:,i) == value);        
        
    start = center-m;
    shiftMatrix(start:start+si,:,count) = data{cl}(:,:,i);  %holder for the corrected traces   
    end  
    c = [c ones(1,size(data{cl},3))*cl]; %coloring the scatter plot
end

%cutting out the non-excential part of the waveform (by eye)
shiftMatrix = shiftMatrix(center+[-before:after],:,:);

i = size(shiftMatrix,1);j = size(shiftMatrix,2);l = size(shiftMatrix,3);

%cat the traces into one trace
PCA_matrix = reshape(shiftMatrix,[i*j,l]);
end

if exist('input_normalisation','var')
    if strcmp(input_normalisation,'minMax')
        [value, ~] = min(min(PCA_matrix));
        PCA_matrix = PCA_matrix/abs(value);
    end
end

[coeff,score,latent,tsquared,explained] = pca(PCA_matrix');
Y2 = tsne(PCA_matrix','Algorithm','exact','Distance','euclidean','NumDimensions',3);

figure
scatter3(Y2(:,1),Y2(:,2),Y2(:,3),[],c,'filled')
title('TSNE euclidean')



figure
scatter3(score(:,1),score(:,2),score(:,3),[],c,'filled')
xlabel('PC-1');ylabel('PC-2');zlabel('PC-3');

for i = 1:size(data,2)
    score_h{i} = score(logical(c == i),1:3);
end
str1 = "Isolation distance failed due to few points";
str2 = "Isolation distance - ";
str3 = 'L ratio - ';
for m = 1:size(data,2)
    for n = 1:size(data,2)     
        mahal_d(m,n) = mahal(mean(score_h{m}),score_h{n}); %Compute the squared Euclidean distance of each observation in Y from the mean of X .  
    end
    index1 = find(c == m);
    index2 = find(c ~= m); 
    mahal_sorted = sort(mahal(score(index2,1:3),score(index1,1:3)));
    L(m) = sum(1-chi2cdf(mahal_sorted,3));
    L_ratio(m) = L(m)/length(index1);
    fprintf('\ncluster %d: %s %2.2f\n',m,str3,L_ratio(m) );
    if (mahal_sorted < length(index1))
        fprintf('cluster %d: %s\n',m,str1 );
        d_isolation(m) = nan; 
    else     
        d_isolation(m) = mahal_sorted(length(index1));
        fprintf('cluster %d: %s %0.2f\n',m,str2,d_isolation(m) );
    end
end







mahal_d
datum.mahal_d = mahal_d;
% 
% table_M_Distance(par,datum)
% 
 end




