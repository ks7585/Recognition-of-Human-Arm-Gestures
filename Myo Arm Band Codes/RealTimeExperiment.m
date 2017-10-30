 clear;
clc;

global nCh collectionInterval samplingRate windowCoff isCollecting counter  doubleTap MyoDataSize vart;

nCh = 8;
MyoDataSize = 50;
isCollecting = 1;    %   
samplingRate  = 200; % Myo sampling frequency
windowCoff    = 2;   % how long a letter performed in sec
collectionInterval = samplingRate*windowCoff; % Raw Data buffer size collectionInterval = sampleingRate * timeTo buffer in seconds

%% for real time experiment
doubleTap = 0;     % double tap first tap 1 second tap 0 

%% Setting up a Timer for a background process for Collecting MYO EMG Data (Control)
t = timer; 
t.StartFcn       = @socket_start_Func;
t.Period         = 0.25; 
t.StartDelay     = 2;
t.StopFcn        = @socket_stop_Func;
t.TimerFcn       = @socket_read_Func;  
t.TasksToExecute = inf;
t.ExecutionMode  = 'fixedSpacing';
start(t);

%% Stop experiment
pause()

%% Stop timer and delete it.
stop(t);
delete(t);