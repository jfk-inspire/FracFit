function f_i = spatial_fade_obj_function(theta,K_mass,data)

if (length(theta) ~= 4)
    error('stable_fit requires exactly FOUR parameters!');
end

cobs = data.cobs;
N_samples = length(cobs);
c_fit = K_mass.*spatial_fade_pdf_function(theta,data);
wgts = 1.0./sqrt(N_samples*K_mass.*cobs);
f_i = wgts .* abs(cobs - c_fit);

end



