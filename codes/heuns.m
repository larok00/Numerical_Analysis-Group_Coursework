function [t,Vout] = heuns(Vin,iL0,h,R,L,ti,tf)
%The heuns.m finds the solution to an ordinary differential equation representing an RL-circuit and calculates Vout

a=1/2; % set scaling factor for heuns method
b=1/2;
p1=1;
q11=1;

func=@(t,iL) (feval(Vin,t)-R*iL)/L; % LiL'=Vin-R*iL -> iL'=f(t,iL)

N=round((tf-ti)/h); % number of steps=(interval size)/(step size)
t=zeros(1,N); iL=zeros(1,N); Vout=zeros(1,N); %set up arrays
Vout(1) = feval(Vin,ti);% calculate initial value of Vout
t(1)=ti; iL(1)=iL0; %set initial values of t_0, and iL at t_0
for j=1:N-1 % loop for N steps
    ttemp=t(j);iLtemp=iL(j); %temporary names
    grad1=feval(func, ttemp,iLtemp);  % gradient at t,iL
    iLp=iLtemp+q11*h*grad1; % calculate iL predictor
    grad2=feval(func, ttemp+p1*h,iLp); % gradient at t+p1*h, iL+q11k1h
    iL(j+1)=iLtemp+h*(a*grad1 + b*grad2); % next value of iL calculated from previous values of t,iL
    t(j+1)=ttemp+h; % increase t by stepsize
    Vout(j+1)=feval(Vin,t(j+1))-R*iL(j+1);%calculate Vout
end
