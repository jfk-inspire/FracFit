function mass = calculate_mass(theta,data,pdf_function)

cobs = data.cobs;
p = pdf_function(theta,data);
num = sum(cobs);
denom = sum(p.^2./cobs);
mass = sqrt(num/denom);

end


