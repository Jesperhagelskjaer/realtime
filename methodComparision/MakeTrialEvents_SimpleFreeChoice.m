% This function generates Trial Events file for Simple Free Choice task using Bpod
% synchronization
function [TE_FC] = MakeTrialEvents_SimpleFreeChoice(sessionpath,AquisitionSyst,string)

%cd(sessionpath)
if strcmp(AquisitionSyst,'OpenEphys')
    [DecimalEvents, Timestamps] = OpenEphysEvents2Bpod(strcat(sessionpath,'\all_channels.events'));
    % get rid of spurious states
    
    %MaxNStates = 20;
    %Timestamps(DecimalEvents>MaxNStates)=[]; % dk do it if there are also light stim events before the beh session. no need if they come at the end
    %DecimalEvents(DecimalEvents>MaxNStates)=[];
    
    index_f = find(DecimalEvents == 1,1,'first');
    DecimalEvents(1:index_f-1)      = [];
    Timestamps(1:index_f-1)         = [];
    index_f = find(DecimalEvents > 40,1,'first');
    DecimalEvents(index_f:end)      = [];
    Timestamps(index_f:end)         = [];
    
    %DecimalEvents(find(diff(Timestamps)<0.00005)+1) = [];
    %Timestamps(find(diff(Timestamps)<0.00005)+1) = [];
elseif  strcmp(AquisitionSyst,'Neuralynx')
    load events
    DecimalEvents = Events_Nttls;
    Timestamps = Events_TimeStamps;
end


