function p = spatial_fade_pdf_function(theta,data)

if (length(theta) ~= 4)
    error('stable_fit requires exactly FOUR parameters!');
end

tobs = data.tobs;
x_dist = data.x_dist;
N_samples = length(tobs);

alpha = theta(1);          %these are the parameters in fADE 
beta = theta(2);
nu = theta(3);
D = theta(4);

skew_factor = abs(cos(pi*alpha/2.0));
one_over_alpha = 1.0/alpha;
p =zeros(size(tobs));

for it = 1:N_samples
    t = tobs(it);
    sigma = (D*t*skew_factor).^one_over_alpha;
    theta_tilde = [alpha beta sigma nu.*t];
    if (alpha > 1.999)
        p(it) = 1./(sqrt(4*pi*D*t)) .*exp(-(x_dist - nu*t).^2 ./(4*D*t)); 
    elseif (alpha > 0.2)
        p(it) = stableqkpdf(x_dist,theta_tilde,1); 
    else
        p(it) = stablepdf(x_dist,theta_tilde,1); 
    end
end


end



