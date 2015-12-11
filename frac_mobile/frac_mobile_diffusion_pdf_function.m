function p = frac_mobile_diffusion_pdf_function(theta,data)
% See Eq. (21) in Schumer et. al. "Fractal Mobile-Immobile Solute
% Transport".  This PDF assumes diffusion: c_conserv(x,u) = delta(x - uv)

if (length(theta) ~= 4)
    error('frac_mobile_diffusion_pdf_function requires exactly FOUR parameters!');
end

tobs = data.tobs;
N_samples = length(tobs);
p = zeros(size(tobs));


% Quadgk is overkill, but it's the only way to accureately 
% compute the tails.  Tried quad and quadl and the tails are
% not caputred.
for i1 =1:N_samples
    t = tobs(i1);
    fun = @(u)frac_integrand(u,data.x_dist,t,theta);
    p(i1) = quadgk(fun,0,t,'RelTol',1e-6);
end

end


function y = frac_integrand(u,x_dist,t,theta)


gamma1 = theta(1);
v = theta(2);           %particle velocity
beta = theta(3);        %retention constant
diffusion = theta(4);
skew_factor = abs(cos(pi*gamma1/2.0)).^(1/gamma1);
scale = (beta*u).^(1/gamma1);
theta_tilde = [gamma1 1  skew_factor 0];
if (gamma1 > 0.2)
    p = (1./scale) .* stableqkpdf((t - u)./scale,theta_tilde,1);
else
     p = (1./scale) .* stablepdf((t - u)./scale,theta_tilde,1);
end


c_conserv = 1./(sqrt(4*pi*diffusion*u)) .*...
    exp(-(x_dist - v*u).^2 ./(4*diffusion*u)); 

y = p .* c_conserv;

end



