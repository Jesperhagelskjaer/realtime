function [] = Quicktest4RasterPSTH_v2(par,datum,sessionpath,TE)

load(strcat(sessionpath,'\rezFinal'))

[data, timestamps, info] = load_open_ephys_data(strcat(sessionpath,'\all_channels.events'));

str= {'agreement','NSI_MC','NSI_DS'};
% [DecimalEvents, Timestamps] = OpenEphysEvents2Bpod('all_channels.events');
for i = 1:size(datum.t_all,2)
    
    stimes =  (datum.t_all{i}/30000)+ timestamps(1);
    stimes = stimes';
    % edges = [-3000:30:9000];
    % edges = [-3000:300:30000];
    if 1
        edges = [-1:0.01:1];
        Xstr = 'Seconds';
    end
    %  stimes = double(tSpikes);
    event =  TE.CenterPortEntry; %TE.LeftPortEntry(~isnan(TE.LeftPortEntry)); %(find(TE.Reward==1))*1000;
    % event =  TE.RightRewardON; %TE.LeftPortEntry(~isnan(TE.LeftPortEntry)); %(find(TE.Reward==1))*1000;
    
    % event =  TE.CenterPortEntry(~isnan(TE.LeftPortEntry)); %TE.LeftPortEntry(~isnan(TE.LeftPortEntry)); %(find(TE.Reward==1))*1000;
    % event = TE.LeftPortEntry(TE.Reward==1 & ~isnan(TE.LeftPortEntry)); %(find(TE.Reward==1))*1000;
    % event = timestamps(DecimalEvents==128) - timestamps(1);
    % event = event*30000;
    Time = length(edges);
    SpikePETH = zeros(Time,1);
    TrialN = length(event);
    SpikeRaster = zeros(TrialN,Time);
    k = 0;
    inx = [];
    
    for iTrial = 1:length(event)
        allspikes = double(stimes) - event(iTrial);
        inx  = [inx find(allspikes < 60 & allspikes > 0)'];
        spikes = allspikes(allspikes>edges(1) & allspikes < edges(end));
        %      for i = 1:length(spikes)
        %          hold on
        %          line([spikes(i) spikes(i)], [k k+1],'color','k')
        %      end
        %      k = k + 1;
        SpikeRaster(iTrial,:) = histc(allspikes,edges);
        SpikePETH = SpikePETH + histc(allspikes,edges);
        clear allspikes
    end
    
    %     figure
    %     subplot(2,1,1)
    %     imagesc(-SpikeRaster)
    %     colormap('gray')
    %     subplot(2,1,2)
    %     bar(edges,SpikePETH)
    %
    DT = 0.02;
    SIGMA = 0.05;
    COMP = {[1:TrialN]};
    VALID_TRIALS = 1:710;
    [PSTH, SPSTH, SPSTH_SE] = binraster2psth(SpikeRaster,DT,SIGMA,COMP,VALID_TRIALS);
    
    SPSTH_test = [SPSTH;SPSTH];
    SPSTH_SE_test = [SPSTH_SE; SPSTH_SE];
    
    %stdshade_sorting(SPSTH_test, SPSTH_SE_test, 0.3,'b')
    
    
    SPSTH_s(:,i) = SPSTH;
    SPSTH_SE_S(:,i) = SPSTH_SE;
    
    clear stimes
end

for i = 1:length(unique(datum.label_WS_All))
    
    SPSTH_s_h = SPSTH_s(:,find(datum.label_WS_All ==i));
    
    SPSTH_SE_S_h = SPSTH_SE_S(:,find(datum.label_WS_All ==i));
    
    %colorV = linspace(0.1,1,length(find(datum.label_WS_All ==i)));
    colorV = {'m','r','b','c','g','w','b''y'};
    figure
    hold on
    for j = 1:length(find(datum.label_WS_All ==i))
              
        SPSTH_SE_S_h2 = SPSTH_SE_S_h(:,j);
        SPSTH_s_h2 = SPSTH_s_h(:,j);
        
        SPSTH_s_h2 = [SPSTH_s_h2';SPSTH_s_h2'];
        SPSTH_SE_S_h2 = [SPSTH_SE_S_h2'; SPSTH_SE_S_h2'];
        
        stdshade_sorting(SPSTH_s_h2, SPSTH_SE_S_h2, 0.3,colorV{j})
    end
    
    if i == 1
        title('agreement')
    elseif i == 2
        title('NSI MC')
    else
        title('NSI DS')
    end
    hold off
    filename = strcat(par.path,'\jesper\bundle',num2str(ceil(max(par.template_LFP{2})/4)-1),'_',str{i},'_SPSTH_s.fig');
    savefig(filename)
    
end

end
