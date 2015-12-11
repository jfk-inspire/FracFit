function [theta_lower, theta_upper, theta0] = get_constraints_and_guess(model,data)
% [theta_lower, theta_upper] = get_constraints(model)
% Given a string with the model name, determine the lower and upper
% constraints on the parameter theta that is being optimized.
% Also returns a (crude) initial guess.  You may want to override this
% guess with a "hand fit".

if (not(ischar(model)))
error('model must be a character array');
end

[cmax, imax] = max(data.cobs);
v0 = data.x_dist/data.tobs(imax);        

if (strcmp(model,'spatial_fade'))
    theta_lower = [0.001 -1 1e-7 1e-7];
    theta_upper = [2 1 1000 1000];
    theta0 = [1.95  0 v0 .00001];
elseif (strcmp(model,'spatial_fade_negskew'))
    theta_lower = [0.001 -1 1e-7 1e-7];
    theta_upper = [2 -0.9999 1000 1000];    
    theta0 = [1.95  -1 v0 .00001];
elseif (strcmp(model,'ade'))               
    theta_lower = [1.9999 -1 1e-7 1e-7];
    theta_upper = [2 1 1000 1000];
    theta0 = [2  0 v0 .00001];  
elseif  (strcmp(model,'frac_mobile'))
    theta_lower = [0 1e-7 1e-7];
    theta_upper = [1 1000 1000];    
    theta0 = [0.5 v0 .1];
elseif (strcmp(model,'frac_mobile_diffusion'))
    theta_lower = [0 1e-7 1e-7 1e-7];
    theta_upper = [1 1000 1000 1000]; 
    theta0 = [0.95 v0 .0001 .0001];
else
    error('Model not supported.');         
end

end


