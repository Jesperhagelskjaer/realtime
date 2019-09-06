function [] = Quicktest4RasterPSTH_v2(par,datum,sessionpath,TE)

load(strcat(sessionpath,'\rezFinal'))

[data, timestamps, info] = load_open_ephys_data(strcat(sessionpath,'\all_channels.events'));


% [DecimalEvents, Timestamps] = OpenEphysEvents2Bpod('all_channels.events');
for i = 1:size(datum.CS_A,2)
    
    stimes =  (datum.t_A{i}/30000)+ timestamps(1);
    stimes = stimes';
    % edges = [-3000:30:9000];
    % edges = [-3000:300:30000];
    if 1
        edges = [-1:0.01:1];
        str = 'Seconds';
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
    
    figure
    subplot(2,1,1)
    imagesc(-SpikeRaster)
    colormap('gray')
    subplot(2,1,2)
    bar(edges,SpikePETH)
    %
    DT = 0.02;
    SIGMA = 0.05;
    COMP = {[1:TrialN]};
    VALID_TRIALS = 1:710;
    [PSTH, SPSTH, SPSTH_SE] = binraster2psth(SpikeRaster,DT,SIGMA,COMP,VALID_TRIALS);
    
    SPSTH_s(:,i) = SPSTH;
    SPSTH_SE_S(:,i) = SPSTH_SE;
    
    clear stimes
end

figure
subplot(2,1,1)
plot(edges,SPSTH_s)
handleFigurePlot()
xlabel(str)
title('SPSTH s')
subplot(2,1,2)
plot(edges,SPSTH_SE_S)
xlabel(str)
title('SPSTH SE S')
handleFigurePlot()

filename = strcat(par.path,'\jesper\bundle',num2str(ceil(max(par.template_LFP{2})/4)-1),'agreement_SPSTH_s.fig');
savefig(filename)

end
