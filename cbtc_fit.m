function [theta_fit, K_mass] = cbtc_fit(theta0, data, ...
    obj_function, theta_lower, theta_upper)

% Performs nonlinear least squares fit using an initial guess theta0,  
% and data.  Data consists of the observation times,
% the CBTC data, and spatial location x_dist.
% The user must supply:
% 1: An objective function obj_function that takes 
% (theta, K, tobs, cobs) as arguements and optimizes theta subject to the
% bounds theta_lower <= theta <= theta_upper and
% 2: A PDF function which used in the mass calculation
% K = CBTC fits

% James F. Kelly
% 2 December 2015


theta_fit = theta0;
K_mass = 1.0;
f = @(theta) obj_function(theta,K_mass,data);
theta_fit = lsqnonlin(f,theta_fit,theta_lower,theta_upper);



end
