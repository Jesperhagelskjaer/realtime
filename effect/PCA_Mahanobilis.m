function [] = PCA_Mahanobilis(par,dataTraceJ,dataTraceD,str)


PCA_Mahanobilis_allCh(dataTraceJ,dataTraceD)


if 0
    %trying to make the PCA better
close all
x = 1:length(par.xAxis)*4; 
v = data_N(:,1:100);
% Define the query points to be a finer sampling over the range of x.
% 
 xq = 1:1/4:length(par.xAxis)*4;
% Interpolate the function at the query points and plot the result.
figure
vq1 = interp1(x,v,xq);
%plot(x,v,'o',xq,vq1,':.');
plot(xq,vq1,':.');

% xlim([0 2*pi]);
% title('(Default) Linear Interpolation');

movAverage = movmean(vq1,[5 5]);

figure
plot(xq,movAverage) 
v = movAverage(1,:);
B = bsxfun(@minus, movAverage', v');

figure
plot(xq,B)

end
%PCA_Mahanobilis__allCh_N1(par,dataTraceJ,dataTraceD,spikes,cluster) %no    



end