%% test first that length of SessionData matches length of DecimalEvents
nTrialEnds = sum(DecimalEvents == 0); %should be code as length(find(DecimalEvents == 0))
SessionName = dir(strcat(sessionpath,string));
load(strcat(sessionpath,'\',SessionName.name))

nT_FC = SessionData.nTrials;

if nTrialEnds == nT_FC + 2 % + 1 if only one stimulation /inhibition protocol is applied
    
    
    %% simple free choice
    TrialEndInx = find(DecimalEvents == 0);
    
    TE_FC = struct;
    TE_FC.TrialTypes = SessionData.TrialTypes;
    TE_FC.LeftProbability = SessionData.LeftProbabilities;
    TE_FC.RightProbability = SessionData.RightProbabilities;
    TE_FC.WaitDelay = SessionData.WaitDelay;
    TE_FC.RewardDelay = SessionData.RewardDelay;
    
    % extract states according to decimal events
    TrialStates_FC = [];
    for iTSe = 1:SessionData.nTrials
        
        if iTSe == 1
            TrialStates_FC = [TrialStates_FC SessionData.RawData.OriginalStateNamesByNumber{iTSe}(DecimalEvents(1:TrialEndInx(iTSe)-1)) 'EndTrial'];
        else
            TrialStates_FC = [TrialStates_FC SessionData.RawData.OriginalStateNamesByNumber{iTSe}(DecimalEvents(TrialEndInx(iTSe-1)+1:TrialEndInx(iTSe)-1)) 'EndTrial'];
        end
    end
    
    %for event timestamp extraction
    TrialStatesByNumber_FC = NaN(1,length(TrialStates_FC));
    
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'NewTrial', length('NewTrial'))) = 1;
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'InitialPoke', length('InitialPoke'))) = 2;
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'WaitInCenter', length('WaitInCenter'))) = 3;
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'WaitReward', length('WaitReward'))) = 4;
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'WaitForPortExit', length('WaitForPortExit'))) = 6;
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'FreeChoice', length('FreeChoice'))) = 7;
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'LeftReward', length('LeftReward'))) = 9;
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'LeftRewardDelay', length('LeftRewardDelay'))) = 8; % needs to come after, because otherwise will be replaced by 'LeftReward'
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'RightReward', length('RightReward'))) = 11;
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'RightRewardDelay', length('RightRewardDelay'))) = 10; % see above left
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'NoRewardLeft', length('NoRewardLeft'))) = 12;
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'NoRewardRight', length('NoRewardRight'))) = 13;
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'Drink', length('Drink'))) = 15;
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'DrinkingGrace', length('DrinkingGrace'))) = 16;
    %     TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'LeftInactivated', length('LeftInactivated'))) = 30;
    %     TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'RightInactivated', length('RightInactivated'))) = 31;
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'timeout', length('timeout'))) = 17;
    TrialStatesByNumber_FC(strncmp(TrialStates_FC, 'EndTrial', length('EndTrial'))) = 0;
    
    TrialEndInxFC = find(TrialStatesByNumber_FC == 0);
    TrialStartInxFC = [1 TrialEndInxFC(1:end-1)+1];
    
    TE_FC.TrialStart = Timestamps(TrialStartInxFC);
    TE_FC.TrialEnd = Timestamps(TrialEndInxFC);
    TE_FC.CenterPortEntry = NaN(1,SessionData.nTrials);
    TE_FC.CenterPortExit = NaN(1,SessionData.nTrials);
    TE_FC.EarlyWithdrawalCenter = NaN(1,SessionData.nTrials);
    TE_FC.CenterPortRewardON = NaN(1,SessionData.nTrials);
    TE_FC.CenterPortRewardOFF = NaN(1,SessionData.nTrials);
    TE_FC.LeftPortEntry = NaN(1,SessionData.nTrials);
    TE_FC.LeftPortExitFirst = NaN(1,SessionData.nTrials);
    TE_FC.LeftPortExitLast = NaN(1,SessionData.nTrials);
    TE_FC.LeftRewardON = NaN(1,SessionData.nTrials);
    TE_FC.LeftRewardOFF = NaN(1,SessionData.nTrials);
    TE_FC.RightPortEntry = NaN(1,SessionData.nTrials);
    TE_FC.RightPortExitFirst = NaN(1,SessionData.nTrials);
    TE_FC.RightPortExitLast = NaN(1,SessionData.nTrials);
    TE_FC.EarlyWithdrawalSide = NaN(1,SessionData.nTrials);
    TE_FC.RightRewardON = NaN(1,SessionData.nTrials);
    TE_FC.RightRewardOFF = NaN(1,SessionData.nTrials);
    TE_FC.Reward = zeros(1,SessionData.nTrials);
    TE_FC.NoReward = zeros(1,SessionData.nTrials);
    TE_FC.LeftPortOn = NaN(1,SessionData.nTrials);
    TE_FC.RightPortOn = NaN(1,SessionData.nTrials);
    
    
    
    for iTSe = 1:SessionData.nTrials
        
        TrialInxFC = TrialStartInxFC(iTSe):TrialEndInxFC(iTSe);
        TE_FC.CenterPortEntry(iTSe) = Timestamps(TrialInxFC(find(TrialStatesByNumber_FC(TrialInxFC) == 2,1,'last'))) ;
        
        if ~isempty(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 7)) % 'FreeChoice' exists, no early withdrawal
            
            TE_FC.CenterPortExit(iTSe) =  Timestamps(TrialInxFC(find(TrialStatesByNumber_FC(TrialInxFC) == 7,1,'first'))) ; % 7 state repeats for few trials
            TE_FC.CenterPortRewardON(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 4));
            TE_FC.CenterPortRewardOFF(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 6));
            
            if ~isempty(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 8)) % 'LeftRewardDelay' exists
                TE_FC.LeftPortOn(iTSe) = 1;
                
                TE_FC.LeftPortEntry(iTSe) = Timestamps(TrialInxFC(find(TrialStatesByNumber_FC(TrialInxFC) == 8,1,'first')));
                
                if ~isempty(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 9)) % 'LeftReward' exists
                    
                    TE_FC.LeftPortExitFirst(iTSe) = Timestamps(TrialInxFC(find(TrialStatesByNumber_FC(TrialInxFC) == 16, 1, 'first')));
                    TE_FC.LeftPortExitLast(iTSe) = Timestamps(TrialInxFC(find(TrialStatesByNumber_FC(TrialInxFC) == 16, 1, 'last')));
                    TE_FC.Reward(iTSe) = 1;
                    TE_FC.LeftRewardON(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 9));
                    TE_FC.LeftRewardOFF(iTSe) = Timestamps(TrialInxFC(find(TrialStatesByNumber_FC(TrialInxFC) == 15, 1, 'first')));
                    
                else % early withdrawal from reward port (leads to end of trial)
                    TE_FC.LeftPortExitFirst(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 0));
                    TE_FC.LeftPortExitLast(iTSe) = TE_FC.LeftPortExitFirst(iTSe);
                    TE_FC.NoReward(iTSe) = 1;
                    TE_FC.EarlyWithdrawalSide(iTSe) = 1;
                    
                end
                
            elseif ~isempty(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 12)) % 'NoRewardLeft' exists
                
                TE_FC.LeftPortEntry(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 12));
                TE_FC.LeftPortExitFirst(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 0));
                TE_FC.LeftPortExitLast(iTSe) = TE_FC.LeftPortExitFirst(iTSe);
                TE_FC.NoReward(iTSe) = 1;
                
                %             elseif ~isempty(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 30)) % 'LeftInactivated' exists
                %
                %                 TE_FC.LeftPortEntry(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 30));
                %                 TE_FC.LeftPortExitFirst(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 0));
                %                 TE_FC.LeftPortExitLast(iTSe) = TE_FC.LeftPortExitFirst(iTSe);
                %                 TE_FC.NoReward(iTSe) = 1;
                
            elseif ~isempty(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 10)) % 'RightRewardDelay' exists
                
                TE_FC.RightPortEntry(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 10));
                TE_FC.RightPortOn(iTSe) = 1;
                
                if ~isempty(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 11)) % 'RightReward' exists
                    
                    TE_FC.RightPortExitFirst(iTSe) = Timestamps(TrialInxFC(find(TrialStatesByNumber_FC(TrialInxFC) == 16, 1, 'first')));
                    TE_FC.RightPortExitLast(iTSe) = Timestamps(TrialInxFC(find(TrialStatesByNumber_FC(TrialInxFC) == 16, 1, 'last')));
                    TE_FC.Reward(iTSe) = 1;
                    TE_FC.RightRewardON(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 11));
                    TE_FC.RightRewardOFF(iTSe) = Timestamps(TrialInxFC(find(TrialStatesByNumber_FC(TrialInxFC) == 15, 1, 'first')));
                    
                else % early withdrawal from reward port (leads to end of trial)
                    TE_FC.RightPortExitFirst(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 0));
                    TE_FC.RightPortExitLast(iTSe) = TE_FC.RightPortExitFirst(iTSe);
                    TE_FC.NoReward(iTSe) = 1;
                    TE_FC.EarlyWithdrawalSide(iTSe) = 1;
                    
                end
                
            elseif ~isempty(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 13)) % 'NoRewardRight' exists
                
                TE_FC.RightPortEntry(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 13));
                TE_FC.RightPortExitFirst(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 0));
                TE_FC.RightPortExitLast(iTSe) = TE_FC.RightPortExitFirst(iTSe);
                TE_FC.NoReward(iTSe) = 1;
                
                %             elseif ~isempty(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 31)) % 'RightInactivated' exists
                %
                %                 TE_FC.RightPortEntry(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 31));
                %                 TE_FC.RightPortExitFirst(iTSe) = Timestamps(TrialInxFC(TrialStatesByNumber_FC(TrialInxFC) == 0));
                %                 TE_FC.RightPortExitLast(iTSe) = TE_FC.RightPortExitFirst(iTSe);
                %                 TE_FC.NoReward(iTSe) = 1;
                
            else
                TE_FC.NoReward(iTSe) = 1; % 'FreeChoice' state visited, but no choice made
                
            end
            
        else % was an early withdrawal
            TE_FC.CenterPortExit(iTSe) =  Timestamps(TrialInxFC(find(TrialStatesByNumber_FC(TrialInxFC) == 17,1,'first')));
            TE_FC.NoReward(iTSe) = 1;
            TE_FC.EarlyWithdrawalCenter(iTSe) = 1;
            
        end
        
    end
    
    SidePortEntryFC = NaN(1, SessionData.nTrials);
    SidePortEntryFC(~isnan(TE_FC.LeftPortEntry)) = TE_FC.LeftPortEntry(~isnan(TE_FC.LeftPortEntry));
    SidePortEntryFC(~isnan(TE_FC.RightPortEntry)) = TE_FC.RightPortEntry(~isnan(TE_FC.RightPortEntry));
    
    TE_FC.ReactionTimes = SidePortEntryFC - TE_FC.CenterPortExit;
    
    SidePortExitLastFC = NaN(1, SessionData.nTrials);
    SidePortExitLastFC(~isnan(TE_FC.LeftPortExitLast)) = TE_FC.LeftPortExitLast(~isnan(TE_FC.LeftPortExitLast));
    SidePortExitLastFC(~isnan(TE_FC.RightPortExitLast)) = TE_FC.RightPortExitLast(~isnan(TE_FC.RightPortExitLast));
    
    TE_FC.ITI = [NaN TE_FC.CenterPortEntry(2:end) - SidePortExitLastFC(1:end-1)];
    
    % save TrialEvents TE
    save([sessionpath filesep 'TrialEvents_FreeChoiceDynMatchJesper.mat'],'-struct','TE_FC')
    
else
    'DecimalEvents do not match SessionData'
end