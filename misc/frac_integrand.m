function y = frac_integrand(u,x_dist,t,theta)


gamma1 = theta(1);
v = theta(2);           %particle velocity
beta = theta(3);        %retention constant
diffusion = theta(4);
skew_factor = abs(cos(pi*gamma1/2.0)).^(1/gamma1);
scale = (beta*u).^(1/gamma1);
theta_tilde = [gamma1 1  skew_factor 0];
p = (1./scale) .* stablepdf((t - u)./scale,theta_tilde,1);
c_conserv = 1./(sqrt(4*pi*diffusion*u)) .*...
    exp(-(x_dist - v*u).^2 ./(4*diffusion*u)); 

%y = p .* c_conserv;
y = c_conserv;

end