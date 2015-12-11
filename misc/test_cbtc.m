clear all;

% Load and package the data
addpath('diogo_cbtc');
load 'diogo_cbtc/data_PSS18.mat'
data = clean_diogo_data(a);

%Choose your model/pdf function 
% addpath('spatial_fade');
% obj_function = @spatial_fade_cbtc_obj_function;
% ccdf_function = @spatial_fade_ccdf_function;
addpath('frac_mobile');
obj_function = @frac_mobile_cbtc_obj_function;
ccdf_function = @frac_mobile_ccdf_function;


%Create a Guess 
i1 = min(find(data.cobs>.5));
tm = data.tobs(i1);           %crude estimate for mean time
v0 = data.x_dist/tm;          % v0 approx x_dist/tm 
% D0 = .01;
% theta0 = [1.5 -1 v0 D0];        %alpha, beta, v, D
% theta_lower = [0 -1 1e-6 1e-6];
% theta_upper = [2 1 1000 1000];

theta0 = [0.9 v0 .1];        %alpha, beta, v, D
theta_lower = [0 0 0];
theta_upper = [1 1000 1000];


%Optimize
% BTC_Fit requires iterating for mass
[theta_fit, K_mass] = cbtc_fit(theta0, data, ...
    obj_function, theta_lower, theta_upper);

c_fit = ccdf_function(theta_fit,data);

figure(2)
plot(data.tobs,c_fit,'-',data.tobs,data.cobs,'x')
set(gca,'fonts',18)
xlabel('time (minutes)')
ylabel('CBTC')
legend('fit','data')







