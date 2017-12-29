%The RLC_script calculates the voltage across R (Vout) for a given input signal(Vin)
%The RLC Circuit script is finding the solution to a second order differential equation representing an RLC-circuit

%set up initial conditions
q0 = 500*10^(-9); %[C]; capacitor charge at t=0 
i0 = 0; %current at t=0
t0 = 0; %set up starting time
h = 0.000001; %[s]; set up step-size for Runge-Kutta 3/8 
tf = 0.06; %[s]; define endpoint of time-interval

%define component values
R = 280; %resistance equals 280 Ohm
C = 4*10^(-6); %Capacitor value is 4 microFarad
L=600*10^(-3); %Inductance is 600 milliHenry

funcvin = @(t) 5; %define input signal (step-input, tf=0.06) as function of time

%the other input functions with their corresponding tf-value are stated
%below:
%funcvin = @(t) 5*exp(-t^2/(3*10^-6)); (impulse, tf=0.06)
%funcvin = @(t) 5*square(2*pi*t*5); (square, f=5Hz, tf=0.5)
%funcvin = @(t) 5*square(2*pi*t*110); (square, f=110Hz, tf=0.05)
%funcvin = @(t) 5*square(2*pi*t*500); (square, f=500Hz, tf=0.03)
%funcvin = @(t) 5*sin(2*pi*t*5); (sine, f=5Hz, tf=0.5)
%funcvin = @(t) 5*sin(2*pi*t*110); (sine, f=110Hz, tf = 0.05)
%funcvin = @(t) 5*sin(2*pi*t*500); (sine, f=500Hz, tf = 0.035)

%set up coupled first-order equations
funcq = @(t, q, i) i; %gradient of q at time t (=i(t))
funci = @(t, q, i)   (feval(funcvin, t) - R*i - 1/C * q)/L; %funci calculates di/dt at time t

N = round((tf-t0)/h); %calculate number of steps to reach tf

%set up arrays to store results
q = zeros(1,N);
i = zeros(1,N);
t = zeros(1,N);

%first element of each array is equal to corresponding initial condition
q(1) = q0;
i(1) = i0;
t(1) = t0;

%use for-loop to iterate through arrays 
%RK4second uses Runge-Kutta-3/8 algorithm to calculate next values for q
%and i as t is increased by h after each iteration
for j = 1 : N-1
   [q(j+1),i(j+1)] = RK4second(funcq, funci, h, t(j), q(j), i(j));
   t(j+1) = t(j) + h;
end

vout = i*R; %obtain Vout(t)(voltage across R) using Ohms Law
vin = arrayfun(funcvin, t); %calculate Vin(t)

figure;
plot(t, q); %plot q(t) as a function of t
title('Capacitor Charge (q_{C}(t))');
xlabel('Time [s]');
ylabel('Charge [C]');

figure;
plot(t, vout); %plot Vout(t) as a function of t
title('Output Voltage (V_{out}(t)=v_{R}(t))');
xlabel('Time [s]');
ylabel('Voltage [V]');


figure;
plot(t, vin); %plot Vin(t) as a function of t
title('Input Signal (V_{in}(t))');
xlabel('Time [s]');
ylabel('Voltage [V]');

