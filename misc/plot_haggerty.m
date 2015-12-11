clear all;


% Load and package the data
load 'haggerty/haggerty.mat';
%load 'red_cedar_exp3/testdata_3.1km.mat';
data.cobs = cobs;
data.tobs = tobs;
data.x_dist = 306.4;

%Choose your model/pdf function 
addpath('spatial_fade');
pdf_function1 = @spatial_fade_pdf_function;
theta1 = [1.2513 -1 .08594 .077013];
Kmass1 = calculate_mass(theta1,data,pdf_function1);
addpath('frac_mobile');
pdf_function2 = @frac_mobile_pdf_function;
theta2 = [0.771 .1734 .1481];
Kmass2 = calculate_mass(theta2,data,pdf_function2);

c_fit1 = Kmass1 .* pdf_function1(theta1,data);
c_fit2 = Kmass2 .* pdf_function2(theta2,data);


figure(2)
loglog(data.tobs,c_fit1,'-',data.tobs,c_fit2,'--',...
    data.tobs,data.cobs,'o')
set(gca,'fonts',18)
xlabel('time (s)')
ylabel('BTC')
legend('spatial fADE','FIT (no diffusion)','data')
%title(['\theta = ' num2str(theta_fit)])






