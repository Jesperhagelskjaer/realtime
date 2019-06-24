clc
clear all
close all  

addpath('P:\AU256873\sandbox\code\matlab\NeuraLynx\convertDigatalToMatlab\MatlabImportExport_v6.0.0')

[par] = parameter();

[TTLs,TimestampsEvent] = loadEvent(par);

for i = 1:length(par.channels)
    fprintf('loading channel: %d\n',par.channels(i))
    if strcmp(par.recType,'csc') 
        [SamplesVectorUF,Timestamps,mBlockSize] = loadCSC(par,i,par.channels(end));
        
        if i == 1
            dataF = zeros(length(SamplesVectorUF),length(par.channels));
        end
    end
    
    if strcmp(par.filtering,'n')
        dataF(:,i) = SamplesVectorUF;
    else
        SamplesVector = filter(b1, a1, SamplesVectorUF);
        SamplesVector = flipud(SamplesVector);
        %Backward filtering using butterworth coefficient
        SamplesVector = filter(b1, a1, SamplesVector);
        SamplesVector = flipud(SamplesVector);
        dataF(:,i) = SamplesVector;
    end   

end

%[dataRAW_NRD] = loadNRD(par);
[dataJSearchF] = TTL_data(par,TimestampsEvent,TTLs,dataF);
%compare2GUI(par,TimestampsEvent,TTLs,dataF)

LFP_delay(par,dataJSearchF)
%averageSum(dataJSearchF)
% figure
% subplot(2,1,1)
% surf(dataRAW_NRD(1e3:1e7,:),'edgecolor','none');
% subplot(2,1,2)
% plot(dataRAW_NRD(1e3:1e7,1));


figure
surf(mean(dataJSearchF,3))
title(['Template JSearch   ',par.path(34:end-1),'    light: ',num2str(size(dataJSearchF,3))])
xlabel('Channels')
ylabel('Time [samples]')
zlabel('Voltage [uV]')


timeStampsDSort = timeStampDsort(par);
for i = 1:length(timeStampsDSort)
    
    dataDSortF(:,:,i) = dataF(par.xAxis+timeStampsDSort(i),:);
    
    if 1 && i < 1
            h = figure(100+i);
            subplot(2,1,1)
            plot(dataDSortF(:,1,i))
            subplot(2,1,2)       
            surf(dataDSortF(:,:,i))       
           % close(h)
    end
end
figure
surf(mean(dataDSortF,3))
title('Template Dsort')
xlabel('Channels')
ylabel('Time [samples]')
zlabel('Voltage [uV]')

[true1,falsePositive,par] = DsortToJSearch(timeStampsDSort,indexSampleLight,par);
[true2,falseNegative,par] = JSearchToDsort(timeStampsDSort,indexSampleLight,par);

[par] = shuffleCorrelation_v2(par,dataDSortF,2,25,0.7,'Dsort');
[par] = shuffleCorrelation_v2(par,dataJSearchF,2,25,0.7,'JSearch');

ThresholdGT(par,indexSampleLight,timeStampsDSort,falseNegative)

fprintf('\n\n')
fprintf('T_Spks Dsort:    %i\n',length(timeStampsDSort))
fprintf('T_Spks JSearch:  %i\n',length(indexSampleLight))
fprintf('True:            %i\n',true1)
fprintf('falsePositive:   %i\n',falsePositive)
fprintf('falseNegative:   %i\n',falseNegative)
fprintf('JSearch extra:   %i\n',true2)

% [par] = ThresholdGT(par,indexSampleLight,timeStampsDSort,falseNegative);
% 
% 
% 
% 
% plotAboveThreshold(par,dataDSortF,'Dsort')
% plotAboveThreshold(par,dataJSearchF,'JSearch')



%%
rmpath('P:\sandbox\code\matlab\NeuraLynx\convertDigatalToMatlab\MatlabImportExport_v6.0.0')

%% legacy code


%% load data
% indexVector = 17066/512 * (0:511); %creates the time vector for a block
% for i = 1:length(indexTTL)
%     indexBlock = find(TimestampsEvent(indexTTL(i)) <= Timestamps,1) - 1; %%check to find better way
%     %the minus we need to start at the back of the block
%     
%     createTimeVector = Timestamps(indexBlock) + indexVector;
%     %create the timeseries for the block
%     indexTimeBlock = find(TimestampsEvent(indexTTL(i)) <= createTimeVector,1)-1;
%     if isempty(indexTimeBlock)
%         indexTimeBlock = 512;% check up on
%     end
%     indexSampleLight(i) = (indexBlock-1) * mBlockSize + indexTimeBlock;
%     dataJSearchF(:,:,i) = dataF(par.xAxis+indexSampleLight(i),:);
%     %dataRAW_NRD_mat(:,:,i-1) = dataRAW_NRD(par.xAxis+indexSampleLight(i-1),:);
%     
%     
%     if 0 && i > 160
%         h = figure;
%         subplot(2,2,1)
%         plot(dataJSearchF(:,1,i))
%         subplot(2,2,2)
%         surf(dataJSearchF(:,:,i))
% %         subplot(2,2,3)
% %         plot(dataRAW_NRD(:,par.channels(1),i-1))
% %         subplot(2,2,4)
% %         surf(dataRAW_NRD_mat(:,par.channels,i-1))
%         %indexBlock
%         drawnow
%         close(h)
%         
%     end
% end


% indexTTL1 = find(TTLs == 1);
% indexTTL0 = find(TTLs == 0);
% indexTTL0(1) =[];
% indexTTL0(end) =[];
% 
% diff_1_0 = TimestampsEvent(indexTTL1)-TimestampsEvent(indexTTL0);
% diff_0_1 = TimestampsEvent(indexTTL0)-TimestampsEvent(indexTTL1);
% figure
% histogram(diff_1_0)
% 
% figure
% histogram(diff_0_1)
% 
% timeTTL = TimestampsEvent(indexTTL1);
