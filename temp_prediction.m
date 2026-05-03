% Yiwen Deng
% ssyyd15@nottingham.edu.cn
% Task 3 e)
% This is a function to collect temperature values based on the read
% voltage, and calculate how fast the temperature change continuously. Then
% the temperature expected in minutes is predicted. 3 LEDs of different 
% colours (green, yellow and red) are controlled to light in real-time 
% according to the temperature changing speed, to make sure the speed is in
% comfort range. When the speed is in the range -4 °C/min to 4 °C/min, 
% the green LED will light constantly. The yellow LED will light while 
% speed is lower and the red LED will light while speed is above the range

function temp_prediction(temperature)

a=arduino('COM5','Uno'); 
% assign a variable a, where the port is COM5 and the type of Arduino is Uno

T_C=10e-3; % convert unit mV/°C to V/°C, temperature coefficient
V_0=500e-3; % convert unit mV to V, zero-degree voltage

t=1; % set t (time) to 1
% n=0; % set n to 0

while t>0 % start of while loop

    t=t+1; % add 1 to t
    time(t)=t; % store time in arrays
    A3_voltage(t)=readVoltage(a,'A3'); % read voltage values every 1 second for 10 minutes
                                       % store these voltage values in arrays

    temperature(t)=(A3_voltage(t)-V_0)/T_C;
    % convert voltage values into temperature values

    pause(1) % pause for 1 second

    dt=time(t)-time(t-1); % calculate the change of time
    dT=temperature(t)-temperature(t-1); % calculate the change of temperature
    slope(t)=dT/dt; % calculate how fast the temperature change

    expected_time=300; % in s, initialise the predicted time for 5 minute
    predicted_temperature(t)=temperature(t)+slope(t)*expected_time;
    % predict the temperature expected in 5 minutes

    result=sprintf('\n%s: %f °C\n%s? %f °C/s\n%s: %f °C\n', ...
        'Temperature',temperature(t), ...
        'How fast does the temperature change',slope(t), ...
        'Temperature expected in 5 minutes',predicted_temperature(t));
    % format results containing 3 types of data for each second

    disp(result);
    % print the temperature changing speed in °C/s, 
    % current temperature and predicted temperature

    speed(t)=slope(t)*60; % convert unit °C/s to °C/min

    % % or wait for calculate the speed for one minute once (2nd choice)
    % n=n+60; % add 60 to n
    % time_new_unit=n/60; % convert unit to minute by divided n by 60
    % % dminute(time_new_unit)=time_new_unit(time_new_unit)-time_new_unit(time_new_unit-1) % store time values in new unit minute
    % dminute(time_new_unit)=1;
    % dtemperaturre(time_new_unit)=temperature(time_new_unit)-temperature(time_new_unit); % store temperature values in new unit minute
    % speed(time_new_unit)=dtemperaturre/dminute

    if (speed(t)>=-4)&&(speed(t)<=4)
    % if (speed >=-4 °C/min) and (speed <=4 °C/min) the condition is met,
    % namely the speed is in range of -4 °C/min to 4 °C/min

    % if (speed(time_new_unit)>-4)&&(speed(time_new_unit)<4) % (2nd choice)

        writeDigitalPin(a,'D10',1)
        % lighten green LED, the long LED log connects to the digital channel 10 of the Arduimo
    else
        writeDigitalPin(a,'D10',0) % switch off green LED if not in the range

    end % end of if statement

    if (speed(t)>4) % if speed higher than 4 °C/min
    % if (speed(time_new_unit)>4) % (2nd choice)

        writeDigitalPin(a,'D12',1)
        % lighten red LED, the long LED log connects to the digital channel 12 of the Arduimo
    else
        writeDigitalPin(a,'D12',0) % switch off red LED if not in the range

    end % end of if statement

    if (speed(t)<-4) % if speed lower than -4 °C/min

    % if (speed(time_new_unit)<-4) % (2nd choice)
        
        writeDigitalPin(a,'D8',1)
        % lighten yellow LED, the long LED log connects to the digital channel 8 of the Arduimo
    else
        writeDigitalPin(a,'D8',0) % switch off yellow LED if not in the range

    end % end of if statement

end % end of while loop

% for t=1:time-1
% 
%     dt=time(t+1)-time(t);
%     %dt=1;
%     dT=temperature(t+1)-temperature(t);
%     slope(t)=dT/dt;
%     disp(slope)
% 
%     pause(1)
% 
%     speed(t)=slope(t)/60
% 
%     if (speed(t)>-4)&&(speed(t)<4)
% 
%         writeDigitalPin(a,'D10',1)
%         % lighten green LED, the long LED log connects to the digital channel 10 of the Arduimo
%     else
%         writeDigitalPin(a,'D10',0) % switch off green LED if not in the range
% 
%     end % end of if statement
% 
%     if (speed(t)>4)
% 
%         i=1; % intialise i to 1 
% 
%         while (i>0) % start of inner while loop
% 
%             writeDigitalPin(a,'D12',1)
%             % lighten red LED, the long LED log connects to the digital channel 12 of the Arduimo
%             writeDigitalPin(a,'D12',0) % switch off red LED if not in the range
%             i=0; % return i value to 0
% 
%         end % end of inner while loop
% 
%     end % end of if statement
% 
%     if (speed(t)<-4)
%         i=1; % again, intialise i to 1 
% 
%         while (i>0) % start of inner while loop
%             writeDigitalPin(a,'D8',1)
%             % lighten yellow LED, the long LED log connects to the digital channel 8 of the Arduimo
%             writeDigitalPin(a,'D8',0) % switch off yellow LED if not in the range
%             i=0; % return i value to 0
% 
%         end % end of inner while loop
% 
%     end % end of if statement
% 
% end