function [xn, yn] = RK4second(funcx, funcy, h, ti, xi, yi)
%RK4second computes y(i+1) and x(i+1) using the Runge-Kutta 3/8 algorithm
%   xn refers to x(i+1) and yn refers to y(i+1)
%   funcx computes the derivative of x (dx/dt) at a point (ti, xi, yi)
%   funcy computes the derivative of y (dy/dt) at a point (ti, xi ,yi)

%calculate coefficients (predicted gradients) at ti, ti+h/3, ti+2h/3, ti+h 
%using Runge-Kutta 3/8
k1x = feval(funcx, ti, xi, yi);
k1y = feval(funcy, ti, xi, yi);
k2x = feval(funcx, ti + h/3, xi + h/3*k1x, yi + h/3*k1y);
k2y = feval(funcy, ti + h/3, xi + h/3*k1x, yi + h/3*k1y);
k3x = feval(funcx, ti + 2*h/3, xi - h/3*k1x+h*k2x, yi - h/3*k1y+h*k2y);
k3y = feval(funcy, ti + 2*h/3, xi - h/3*k1x+h*k2x, yi - h/3*k1y+h*k2y);
k4x = feval(funcx, ti+h, xi+h*k1x-h*k2x+h*k3x, yi+h*k1y-h*k2y+h*k3y);
k4y = feval(funcy, ti+h, xi+h*k1x-h*k2x+h*k3x, yi+h*k1y-h*k2y+h*k3y);

%obtain phix and phiy by taking weighted average of obtained gradients
phix = (k1x + 3*k2x + 3*k3x + k4x)/8;
phiy = (k1y + 3*k2y + 3*k3y + k4y)/8;

%use phi-values as approximated gradients for x and y
xn = xi + h*phix; %calculate x(i+1)
yn = yi + h*phiy; %calculate y(i+1)
end

