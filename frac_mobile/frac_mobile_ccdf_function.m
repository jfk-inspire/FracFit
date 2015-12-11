function p = frac_mobile_ccdf_function(theta,data)
% See Eq. (21) in Schumer et. al. "Fractal Mobile-Immobile Solute
% Transport"

if (length(theta) ~= 3)
    error('frac_mobile_ccdf_function requires exactly THREE parameters!');
end

tobs = data.tobs;
N_samples = length(tobs);
p = zeros(size(tobs));
v = theta(2);
lower_lim = data.x_dist/v;

% Quadgk is overkill, but it's the only way to accureately 
% compute the tails.  Tried quad and quadl and the tails are
% not caputred.

%Compute preconstant
%t_late = 100 * (lower_lim);
%fun = @(u)frac_integrand2(u,data.x_dist,t_late,theta);
%cconst = quadgk(fun,lower_lim,t_late,'RelTol',1e-6);
cconst = theta(3)^theta(1);

for i1 =1:N_samples
    t = tobs(i1);
    fun = @(u)frac_integrand2(u,data.x_dist,t,theta);
    %Get constant
    p(i1) = quadgk(fun,lower_lim,t,'RelTol',1e-6);
end

gamma1 = theta(1);
%p = p./(abs(cos(pi*gamma1/2.0)).^(1/gamma1));

end


function y = frac_integrand2(u,x_dist,t,theta)


gamma1 = theta(1);
v = theta(2);           %particle velocity
beta = theta(3);        %retention constant
skew_factor = abs(cos(pi*gamma1/2.0)).^(1/gamma1);
scale = (beta*u).^(1/gamma1);
theta_tilde = [gamma1 1  skew_factor 0];
if (gamma1 > 0.2)
    y = (1./scale) .* stableqkpdf((t - u)./scale,theta_tilde,1);
else
    y = (1./scale) .* stablepdf((t - u)./scale,theta_tilde,1);
end

end



