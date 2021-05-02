clear;
close all;


delta_0 = 20e-3;
R1 = 400e-3;
R2 = -1e10;
n = 3/2;
lambda = 632.9e-9;
k = 2*pi/lambda;
f = 1/((n-1) * (1/R1));
D = 20e-3;

z0 = 0.8;
f_number = f / D;
NA = sin(atan(1 / (2*f_number)));
spot_size = lambda / (2 * NA);

Mx = 2^20;

dx = 200e-9;
x = ((0 : 1 : Mx-1) - (Mx-1)/2)*dx;
dfx = 1 / (Mx*dx);
fx = ((0 : 1 : Mx-1) - (Mx-1)/2)*dfx;



delta_x = delta_0 - R1*(1 - sqrt(1 - (x.^2/R1^2)));

figure
plot(delta_x)

phase = k * ((n-1)*delta_x + delta_0);

t = exp(1j*phase);

a = abs(x) < D/2;
t = a .* t;

figure
hold on
plot(x, abs(t))

H = exp(1j * 2*pi * z0 * sqrt(1/(lambda^2) - fx.^2)); % Free space propagation by z0
T = FT2(t);
OUT = T .* H;
out = IFT2(OUT);
% 
plot(x, abs(out)/max(abs(out(:))))

