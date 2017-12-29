L = 1.;      % wire length
T = 1.;      % max simulation time
Nt = 2500;   % number of timesteps
Nx = 50;     % number of spacial divisions
dt = T / Nt; % increment through time
dx = L / Nx; % increment through space

% conductivity parameter
r = 0.25 * dt / (dx*dx);
if r > 0.5
	% von neumann stability criterion has been violated
    disp('warning: for stability, r <= 1/2');
    r
end

% lambdas to compute initial wire heat distribution
initialcond = @(x, L, Nx) abs(sin(2*pi*x/(Nx+1)));
% initialcond = @(x, L, Nx) sin(2 * pi * x / (Nx+1) / L);
% initialcond = @(x, L, Nx) triangularPulse(0.0, L, x/(Nx+1));
% initialcond = @(x, L, Nx) sinc(6 * pi * ((x - (Nx+1)/2) / (Nx+1)));
% initialcond = @(x, L, Nx) -12.0;

% lambdas to compute heat at edge of wire for x=0
leftbound = @(t, Nt) sin(2*pi*t/Nt);
% leftbound = @(t, Nt) -sin(2*pi*t/Nt);
% leftbound = @(t, Nt) 0.0;

% lambdas to compute heat at edge of wire for x=L
rightbound = @(t, Nt) sin(2*pi*t/Nt);
% rightbound = @(t, Nt) 0.0;

% compute initial conditions and make an x-axis for plotting
for i = 1:Nx+1
    x(i) = (i-1)*dx;
    u(i,1) = initialcond(i, L, Nx);
end

% compute boundary conditions and make a time-axis for plotting
for t = 1:Nt+1
    u(1,t) = leftbound(t, Nt);
    u(Nx+1, t) = rightbound(t, Nt);
    time(t) = (t-1) * dt;
end

% go-time; iterate over entire matrix
for t=1:Nt
    for i = 2:Nx
    	% directly from the expression we obtained
        u(i, t+1) = (1-2*r) * u(i,t) + r*u(i+1, t) + r*u(i-1,t);
    end
end

figure(1)
% plot snapshots of heat distribution for [0, 0.25, 0.5, 0.75, 1] * T
% even time spacing means this plot indicates how fast heat is diffusing
% too many more or fewer would mean the plot would be cluttered, IMO
plot(x,u(:,int32(0.00*Nt)+1),'-', ...
     x,u(:,int32(0.25*Nt)),'-',   ...
     x,u(:,int32(0.50*Nt)),'-',   ...
     x,u(:,int32(0.75*Nt)),'-',   ...
     x,u(:,int32(Nt)),'-')
legend('t=0', 't=0.25T', 't=0.5T', 't=0.75T', 't=T')
figure(2)
% 3d plot, with a space and a time axis; I prefer this for showing variation,
% _especially_ with an overhead view
mesh(x,time,u')