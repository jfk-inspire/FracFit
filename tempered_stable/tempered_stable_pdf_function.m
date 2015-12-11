function p = tempered_stable_pdf_function(theta,data)
% p = tempered_stable_pdf_function(theta,data)

if (length(theta) ~= 5)
    error('tempered_stable_pdf_function requires exactly FOUR parameters!');
end

tobs = data.tobs;
x_dist = data.x_dist;
N_samples = length(tobs);

alpha = theta(1);          %these are the parameters in fADE 
beta = theta(2);
nu = theta(3);
D = theta(4);
lambda = theta(5);

p =zeros(size(tobs));

for it = 1:N_samples
    t = tobs(it);
    theta_tilde = [alpha beta D lambda];
    p(it) = tempered_stablepdf(x_dist-nu*t,t,theta_tilde); 
end


end



