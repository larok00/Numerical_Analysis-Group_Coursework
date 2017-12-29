%set up initial conditions
iL0=0; 
ti=0;

%define component values
R=0.5;
L=0.0015;

for n=1:15 %defines all 15 Vin
if(n<4)
    if(n==1)
        Vina = 5.5;
        Vin=@(t) Vina*exp(0); %define input signal as function of time
        figure
    end
    if(n==2)
        Vina = 3.5;
        tau = 160e-12;
        Vin=@(t) Vina*exp(-t^2/tau); %define input signal as function of time
    end
    if(n==3)
        Vina = 3.5;
        tau = 160e-6;
        Vin=@(t) Vina*exp(-t/tau); %define input signal as function of time
    end
    Vout = feval(Vin,ti)-R*iL0;
    subplot(3,2,n);
    plot(ti,Vout); % plot initial condition
end
if((n>3)&&(n<16))
    if (n==4)
        figure
        Vina = 4.5;
        T= 20e-6;
        Vin=@(t) Vina*sin(2*pi*t/T); %define input signal as function of time
    end
    if (n==5)
        Vina = 4.5;
        T= 160e-6;
        Vin=@(t) Vina*sin(2*pi*t/T); %define input signal as function of time
    end
    if (n==6)
        Vina = 4.5;
        T= 450e-6;
        Vin=@(t) Vina*sin(2*pi*t/T); %define input signal as function of time
    end
    if (n==7)
        Vina = 4.5;
        T= 1000e-6;
        Vin=@(t) Vina*sin(2*pi*t/T); %define input signal as function of time
    end
    if (n==8)
        Vina = 4.5;
        T= 20e-6;
        Vin=@(t) Vina*square(2*pi*t/T); %define input signal as function of time
    end
    if (n==9)
        Vina = 4.5;
        T= 160e-6;
        Vin=@(t) Vina*square(2*pi*t/T); %define input signal as function of time
    end
    if (n==10)
        Vina = 4.5;
        T= 450e-6;
        Vin=@(t) Vina*square(2*pi*t/T); %define input signal as function of time
    end
    if (n==11)
        Vina = 4.5;
        T= 1000e-6;
        Vin=@(t) Vina*square(2*pi*t/T); %define input signal as function of time
    end
    if (n==12)
        Vina = 4.5;
        T= 20e-6;
        Vin=@(t) Vina*sawtooth(2*pi*t/T); %define input signal as function of time
    end
    if (n==13)
        Vina = 4.5;
        T= 160e-6;
        Vin=@(t) Vina*sawtooth(2*pi*t/T); %define input signal as function of time
    end
    if (n==14)
        Vina = 4.5;
        T= 450e-6;
        Vin=@(t) Vina*sawtooth(2*pi*t/T); %define input signal as function of time
    end
    if (n==15)
        Vina = 4.5;
        T= 1000e-6;
        Vin=@(t) Vina*sawtooth(2*pi*t/T); %define input signal as function of time
    end
    nn=n-3;
    Vout = feval(Vin,ti)-R*iL0;
    subplot(3,4,nn);
    plot(ti,Vout); % plot initial condition
end

if(n==1)   %plots all 15 Vout against time
    h=10e-7; % set step-size
    tf=0.04; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,2,1);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=5.5V')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

if(n==2)

    h=10e-7; % set step-size
    tf=0.0001; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,2,2);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=Vin exp(-t^2/tau)')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

if(n==3)

    h=10e-7; % set step-size
    tf=0.003; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,2,3);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=Vin exp(-t/tau)')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

if(n==4)
    h=10e-9; % set step-size
    tf=0.00004; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,4,1);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=4.5sin(2pit/T) T = 20e-6s')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

if(n==5)
    h=10e-7; % set step-size
    tf=0.00032; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,4,2);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=4.5sin(2pit/T) T = 160e-6s')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

if(n==6)
    h=10e-7; % set step-size
    tf=0.0009; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,4,3);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=4.5sin(2pit/T) T = 450e-6s')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

if(n==7)
    h=10e-7; % set step-size
    tf=0.002; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,4,4);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=4.5sin(2pit/T) T = 1000e-6s')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

if(n==8)
    h=10e-9; % set step-size
    tf=0.00004; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,4,5);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=4.5square(2pit/T) T = 20e-6s')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

if(n==9)
    h=10e-7; % set step-size
    tf=0.00032; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,4,6);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=4.5square(2pit/T) T = 160e-6s')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

if(n==10)
    h=10e-7; % set step-size
    tf=0.0009; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,4,7);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=4.5square(2pit/T) T = 450e-6s')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

if(n==11)
    h=10e-7; % set step-size
    tf=0.002; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,4,8);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=4.5square(2pit/T) T = 1000e-6s')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

if(n==12)
    h=10e-9; % set step-size
    tf=0.00004; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,4,9);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=4.5sawtooth(2pit/T) T = 20e-6s')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

if(n==13)
    h=10e-7; % set step-size
    tf=0.00032; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,4,10);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=4.5sawtooth(2pit/T) T = 160e-6s')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

if(n==14)
    h=10e-7; % set step-size
    tf=0.0009; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,4,11);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=4.5sawtooth(2pit/T) T = 450e-6s')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

if(n==15)
    h=10e-7; % set step-size
    tf=0.002; % set final value of t
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf); %obtain arrays of Vout and t using midpoint method
    subplot(3,4,12);
    plot(t,Vout); % plot Vout against t
    title('Midpoint Vin=4.5sawtooth(2pit/T) T = 1000e-6s')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end

end


