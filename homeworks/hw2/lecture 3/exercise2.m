clear;
close all;

%% SETUP

z0 = 50e-3;

lambda = 632.9e-9;
k = 2*pi/lambda;
theta = pi/4;
kx = k * sin(theta);
kz = k * cos(theta);

theta_l = -pi/18;
theta_h = pi/18;

f_l = sin(theta_l) / lambda;
f_h = sin(theta_h) / lambda;

Mx = 2^22;

dx = 200e-9;
x = ((0 : 1 : Mx-1) - (Mx-1)/2)*dx;
dfx = 1 / (Mx*dx);
fx = ((0 : 1 : Mx-1) - (Mx-1)/2)*dfx;

G = (fx < f_h) & (fx > f_l);
U = exp(1j * k * sqrt(x.^2 + z0^2));
U = U ./ max(abs(U(:)));
a = IFT2(FT2(U).*G);
a = a ./ max(abs(a(:)));

edge_l = tan(theta_l) * z0;
edge_h = tan(theta_h) * z0;

figure
hold on
plot(x, abs(U), "DisplayName", "Before Filter")
plot(x, abs(a), "DisplayName", "After Filter")
line([edge_l, edge_l],[0,1.2],'Color','k','LineWidth', 0.7, "LineStyle", "--", "DisplayName", "Lower Edge");
line([edge_h, edge_h],[0,1.2],'Color','k','LineWidth', 0.7, "LineStyle", "-.", "DisplayName", "Higher Edge");
legend()
xlabel("m")
ylabel("Normalized Amplitude")
title(sprintf("%s = %.1f degrees     %s = %.1f degrees", "\theta_L", 180*theta_l/pi, "\theta_H",180*theta_h/pi))
