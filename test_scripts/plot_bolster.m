% Fits data in Figure 2 in McInnis, Bolster et. al., 
% ENVIRONMENTAL ENGINEERING SCIENCE
% Volume 31, Number 12, 2014
% James F. Kelly
% 9 December 2015

clear all;

% Load and package the data
addpath('diogo_cbtc');
load 'diogo_cbtc/data_PSS8.mat';
data = clean_diogo_data(a);

%Choose and create the model
model = 'spatial_fade';
[obj_function,xdf_function] = create_model(model,data.type);
[theta_lower, theta_upper, theta0] = get_constraints_and_guess(model,data);

[theta_fit, K_mass] = cbtc_fit(theta0, data, ...
    obj_function, theta_lower, theta_upper);


%Evaluate fit
c_fit = K_mass .* xdf_function(theta_fit,data);

figure(1)
plot(data.tobs,c_fit,'-',data.tobs,data.cobs,'o')
set(gca,'fonts',18)
timestr = ['Time (' data.time_units ')'];
xlabel(timestr)
concstr = ['Concentration (' data.conc_units ')'];
ylabel(concstr)
legend('fit','data','Location','Best')
titlestr = [num2str(data.x_dist) ' ' data.x_dist_units ' from injection site'];
title(titlestr);
