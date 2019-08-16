function [] = plot_csc_with_event(par,i)
%%-------------------------------------------------------------------------
% Engineer: Krishna C.
% Company: Neuralynx, Inc.
% Date: 3rd July, 2019.
% File: plot_csc_with_events.m
% Description: 1) This file extracts data from a NLX csc recording file and
%                 plots vs sample data [uV] vs time [us].
%              2) Extracts events from NLX events file and plots event vs
%                 time [us]
% Input arguments: 1) CSC file
%                  2) NVE file
%%-------------------------------------------------------------------------



i = 29;

fullNameCNS = strcat(par.path{1},'csc/CSC',num2str(i),'.ncs');


%% Extract data from NCS file into Matlab workspace for processing
[Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples, Samples, Header] ...
    = Nlx2MatCSC(fullNameCNS, [1 1 1 1 1], 1, 1, [] );

% Some header processing stuffs.
fs = SampleFrequencies(1);  % Assumes SampleFrequencies over entire recording are same
% TODO: Need to add a check for this. Pull from Header(15) -> SamplingFrequency
ts_us = 1/fs * 1e6; % csc recording sample time in microseconds.
ADBitVolts_uV = 250e-6/2^15 * 1e6; %TODO: Pull from Header(17) -> ADBitVolts

%% Prepare vector structures to store sample data and timestamps to return
sample_data_uV = zeros(sum(NumberOfValidSamples,2),1);
time_us = zeros(sum(NumberOfValidSamples,2),1);
incomplete_record_start_timestamps = []; % keeps track of timestamps where incomplete record occurs

% Creates vector of sample data and corresponding timestamps from CSC recording.
% TODO Need to do this without a for loop to speed up.
start_index = 1; % points to start of new record
for i = 1:length(NumberOfValidSamples)
    
    % fills sample_data vector with number of valid samples of record
    sample_data_uV(start_index:start_index+NumberOfValidSamples(1,i)-1,1) = Samples(1:NumberOfValidSamples(1,i),i) *ADBitVolts_uV;
    
    % fills time over number of valid samples. % TODO: Need to check if
    % current record Timestamp is greater than end of last time for time continuity
    time_us(start_index:start_index+NumberOfValidSamples(1,i)-1,1) = Timestamps(1,i): ts_us: Timestamps(1,i)+(NumberOfValidSamples(1,i)-1)*ts_us;
    
    % increments start_index to next record
    start_index = start_index + NumberOfValidSamples(1,i);
    
    % check for incomplete records and store start timestamp ( ignore last
    % record which may be less than 512 samples)
    % TODO update this to a precheck using find(NumberOfValidSamples < 512)
    % to return indices and then use those timestamps instead.
    if (NumberOfValidSamples(i) < 512) && (i ~= length(NumberOfValidSamples))
        incomplete_record_start_timestamps = [incomplete_record_start_timestamps Timestamps(i)];
    end
end


%% Extract events data from NEV file into Matlab workspace for processing
fullNameEvents = strcat(par.path,'\Events.nev');
[Timestamps_EV, EventIDs, TTLs, Extras, EventStrings, Header_EV] ...
    = Nlx2MatEV(fullNameEvents, [1 1 1 1 1], 1, 1, [] );

% check for ttl '1' events. % TODO use a find(TTL == 1)
user_events_timestamps = [];
for i = 1:length(TTLs)
    if (TTLs(i) == 1)
        user_events_timestamps = [user_events_timestamps Timestamps_EV(i)];
    end
end


%% Plot results
figure(1); clf(1);

% Plot sample data vs timestamp from csc file
%subplot(2,1,1);
plot(time_us, sample_data_uV);
ylim = [-250 250];
xlabel('Time [\mus]');
ylabel('Voltage [\muV]');
hold on;

% Plot vertical lines markers at start of incomplete records
ylimit = ylim;
for i = 1:length(incomplete_record_start_timestamps)
    plot( [incomplete_record_start_timestamps(i) incomplete_record_start_timestamps(i)], [ylimit(1) ylimit(2)], 'y');
end

% Plot vertical lines markers at ttl user events
ylimit = [-50 50];
for i = 1:length(user_events_timestamps)
    plot( [user_events_timestamps(i) user_events_timestamps(i)], [ylimit(1) ylimit(2)], 'r');
end

% Plot TTL events
% subplot(2,1,2);
% plot(Timestamps_EV, TTLs, '*r');
end

