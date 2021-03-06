function [theta_fit, K_mass] = btc_fit(theta0, K0, data, ...
    obj_function, pdf_function, theta_lower, theta_upper)

% Performs nonlinear least squares fit using an initial guess theta0, a 
% guess for mass K0, and data.  Data consists of the observation times,
% the BTC data, and spatial location x_dist.
% The user must supply:
% 1: An objective function obj_function that takes 
% (theta, K, tobs, cobs) as arguements and optimizes theta subject to the
% bounds theta_lower <= theta <= theta_upper and
% 2: A PDF function which used in the mass calculation

% James F. Kelly
% 2 December 2015


N_ITER_MAX = 100;
tol = 1e-6;
K_mass = K0;
theta_fit = theta0;

for n_iter = 1:N_ITER_MAX

n_iter
theta_fit
clear f;
f = @(theta) obj_function(theta,K_mass,data);
theta_fit = lsqnonlin(f,theta_fit,theta_lower,theta_upper);
K_mass_new = calculate_mass(theta_fit,data,pdf_function);

stop_criterion = abs(K_mass - K_mass_new)./abs(K_mass_new);

if ( stop_criterion < tol)
    K_mass
    break;
else
    K_mass = K_mass_new;
end 


end

end
