% Yiwen Deng
% ssyyd15@nottingham.edu.cn
% l)
%This is a function to collect temperature values based on the read
%voltage, and control 3 LEDs of different colours (green, yellow and red)
%to blink in real-time according to the temperature with a live graph. When
%the temperature is in the range 18 °C to 24 °C, the green LED will light
%constantly. The yellow LED will blink while temperature is lower and the
%red LED will blink while temperature is higher

function temp_monitor(temperature)

a=arduino('COM5','Uno'); 
% assign a variable a, where the port is COM5 and the type of Arduino is Uno

T_C=10e-3; % convert unit mV/°C to V/°C, temperature coefficient
V_0=500e-3; % convert unit mV to V, zero-degree voltage

t=0; % set t (time) to 0
 
while t>=0 % start of while loop

    t=t+1; % add 1 to t
    time(t)=t; % store time in arrays
    A3_voltage(t)=readVoltage(a,'A3'); % read voltage values every 1 second for 10 minutes
                                       % store these voltage values in arrays

    pause_time=1; % initialise pause time for 1 second

    temperature(t)=(A3_voltage(t)-V_0)/T_C; 
    % convert voltage values into temperature values

    if (temperature(t)>=18)&&(temperature(t)<=24)
    % if (temperature >=18 °C) and (temperature <=24 °C) the condition is met,
    % namely the temperature is in range of 18 °C to 24 °C
        writeDigitalPin(a,'D10',1)
        % lighten green LED, the long LED log connects to the digital channel 10 of the Arduimo
    else % if temperature not in range 18 °C to 24 °C
        writeDigitalPin(a,'D10',0) % switch off green LED if not in the range

    end % end of if statement

    if (temperature(t)>24) % if temperature higher than 24 °C

        i=1; % intialise i to 1 
             % thus if temperature >24 °C, it can go to while loop for i>0

        while (i>0) % start of inner while loop

            t1=0.25; % initialise t1, for the pause time in this condition
            writeDigitalPin(a,'D12',1)
            % lighten red LED, the long LED log connects to the digital channel 12 of the Arduimo
            pause(t1) % pause for 0.25 s
            writeDigitalPin(a,'D12',0) % switch off red LED if not in the range
            pause(t1)
            i=0; % return i value to 0
            pause_time=pause_time-2*t1; 
            % calculate pause time for overall temporisation of the
            % function, by subtracting 2 times t1

        end % end of inner while loop

    end % end of if statement

    if (temperature(t)<18) % if temperature lower than 18 °C
        i=1; % again, intialise i to 1 
             % thus if temperature <18 °C, it can go to while loop for i>0

        while (i>0) % start of inner while loop
            t2=0.5; % initialise t1, for the pause time in this condition
            writeDigitalPin(a,'D8',1)
            % lighten yellow LED, the long LED log connects to the digital channel 8 of the Arduimo
            pause(t2) % pause for 0.5 s
            writeDigitalPin(a,'D8',0) % switch off yellow LED if not in the range
            pause(t2)
            i=0; % return i value to 0
            pause_time=pause_time-2*t2;
            % calculate pause time for overall temporisation of the
            % function, by subtracting 2 times t2

        end % end of inner while loop

    end % end of if statement

    pause(pause_time) % pause for the calculated pause_time based on the condition

% i)
    figure(1) % create figute plane 1
    plot(time,temperature) % plot time against temperature
    xlabel('Time (s)') % name x axis
    ylabel('Temperature (°C)') % name y axis
    xlim([0 t]) % limit the x axis, from 0 to the real time
    ylim([15 28]) % limit the y axis, with a range of regular temperature range
    title('Line plot of temperature') % name title, the function of this figure
    grid on; % add grid (don't need, just make the figure look well)
    drawnow % update graph as time progresses

end % end of while loop