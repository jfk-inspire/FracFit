function f_i = spatial_fade_cbtc_obj_function(theta,K_mass,data)

if (length(theta) ~= 4)
    error('stable_fit requires exactly FOUR parameters!');
end

cobs = data.cobs;
N_samples = length(cobs);
c_fit = K_mass.*spatial_fade_ccdf_function(theta,data);
wgts = 1.0./sqrt(N_samples*K_mass.*cobs.*(1 -cobs));
f_i = wgts .* (cobs - c_fit);

end



