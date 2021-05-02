clear;
close all;

%% SETUP

z0 = 50e-3;

lambda = 632.9e-9;
k = 2*pi/lambda;

Mx = 2^19;

w0 = 1e-3;
xs = -50e-3;
zs = -100e-3;
z0 = 100e-3;

dx = 800e-9;
x = ((0 : 1 : Mx-1) - (Mx-1)/2)*dx;
dfx = 1 / (Mx*dx);
fx = ((0 : 1 : Mx-1) - (Mx-1)/2)*dfx;


w = abs(x) < w0/2;
U = exp(1j * k * sqrt((x + xs).^2 + abs(zs)^2));
U = U ./ max(abs(U(:)));
a = IFT2(FT2(U).*FT2(w));
a = a ./ max(abs(a(:)));

figure
hold on
plot(x, abs(U), "DisplayName", "Before Filter")
plot(x, abs(a), "DisplayName", "On the Filter")
legend()
xlabel("m")
ylabel("Normalized Amplitude")

theta_center = tan(xs / zs);

theta_l = tan((xs - w0/2) / zs);
theta_h = tan((xs + w0/2) / zs);

x_l = tan(theta_l) * (abs(zs) + z0) - abs(xs);
x_h = tan(theta_h) * (abs(zs) + z0) - abs(xs);
x_c = tan(theta_center) * (abs(zs) + z0) - abs(xs);

hold on
U = exp(1j * k * sqrt((x - xs - x_c).^2 + abs(z0)^2));
out = abs(IFT2(FT2(a) .* FT2(U)));
out = out / max(out);
plot(x, out, "DisplayName", "5 cm away from filter")
