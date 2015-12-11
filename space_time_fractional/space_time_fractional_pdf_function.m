function p = space_time_fractional_pdf_function(theta,data)

if (length(theta) ~= 4)
    error('stable_fit requires exactly FOUR parameters!');
end

tobs = data.tobs;
x_dist = data.x_dist;
N_samples = length(tobs);
alpha = theta(1);
beta = theta(2);
gamma1 = theta(3);
v = theta(4);
D = theta(5)




tol_gamma = 1e-3;
tol_tail = 1e-2;
ovr_alpha = 1.0/alpha;


skew_alpha = (abs(cos(pi*alpha/2)))^(1/alpha);
gamma1p1 = gamma1 + 1.0;
N_samples = length(tobs);
p = zeros(size(tobs));

if (min(tobs) <= 0)
    error('observation times must be positive')
end


if (gamma1 <= 0 | gamma1 > (1 + tol_gamma))
    gamma1
    error('gamma1 must be greater than zero and less than or equal to one');
elseif (abs(gamma1 -1)<= tol_gamma)     
    % gamma approx 1 => no need to evaluate integral 
    for it = 1:N_samples
        t = tobs(it);
        sigma = skew_alpha * (t *D).^ovr_alpha;
        delta = v*t;
        theta = [alpha beta sigma delta]; 
        cfit(it) = stablepdf(x,theta,1);
    end
    
    
else

skew = (cos(pi*gamma1/2))^(1/gamma1);
theta = [gamma1 1 skew 0];    
    
%Compute tail tolerance here
r_tail = 4;
tail_diff = 1.0;
while (tail_diff > tol_tail)
    r_tail = r_tail + 0.25;
    tail = sin(pi*gamma1/2) * gamma(gamma1p1) / (pi * r_tail^gamma1p1);
    g_sub = stablepdf(r_tail,theta,1);
    tail_diff = abs(g_sub - tail);
end

    
    
    
N = 250;                          %Number of Gauss points
skew = (cos(pi*gamma1/2))^(1/gamma1);
theta = [gamma1 1 skew 0];
r_m = stablemode(theta,1);

%Integral 1: [rs,rm]
% rs is r for which g(rs) < threshold
% rm is the mode
mu = gamma1/(1 -gamma1);
B = gamma1^(1/(1 -gamma1)) * mu^-1;
r_s = (-B/log(1e-8))^(1/mu);

[r1,wgts1]=lgwt(N,r_s,r_m);
g1 = stablepdf(r1,theta,1);

%Integral 2: [rm, r_tail]
[r2,wgts2]=lgwt(N,r_m,r_tail);
g2 = stablepdf(r2,theta,1);

%Integral 3: [0, 1/r_tail^gamma]
[r3,wgts3]=lgwt(N,0,1.0/r_tail^gamma1);
g3 = sin(pi * gamma1/2) * gamma(gamma1p1)./(pi * gamma1);

theta = [alpha beta 1 0];
    
   
for it = 1:N_samples
  
    t = tobs(it);
    
    %integral 1
    tr = (t./r1).^gamma1;
    num = x - v .*tr;
    denom = (skew_alpha .* D .* tr).^ovr_alpha;
    arg1 = num./denom;
    if (abs(alpha - 2.0)<1e-3)
        ccdf = normpdf(arg1,0,1);
    else
      ccdf = stablepdf(arg1,theta,1);
    end
    
    integrand1 = ccdf .* g1;
    integral1 = sum(integrand1 .* wgts1);

    %integral 2
    tr = (t./r2).^gamma1;
    num = x - v .*tr;
    denom = (skew .* D .* tr).^ovr_alpha;
    arg1 = num./denom;
    if (abs(alpha - 2.0)<1e-3)
        ccdf = normpdf(arg1,0,1);
    else
      ccdf = stablepdf(arg1,theta,1);
    end  
    integrand2 = ccdf .* g2;
    integral2 = sum(integrand2 .* wgts2);
    
    %integral 3
    tgam = 1.0./t.^gamma1;
    num = x - r3.*tgam;
    denom = (skew_alpha .* D .* r3.*tgam).^ovr_alpha;
    arg1 = num./denom;
    if (abs(alpha - 2.0)<1e-3)
        ccdf = normpdf(arg1,0,1);
    else
        ccdf = stablepdf(arg1,theta,1);
    end
   
    integrand3 = ccdf .* g3;
    integral3 = sum(integrand3 .* wgts3);
    
    p(it) = integral1 + integral2 + integral3;
end




end



