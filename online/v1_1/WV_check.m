%specify clusters to load
clear inx
Cluster1 = 51;
Cluster2 = 51;
% inx{1} = find(rez.st(:,end) == Cluster1 & rez.st(:,4) > 0.9 & rez.st(:,5) < - 80);
inx{2} = find(rez.st(:,end) == Cluster2 & rez.st(:,4) > 0.9);
inx{1} = find(rez.st(:,end)== Cluster1 & rez.st(:,4) < 0.9);
% specify channels for the tetrode
Chanel2load = '100_CH13.continuous';
[data1, timestamps, info] = load_open_ephys_data(Chanel2load);
Chanel2load = '100_CH14.continuous';
[data2, timestamps, info] = load_open_ephys_data(Chanel2load);
Chanel2load = '100_CH15.continuous';
[data3, timestamps, info] = load_open_ephys_data(Chanel2load);
Chanel2load = '100_CH16.continuous';
[data4, timestamps, info] = load_open_ephys_data(Chanel2load);



% filter 300-5000
[b1, a1] = butter(3, [ops.fshigh/ops.fs,ops.slow/ops.fs]*2, 'bandpass');
%Forward filtering using butterworth coefficient
datr = filter(b1, a1, data1);
datr = flipud(datr);
%Backward filtering using butterworth coefficient
datr = filter(b1, a1, datr);
data1 = flipud(datr); clear datr

datr = filter(b1, a1, data2);
datr = flipud(datr);
%Backward filtering using butterworth coefficient
datr = filter(b1, a1, datr);
data2 = flipud(datr);clear datr

datr = filter(b1, a1, data3);
datr = flipud(datr);
%Backward filtering using butterworth coefficient
datr = filter(b1, a1, datr);
data3 = flipud(datr);clear datr

datr = filter(b1, a1, data4);
datr = flipud(datr);
%Backward filtering using butterworth coefficient
datr = filter(b1, a1, datr);
data4 = flipud(datr);clear datr


% plot mean and std of the wv

for iInx = 1:length(inx)
    
inxS  = inx{iInx};
sel_inx = 1:length(inxS);
D1 = zeros(length(sel_inx),41);
D2 = zeros(length(sel_inx),41);
D3 = zeros(length(sel_inx),41);
D4 = zeros(length(sel_inx),41);

    for i = 2:length(sel_inx)-1
        D1(i,:) = data1(rez.st(inxS(sel_inx(i)),1)-20:rez.st(inxS(sel_inx(i)),1)+20);
        D2(i,:) = data2(rez.st(inxS(sel_inx(i)),1)-20:rez.st(inxS(sel_inx(i)),1)+20);
        D3(i,:) = data3(rez.st(inxS(sel_inx(i)),1)-20:rez.st(inxS(sel_inx(i)),1)+20);
        D4(i,:) = data4(rez.st(inxS(sel_inx(i)),1)-20:rez.st(inxS(sel_inx(i)),1)+20);
    end
    figure
    plot(mean(D1))
    hold on
    plot(mean(D2))
    hold on
    plot(mean(D3))
    hold on
    plot(mean(D4))
end







sel_inx = 1:20;
inx1 = inx{1};
inx2 = inx{2};
SpkWnd = 60;
for i = 1:length(sel_inx)
figure
subplot(1,2,1)
 plot(data1(rez.st(inx1(sel_inx(i)),1)-SpkWnd:rez.st(inx1(sel_inx(i)),1)+SpkWnd) - data1(rez.st(inx1(sel_inx(i)),1)-SpkWnd),'Linewidth',2)
hold on 
 plot(data2(rez.st(inx1(sel_inx(i)),1)-SpkWnd:rez.st(inx1(sel_inx(i)),1)+SpkWnd) - data2(rez.st(inx1(sel_inx(i)),1)-SpkWnd),'Linewidth',2)
hold on 
plot(data3(rez.st(inx1(sel_inx(i)),1)-SpkWnd:rez.st(inx1(sel_inx(i)),1)+SpkWnd) - data3(rez.st(inx1(sel_inx(i)),1)-SpkWnd),'Linewidth',2)
hold on 
  plot(data4(rez.st(inx1(sel_inx(i)),1)-SpkWnd:rez.st(inx1(sel_inx(i)),1)+SpkWnd) - data4(rez.st(inx1(sel_inx(i)),1)-SpkWnd),'Linewidth',2)
% axis([ 0 41 -200 100])
subplot(1,2,2)
 plot(data1(rez.st(inx2(sel_inx(i)),1)-SpkWnd:rez.st(inx2(sel_inx(i)),1)+SpkWnd) - data1(rez.st(inx2(sel_inx(i)),1)-SpkWnd),'Linewidth',2)
hold on 
plot(data2(rez.st(inx2(sel_inx(i)),1)-SpkWnd:rez.st(inx2(sel_inx(i)),1)+SpkWnd) - data2(rez.st(inx2(sel_inx(i)),1)-SpkWnd),'Linewidth',2)
hold on 
 plot(data3(rez.st(inx2(sel_inx(i)),1)-SpkWnd:rez.st(inx2(sel_inx(i)),1)+SpkWnd) - data3(rez.st(inx2(sel_inx(i)),1)-SpkWnd),'Linewidth',2)
hold on 
plot(data4(rez.st(inx2(sel_inx(i)),1)-SpkWnd:rez.st(inx2(sel_inx(i)),1)+SpkWnd) - data4(rez.st(inx2(sel_inx(i)),1)-SpkWnd),'Linewidth',2)

% axis([ 0 41 -200 100])
end
