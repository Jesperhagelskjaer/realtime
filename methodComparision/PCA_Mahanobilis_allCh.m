function [] = PCA_Mahanobilis_allCh(par,datum,varargin)


if find(strcmp(varargin,'C_PCA'))
    input_C_PCA = varargin{find(strcmp(varargin,'C_PCA')) + 1};
    C_PCA =  input_C_PCA;
end

if find(strcmp(varargin,'alignment'))
    input_alignment = varargin{find(strcmp(varargin,'alignment')) + 1};
end

WS_All = datum.WS_All;
c = [];
PCA_matrix = [];
if exist('input_alignment','var')
    if strcmp(input_alignment,'min')
        indexN = [];indexM = [];
        bW = -4;fW = 4;
        for ii = 1:length(C_PCA)
            k = C_PCA(ii); %%cluster to look at
            for i = 1:size(WS_All{k},3)
                [value,~] = min(min(WS_All{k}(:,:,i)));
                [m, n] = find(WS_All{k}(:,:,i) == value);
                indexN = [indexN n];
                indexM = [indexM m];
            end
            
            [a,b]=hist(indexN,unique(indexN));
            [~,index] = max(a);
            indexT = b(index);
            
            [a,b]=hist(indexM,unique(indexM));
            [~,index] = max(a);
            indexS = b(index);
            holder = zeros(size(WS_All{k},1),size(WS_All{k},2),size(WS_All{k},3));
            
            for i = 1:size(WS_All{k},3)
                
                [~,index] = min(WS_All{k}(indexS+[bW:fW],indexT,i));
                
                shift = index + bW-1;
                zeroMatrix = zeros(abs(shift),size(WS_All,2));
                if shift < 0
                    holder(:,:,i) = [zeroMatrix; WS_All{k}(1:end+shift,1:end,i)];
                elseif shift > 0
                    holder(:,:,i) = [WS_All{k}(shift+1:end,1:end,i); zeroMatrix];
                else
                    holder(:,:,i) = WS_All{k}(:,:,i);
                end
            end
            
            holderCut = holder(3:end-3,:,:);
            m = size(holderCut,1);
            n = size(holderCut,2);
            S_A = zeros(m*n,size(WS_All{k},3));
            for i = 1:size(WS_All{k},3)
                S_A(:,i) = reshape(holderCut(:,:,i),[1,m*n ]); %can make an allocat
            end
            PCA_matrix = [PCA_matrix S_A]; 
            c = [c ones(1,size(WS_All{k},3))*k];
        end
    end
else %No shiften og the alignment
    for ii = 1:length(C_PCA)
        k = C_PCA(ii); %%cluster to look at
        holderCut = WS_All{k}(3:end-3,:,:);
        m = size(holderCut,1);
        n = size(holderCut,2);
        S_A = zeros(m*n,size(WS_All{k},3));

        for i = 1:size(WS_All{k},3)
            S_A(:,i) = reshape(holderCut(:,:,i),[1,m*n ]); %can make an allocat
        end
        PCA_matrix = [PCA_matrix S_A]; 
        c = [c ones(1,size(WS_All{k},3))*k];
    end
end
    
[coeff,score,latent,tsquared,explained] = pca(PCA_matrix');
%
figure
hold on
for i = 1:length(C_PCA)
    ii = C_PCA(i);
    score_h{i} = score(logical(c == ii),1:3);
    scatter3(score_h{i}(:,1),score_h{i}(:,2),score_h{i}(:,3),0.02,'.')
end
for m = 1:size(score_h,2)
    for n = 1:size(score_h,2)
        d2_mahal(m,n) = mahal(mean(score_h{m}),score_h{n}); %Compute the squared Euclidean distance of each observation in Y from the mean of X . 
    end
end
d2_mahal
end




