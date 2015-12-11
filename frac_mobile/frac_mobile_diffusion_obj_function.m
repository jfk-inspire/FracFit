function f_i = frac_mobile_diffusion_obj_function(theta,K_mass,data)

if (length(theta) ~= 4)
    error('frac_mobile_diffusion_obj_function requires exactly THREE parameters!');
end

cobs = data.cobs;
N_samples = length(cobs);
c_fit = K_mass .* frac_mobile_diffusion_pdf_function(theta,data);
wgts = 1.0./sqrt(N_samples*K_mass.*cobs);
f_i = wgts .* abs(cobs - c_fit);

end



