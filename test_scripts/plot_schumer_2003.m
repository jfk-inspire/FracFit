% Recreates Figure 6 in Schumer et. al., WRR 39, Vol 2003
% James F. Kelly
% 9 December 2015

clear all;

% Load and package the data
load 'haggerty/haggerty.mat';
%load 'red_cedar_exp3/testdata_3.1km.mat';
data.cobs = cobs;
data.conc_units = 'ppb';
data.tobs = tobs;
data.time_units = 's';
data.x_dist = 306.4;
data.x_dist_units = 'm';
data.type = 'btc';  


%Choose and create the model
model = 'frac_mobile_diffusion';
[obj_function,xdf_function] = create_model(model,data.type);
[theta_lower, theta_upper, theta0] = get_constraints_and_guess(model,data);

% Initial guess for mass
K0 = calculate_mass(theta0,data,xdf_function);

% BTC_Fit requires iterating for mass
[theta_fit, K_mass] = btc_fit(theta0, K0, data, ...
    obj_function, xdf_function, theta_lower, theta_upper);

%Evaluate fit
c_fit = K_mass .* xdf_function(theta_fit,data);

figure(1)
plot(data.tobs,c_fit,'-',data.tobs,data.cobs,'o')
set(gca,'fonts',18)
timestr = ['Time (' data.time_units ')'];
xlabel(timestr)
concstr = ['Concentration (' data.conc_units ')'];
ylabel(concstr)
legend('fit','data')
titlestr = [num2str(data.x_dist) ' ' data.x_dist_units ' from injection site'];
title(titlestr);
