% Recreates Fig. 4, panel 2 in Chakroborty, Meerschaert, and Lim, WRR:45, 2009
% James F. Kelly
% 9 December 2015

clear all;

% Load data and construct a data object
load 'red_cedar_exp3/testdata_1.4km.mat';
data.cobs = cobs;
data.conc_units = '\mug/L';
data.tobs = tobs;
data.time_units = 'minutes';
data.x_dist = 1.4;
data.x_dist_units = 'km';
data.type = 'btc';  

%Choose and create the model
model = 'spatial_fade';
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
