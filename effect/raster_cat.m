function [RasterR1] = raster_cat(par,rezT)


Cluster1 = [par.template]; %     4  8 19  16 15]
before = par.before;
after = par.after;

count = 1;
for ii = 1:2
     
    fullNameCNS = strcat(par.path{ii},par.e_str,'\CSC',num2str(par.chs(1)),'.ncs');
    [Timestamps, ChannelNumbers, SampleFrequencies,NumberOfValidSamples, Samples, Header] = Nlx2MatCSC(fullNameCNS,[1 1 1 1 1], 1, 1, [] );
    
    [m,n] = size(Samples);
    sizeR = length(reshape(Samples,[1,n*m]));

     
     for icell_2 = 1:length(unique(rezT{1}.rez.st(:,8))) % 26 22 13  30 21]
         
         Cluster2 = icell_2;
         T1 = rezT{1}.rez.st(rezT{1}.rez.st(:,end)==Cluster1,2);
         T2 = rezT{1}.rez.st(rezT{1}.rez.st(:,end)==Cluster2,2);
         
         T1_s = rezT{1}.rez.st(rezT{1}.rez.st(:,end)==Cluster1,1);
         T2_s = rezT{1}.rez.st(rezT{1}.rez.st(:,end)==Cluster2,1);
         
         T1_s = find(T1_s > count & T1_s<sizeR+count);
         T2_s = find(T2_s > count & T2_s<sizeR+count);
         
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




