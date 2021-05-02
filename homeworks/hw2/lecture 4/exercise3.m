clear;
close all;

Mx = 2^21;

dx = 500e-9;
x = ((0 : 1 : Mx-1) - (Mx-1)/2)*dx;
dfx = 1 / (Mx*dx);
fx = ((0 : 1 : Mx-1) - (Mx-1)/2)*dfx;

alpha = pi/12;

n = 3/2;
lambda = 632.9e-9;
k = 2*pi/lambda;
D = 30e-2;

z0 = 1;


delta_x = tan(alpha).*(x - min(x));
delta_0 = max(delta_x);

figure
plot(x, delta_x)
title("Thickness of the prism as a function of x")
xlabel("x (m)")
ylabel("Thickness (m)")

phase = k * ((n-1)*delta_x + delta_0);

a = abs(x) < D/2;
t = exp(1j*phase);
t = a .* t;
T = FT2(t);

H = exp(1j * 2*pi * z0 * sqrt(1/(lambda^2) - fx.^2)); % Free space propagation by z0
OUT = T .* H;
out = IFT2(OUT);

figure
hold on
plot(x, abs(t))
plot(x, abs(out))
title(sprintf("Diffraction Field of a Prism with angle %.0f%s", 180*alpha/pi, "^{\circ}"))
xlabel("x (m)")
ylabel("Amplitude")
legend(["Input field to the prism", "Diffraction field at z=1m"])