function [RasterR1] = raster_f(par_,rezT_)

Cluster1 = [par_.template]; %     4  8 19  16 15]
before = par_.before+1;
after = par_.after+1;

 for ii = 1:2

     for icell_2 = 1:length(unique(rezT_{ii}.rez.st(:,8))) % 26 22 13  30 21]
         
         Cluster2 = icell_2;
         T1 = rezT_{ii}.rez.st(rezT_{ii}.rez.st(:,end)==Cluster1,2);
         T2 = rezT_{ii}.rez.st(rezT_{ii}.rez.st(:,end)==Cluster2,2);
         
         Raster = zeros(length(T2),before + after + 1);
         for i = 1:length(T2)
             allspikes = T1 - T2(i);
             spikes = ceil(allspikes(allspikes > -before & allspikes < after ) + before );
             Raster(i,spikes) = 1;
         end
         RasterR1{ii,icell_2} = sum(Raster);
         
     end
end
end

