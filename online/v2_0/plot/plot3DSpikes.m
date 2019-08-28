function [] = plot3DSpikes(vec1,string)


figure
plot( vec1(:,1),vec1(:,2),'.' )
title(string)


end

