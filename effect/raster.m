function [RasterR1] = raster(par,rez)


cluster1 = [par.template]; %     4  8 19  16 15]
before = par.before;
after = par.after;

count = 1;
if strcmp(par.template_LFP{2},'all')
    clustNr = unique(rez{1}.rez.st(:,8)); % 26 22 13  30 21]
else
    clustNr = par.template_LFP{2};
end

for ii = 1:size(par.path,2)  
    
    fullNameCNS = strcat(par.path{ii},par.e_str,'\CSC',num2str(par.chs(1)),'.ncs');
    [~, ~, ~,~, Samples, ~] = Nlx2MatCSC(fullNameCNS,[1 1 1 1 1], 1, 1, [] );
    
    [m,n] = size(Samples); %can be be combined with below
    sizeR = length(reshape(Samples,[1,n*m]))+count;
       
    for icell_2 = 1:length(clustNr)
        
        cluster2 = clustNr(icell_2);
        
        
        T1 = rez.st(rez.st(:,end)==cluster1,2);
        T2 = rez.st(rez.st(:,end)==cluster2,2);
        
        T1_s = rez.st(rez.st(:,end)==cluster1,1);
        T2_s = rez.st(rez.st(:,end)==cluster2,1);
        
        T1_s = find(T1_s > count & T1_s<sizeR);
        T2_s = find(T2_s > count & T2_s<sizeR);
        
        T1 = T1(T1_s);
        T2 = T2(T2_s);
        
        Raster = zeros(length(T2),before + after + 1);
        for i = 1:length(T2)
            allspikes = T1 - T2(i);
            spikes = ceil(allspikes(allspikes > -before & allspikes < after ) + before );
            Raster(i,spikes) = 1;
        end
        RasterR1{ii,icell_2} = sum(Raster);
        
    end
    count = sizeR;
end
end




