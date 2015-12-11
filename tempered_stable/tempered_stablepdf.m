function p = tempered_stablepdf(x,t,theta)
% p = tempered_stablepdf(x,t,theta)
% theta = [alpha, beta, c, lambda]
% Evaluates tempered stable pdf using Eq. (8)

alpha = theta(1);
beta = theta(2);
c = theta(3);
lambda = theta(4);
sigma = (c*t*abs(cos(pi*alpha/2)))^(1/alpha);
theta_stable = [alpha beta sigma 0];


if (abs(alpha -1) > .001) 
    x1 = x - c*t*alpha*lambda^(alpha -1);
    exparg = -lambda.*x + (alpha -1).*c .* t .* lambda^alpha;
    p = exp(exparg) .* stablepdf(x1,theta_stable,1);
    
else        %special case (alpha == 1)
    x1 = x - c*t.*(1 + log(lambda));
    exparg = -lambda*x + c*t.*x;
    p = exp(exparg) .* stablepdf(x1,theta_stable,1);
end

end

