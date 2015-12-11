clear all;

% Load and package the data
load 'haggerty/haggerty.mat';
%load 'red_cedar_exp3/testdata_3.1km.mat';
data.cobs = cobs;
data.tobs = tobs;
data.x_dist = 306.4;

%Choose your model/pdf function 
 addpath('spatial_fade');
 obj_function = @spatial_fade_obj_function;
 pdf_function = @spatial_fade_pdf_function;
% addpath('frac_mobile');
% obj_function = @frac_mobile_diffusion_obj_function;
% pdf_function = @frac_mobile_diffusion_pdf_function;
% 
%obj_function = @frac_mobile_obj_function;
%pdf_function = @frac_mobile_pdf_function;


%Guess parameters (automate if needed)
[cmax, imax] = max(data.cobs);
v0 = data.x_dist/data.tobs(imax);

%theta0 = [1.3 -1 v0 .2];
theta0 = [1.8  -1 v0 0.05];
theta_lower = [0.001 -1 1e-7 1e-7];
theta_upper = [1.999 1 1000 1000];



%theta = [gamma v0 beta D]
%theta0 = [0.5 0.1 .001 .2];
K0 = calculate_mass(theta0,data,pdf_function);
% theta_lower = [0 0 0 0];
% theta_upper = [1 1000 1000 1000];


%Optimize
% BTC_Fit requires iterating for mass
[theta_fit, K_mass] = btc_fit(theta0, K0, data, ...
    obj_function, pdf_function, theta_lower, theta_upper);

c_fit = K_mass .* pdf_function(theta_fit,data);

figure(2)
loglog(data.tobs,c_fit,'-',data.tobs,data.cobs,'o')
set(gca,'fonts',18)
xlabel('time (s)')
ylabel('BTC')
legend('fit','data')
title(['\theta = ' num2str(theta_fit)])






