iL0=0; % set initial values
ti=0;
R=0.5; % set constant values
L=0.0015;
A=6;
Vina = 6;
T= 150e-6;
Vin=@(t) Vina*cos(2*pi*t/T); % set Vin
c=((A*R*T^2)/(4*pi^2*L^2+R^2*T^2)); %c for exact solution

tf=0.0003; % set final value of t

for n=1:3

if(n==1)
    h=10e-7; % set step-size
    [t,Vout]=heuns(Vin,iL0,h,R,L,ti,tf);
    figure
    subplot(3,2,1);
    plot(t,Vout); % plot heuns Vout against t
    title('Heuns Vin=6cos(2*pi*t/150e-6)')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end
if(n==2)
    h=10e-7; % set step-size
    [t,Vout]=midpoint(Vin,iL0,h,R,L,ti,tf);
    figure
    subplot(3,2,1);
    plot(t,Vout); % plot heuns Vout against t
    title('Midpoint Vin=6cos(2*pi*t/150e-6)')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end
if(n==3)
    h=10e-7; % set step-size
    [t,Vout]=ralston(Vin,iL0,h,R,L,ti,tf);
    figure
    subplot(3,2,1);
    plot(t,Vout); % plot heuns Vout against t
    title('Ralston Vin=6cos(2*pi*t/150e-6)')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
end
iL_exact=((2*A*pi*T*L*sin((2*pi*t)/T)+A*R*T^2*cos((2*pi*t)/T))/(4*pi^2*L^2+R^2*T^2))-(c*exp(-R*t/L)); %calculate exact solution 
Vout_exact=feval(Vin,t)-R*iL_exact; % calculate Vout for exact iL
subplot(3,2,2);
plot(t,Vout_exact); %plot exact solution
    title('Exact solution of the ODE')
    xlabel('Time [s]') % x-axis label
    ylabel('Vout [V]') % y-axis label
error=abs(Vout_exact-Vout); % calculate maximum error over range of x
subplot(3,2,[3,4]);
plot(t,error); % plot error against t
    title('Error against time')
    xlabel('Time [s]') % x-axis label
    ylabel('Error [V]') % y-axis label

subplot(3,2,[5,6]);
h = zeros(1,10);    %initialize arrays
errororder = zeros(1,10);
count = 1;  %initiallize count



if(n==1)
    hi=1e-9;hh=1e-9;hf=1e-7;                 % set initial step-size, increment in step-size and final step-size value
    h=hi:hh:hf;
    Nh=round((hf-hi)/hh)+1;     % number of steps=(interval size of step-size)/(increment in step-size)
    for count=1:Nh 
        [t,Vout]=heuns(Vin,iL0,h(count),R,L,ti,tf);% call heuns.m
        iL_exact=((2*A*pi*T*L*sin((2*pi*t)/T)+A*R*T^2*cos((2*pi*t)/T))/(4*pi^2*L^2+R^2*T^2))-(c*exp(-R*t/L)); %calculate exact solution
        Vout_exact=feval(Vin,t)-R*iL_exact; % calculate Vout using exact solution iL
        errororder(count)=max(abs(Vout_exact-Vout)); % calculate maximum error over range of x
        hold on;
    end
    hold off;
    plot(log(h),log(errororder));
    gradheuns=polyfit(log(h), log(errororder),1);
end

if(n==2)
    hi=1e-9;hh=1e-9;hf=1e-7;                 % set initial step-size, increment in step-size and final step-size value
    h=hi:hh:hf;
    Nh=round((hf-hi)/hh)+1;      % number of steps=(interval size of step-size)/(increment in step-size)
    for count=1:Nh 
        [t,Vout]=midpoint(Vin,iL0,h(count),R,L,ti,tf);% call heuns.m
        iL_exact=((2*A*pi*T*L*sin((2*pi*t)/T)+A*R*T^2*cos((2*pi*t)/T))/(4*pi^2*L^2+R^2*T^2))-(c*exp(-R*t/L)); %calculate exact solution
        Vout_exact=feval(Vin,t)-R*iL_exact; % calculate Vout using exact solution iL
        errororder(count)=max(abs(Vout_exact-Vout)); % calculate maximum error over range of x
        hold on;
    end
    hold off;
    plot(log(h),log(errororder));
    gradmidpoint=polyfit(log(h), log(errororder),1);
end

if(n==3)
    hi=1e-9;hh=1e-9;hf=1e-7;                 % set initial step-size, increment in step-size and final step-size value
    h=hi:hh:hf;
    Nh=round((hf-hi)/hh)+1;      % number of steps=(interval size of step-size)/(increment in step-size)
    for count=1:Nh 
        [t,Vout]=ralston(Vin,iL0,h(count),R,L,ti,tf);% call heuns.m
        iL_exact=((2*A*pi*T*L*sin((2*pi*t)/T)+A*R*T^2*cos((2*pi*t)/T))/(4*pi^2*L^2+R^2*T^2))-(c*exp(-R*t/L)); %calculate exact solution
        Vout_exact=feval(Vin,t)-R*iL_exact; % calculate Vout using exact solution iL
        errororder(count)=max(abs(Vout_exact-Vout)); % calculate maximum error over range of x
        hold on;
    end
    hold off;
    plot(log(h),log(errororder)); % plot log log graph
    gradralston=polyfit(log(h), log(errororder),1);% calculate gradient
end
    title('log of maximum error against log of h')
    ylabel('log error max') % x-axis label
    xlabel('log h') % y-axis label
end