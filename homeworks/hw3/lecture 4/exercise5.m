clear;
close all;


wavelength = 632.9e-9;
k = 2*pi/wavelength;


Mx = 2^21;

dx = 300e-9;
x = ((0 : 1 : Mx-1) - (Mx-1)/2)*dx;
dfx = 1 / (Mx*dx);
fx = ((0 : 1 : Mx-1) - (Mx-1)/2)*dfx;

w = 1e-2;
delta = 25e-5;
L = 5e-6;
lambda = 0.5e-6;

a = abs(x) < w/2;

t = 0;
for m=-20:20
    t = t | (a .* rect((x - m*delta)/L));
end


plot(x, t)
plot(fx, abs(FT2(t)))

n = 3/2;
f = 10e-2;
D = 2e-2;

z0 = 10e-2;
f_number = f / D;
NA = sin(atan(1 / (2*f_number)));
spot_size = lambda / (2 * NA);


% Before lens
H = exp(1j * 2*pi * z0 * sqrt(1/(wavelength^2) - fx.^2)); % Free space propagation by z0
T = FT2(t);
OUT = T .* H;
out = IFT2(OUT);

figure
plot(x, abs(out)/max(abs(out(:))))
xlabel("m")
legend(["After free space propagation"])
title("Field Amplitudes at Certain x points")

% After Lens
a = abs(x) < D/2;
t = a .* exp(-1j * k * sqrt(x.^2 + f^2));

% R1 = f * (n - 1);
% delta_x = D - R1*(1 - sqrt(1 - (x.^2/R1^2)));
% phase = k * ((n-1)*delta_x + D);
% t = exp(1j*phase);
% 
% a = abs(x) < diameter/2;
t = a .* t .* out;

T = FT2(t);
OUT = T .* H;
out = IFT2(OUT);

figure
plot(x, abs(out)/max(abs(out(:))))
