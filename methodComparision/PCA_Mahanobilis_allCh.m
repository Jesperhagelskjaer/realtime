function [] = PCA_Mahanobilis_allCh(par,datum,varargin)
%07/04/2019
%made by Jesper Hagelskj�r Ph.D.
%the length for the cut to take into the PCA calculation before and after
%the alignment peak

%Note - AC must be negative
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% paper - Quantitative measures of cluster quality for use in extracellular recordings
% isolation distance bound [0 inf] larger is better
% l_ratio bound [0 inf] smaller is better
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


center = 100;   % center for the alignment of the waveform
cut  = [10 10]; %points taking before after aligment peak into the pca calculation

if find(strcmp(varargin,'alignment'))
    input_alignment = varargin{find(strcmp(varargin,'alignment')) + 1};
end

if find(strcmp(varargin,'normalisation'))
    input_normalisation = varargin{find(strcmp(varargin,'normalisation')) + 1};
end

%the data is cell arrays (time x channel x trace)
data = datum.CW_All;

if strcmp(input_alignment,'min')
    %find the index which to align each channel with different minimum pr.
    %trace
    
    %many many traces in total (smarter method???)
    lgt = 0;
    for cl = 1:size(data,2)
        lgt = lgt + size(data{cl},3);
    end
    
    % Create the matrix for the shifted waveforms
    shiftMatrix = zeros(center*2,size(data{1},2),lgt);
    
    %used for alignment
    si = size(data{cl},1)-1;
    count = 0; c = [];
    
    for cl = 1:size(data,2)
        for i = 1:size(data{cl},3)
            count = count + 1;
            
            %Finds the mimimum value of the trace over the four channels
            [value,~] = min(min(data{cl}(:,:,i)));
            [m, ~] = find(data{cl}(:,:,i) == value);
            
            start = center-m(1); %(1) if is index more than one index having the value take the first value 
            shiftMatrix(start:start+si,:,count) = data{cl}(:,:,i);  %holder for the corrected traces
        end
        c = [c ones(1,size(data{cl},3))*cl]; %coloring the scatter plot
    end
    
    %cutting out the non-excential part of the waveform (by eye)
    shiftMatrix = shiftMatrix(center+[-cut(1):cut(2)],:,:);
    
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

[~,score,~,~,~] = pca(PCA_matrix');

figure
scatter3(score(:,1),score(:,2),score(:,3),[],c,'filled')
xlabel('PC-1');ylabel('PC-2');zlabel('PC-3');

for i = 1:size(data,2)
    score_h{i} = score(logical(c == i),1:3);
end

% Calculates the differente seperation variable
for m = 1:size(data,2)
    for n = 1:size(data,2)
        mahal_d(m,n) = mahal(mean(score_h{m}),score_h{n}); %Compute the squared Euclidean distance of each observation in Y from the mean of X .
    end
    index1 = find(c == m);
    index2 = find(c ~= m);
    mahal_sorted = sort(mahal(score(index2,1:3),score(index1,1:3)));
    L(m) = sum(1-chi2cdf(mahal_sorted,3)); %L-isolation (standard normal distribution)
    L_ratio(m) = L(m)/length(index1);% Lratio-isolation
    fprintf('\ncluster %d: L ratio - %2.2f\n',m,L_ratio(m) );
    if (mahal_sorted < length(index1)) %isolation distance: only defined if there is equal or more cluster points than cluster compared to
        fprintf('cluster %d: - Isolation distance failed due to to few points in other clusters\n',m );
        d_isolation(m) = nan;
    else
        d_isolation(m) = mahal_sorted(length(index1));
        fprintf('cluster %d: Isolation distance -  %0.2f\n',m,d_isolation(m) );
    end
end

mahal_d
datum.mahal_d = mahal_d;

% table_M_Distance(par,datum)
end




