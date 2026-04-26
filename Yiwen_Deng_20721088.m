% Yiwen Deng
% ssyyd15@nottingham.edu.cn
%clear

%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [5 MARKS]

a=arduino('COM5','Uno'); % assign a variable a, where the port is COM5 and the type of Arduino is Uno

% for n=1:100 % define the initial repeating times, can change
%
%     writeDigitalPin(a,'D3',1) % lighten LED, the long LED log sits to the digital channel 3 of the Arduimo
%     pause(0.5) % pause for 0.5 s
%     writeDigitalPin(a,'D3',0) % switch off LED
%     pause(0.5)
%
% end % end of loop over n

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
% b)
duration=600; % in seconds, set acquisition time

for t=1:duration % set time from first second to 10 minutes

    time(t)=t
    A3_voltage(t)=readVoltage(a,'A3') % read voltage values every 1 second for 10 minutes
    pause(1) % pause for 1 second

end % end of loop over t

T_C=10e-3; % convert unit mV/°C to V/°C, temperature coefficient
V_0=500e-3; % convert unit mV to V, zero-degree voltage
temperature=(A3_voltage-V_0)/T_C; % convert voltage values into temperature values
minimum_temperature=min(temperature); % find minimum temperature
maximum_temperature=max(temperature); % find maximum temperature
average_temperature=mean(temperature); % calculate average temperature

% c)
figure(1) % create figute plane
plot(time,temperature) % 
xlabel('time (s)') % 
ylabel('temperature (°C)') % 
title('Line plot of temperature in for 10 minutes (600 seconds)') % 



%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here