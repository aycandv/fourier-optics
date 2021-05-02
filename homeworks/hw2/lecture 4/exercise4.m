clear;
close all;


delta_0 = 20e-3;
R1 = 400e-3;
R2 = -1e10;
n = 3/2;
lambda = 632.9e-9;
k = 2*pi/lambda;
f = 1/((n-1) * (1/R1));
D = 50e-3;

z0 = 50e-2;
f_number = f / D;
NA = sin(atan(1 / (2*f_number)));
spot_size = lambda / (2 * NA);

Mx = 2^20;

dx = 200e-9;
x = ((0 : 1 : Mx-1) - (Mx-1)/2)*dx;
dfx = 1 / (Mx*dx);
fx = ((0 : 1 : Mx-1) - (Mx-1)/2)*dfx;


L = 50e-4;
t = 1/2 * (1 + cos(2*pi*x/L));

a = abs(x) < D/2;
t = a .* t;

figure
plot(x, t)
xlabel("m")
title("Grating Thickness")

figure
hold on
plot(x, abs(t))


H = exp(1j * 2*pi * z0 * sqrt(1/(lambda^2) - fx.^2)); % Free space propagation by z0
T = FT2(t);
OUT = T .* H;
out = IFT2(OUT);
 
plot(x, abs(out)/max(abs(out(:))))
xlabel("m")
legend(["After passing grating", "After free space propagation"])
title("Field Amplitudes at Certain x points")