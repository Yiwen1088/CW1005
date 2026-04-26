% Yiwen Deng
% ssyyd15@nottingham.edu.cn
clear

%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [5 MARKS]

a=arduino('COM5','Uno'); % assign a variable a, where the port is COM5 and the type of Arduino is Uno

for n=1:100 % define the initial repeating times, can change
    writeDigitalPin(a,'D3',1) % lighten LED, the long LED log sits to the digital channel 3 of the Arduimo
    pause(0.5) % pause 0.5 s
    writeDigitalPin(a,'D3',0) % switch off LED
    pause(0.5)
end % end of loop over n

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

% Insert answers here

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here