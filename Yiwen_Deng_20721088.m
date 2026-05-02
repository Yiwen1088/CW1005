% Yiwen Deng
% ssyyd15@nottingham.edu.cn
clear

%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [5 MARKS]

a=arduino('COM5','Uno'); 
% assign a variable a, where the port is COM5 and the type of Arduino is Uno

% for n=1:100 % define the initial repeating times, can change
% 
%     writeDigitalPin(a,'D3',1) 
%     lighten LED, the long LED log connects to the digital channel 3 of the Arduimo
%     pause(0.5) % pause for 0.5 s
%     writeDigitalPin(a,'D3',0) % switch off LED
%     pause(0.5)
% 
% end % end of loop over n

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
% b)
duration=600; % in seconds, set acquisition time
T_C=10e-3; % convert unit mV/°C to V/°C, temperature coefficient
V_0=500e-3; % convert unit mV to V, zero-degree voltage

for t=1:duration % set time from first second to 10 minutes

    time(t)=t % store time in arrays
    A3_voltage(t)=readVoltage(a,'A3') % read voltage values every 1 second for 10 minutes
                                      % store these voltage values in arrays

    temperature(t)=(A3_voltage(t)-V_0)/T_C % convert voltage values into temperature values

    pause(1) % pause for 1 second
    
end % end of loop over t

minimum_temperature=min(temperature); % find minimum temperature
maximum_temperature=max(temperature); % find maximum temperature
average_temperature=mean(temperature); % calculate average temperature

% c)
figure(1) % create figute plane 1
plot(time,temperature) % plot time against temperature
xlabel('Time (s)') % name x axis
ylabel('Temperature (°C)') % name y axis
title('Line plot of temperature in 10 minutes (600 seconds)')
% the function of this figure
grid on; % add grid (don't need, just make the figure look well)

% d)
date=sprintf('Data logging initiated - 1/5/2026');
location=sprintf('\nLocation - Nottingham\n');
disp(date); % print date when the data was recorded on screen
disp(location); % print location on screen

n=0; % initialise n to 0 to count
minute=zeros(1,10); % make array full of 0 for time in minute
T=zeros(1,10); % make array full of 0 for temperature for each minute

% e)
file=fopen('capsule_temperature.txt','w'); % open the file for writing
fprintf(file,date); % write date to the file
fprintf(file,location); % write location to the file

% d), e)
while (n>=0)&&(n<600) % start of while loop,
                      % the following loop will be executed when n>=0 and <600

    n=n+60; % add 60 to n
    time_new_unit=n/60; % convert unit to minute by divided n by 60
    minute(time_new_unit)=time_new_unit; % store time values in new unit minute
    T(time_new_unit)=temperature(time_new_unit); % store temperature values in new unit minute
    output=sprintf('\n%s      %.0f\n%s %.2f C\n','Minute',minute(time_new_unit),'Temperature',T(time_new_unit));
    % format temperature values with 2 demical digits for each minute
    disp(output);
    % print the temperature values with time on screen

% e)
    fprintf(file,output); % write capsule temperature with time to the file

end % end of while loop

fclose(file); % close the file
open('capsule_temperature.txt'); % found 'fopen' couldn't work, 
                                 % use 'open' can open the file to check

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% h)
temp_monitor(temperature)


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers herea
