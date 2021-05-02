clear;
close all;

lambda = 632.9e-9;
k = 2*pi/lambda;

D = 20e-3;
f = 100e-3;
z0 = 100e-3;
f_number = f / D;
NA = sin(atan(1 / (2*f_number)));
spot_size = lambda / (2 * NA);

Mx = 2^20;

dx = 200e-9;
x = ((0 : 1 : Mx-1) - (Mx-1)/2)*dx;
dfx = 1 / (Mx*dx);
fx = ((0 : 1 : Mx-1) - (Mx-1)/2)*dfx;

a = abs(x) < D/2;
t = a .* exp(-1j * k * sqrt(x.^2 + z0^2));

figure
hold on
plot(x, abs(t))

H = exp(1j * 2*pi * z0 * sqrt(1/(lambda^2) - fx.^2)); % Free space propagation by z0
T = FT2(t);
OUT = T .* H;
out = IFT2(OUT);

plot(x, abs(out)/max(abs(out(:))))

