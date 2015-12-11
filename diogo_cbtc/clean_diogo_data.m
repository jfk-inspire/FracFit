function data = clean_diogo_data(a)

tobs = a(:,1);
cobs = a(:,2);
tobs = tobs -min(tobs);     %make sure smallest time is non-negative

%Dump negative values or values larger than one
i1 = find(cobs > 0.0 & cobs < 1.0);
tobs =tobs(i1);
cobs = cobs(i1);

%Cannot use t = 0
i2 = find(tobs > 0);
tobs = tobs(i2);
cobs = cobs(i2);


%restore units to time
Q = 2.1;  %mL/min (volume flow rate)
Vp = 12.5;  %mL (average pore volume)
tobs = (Vp/Q) .* tobs;

data.cobs = cobs;
data.tobs = tobs;
data.x_dist = 6.7;
data.conc_units = 'normalized';
data.time_units = 'minutes';
data.x_dist_units = 'cm';
data.time_units = 'minutes';
data.type = 'cbtc';

end

