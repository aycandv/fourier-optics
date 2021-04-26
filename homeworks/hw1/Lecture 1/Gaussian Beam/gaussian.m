close all;
clc;

lambda = 632.9e-9;
k = 2*pi/lambda;
c = 3e8;
f = c / lambda;
T = 1 / f;

dx = lambda * 2;
dz = lambda * 100;

Mx = 2048;
Mz = 1024;

z = ((0 : 1 : Mz-1) - (Mz-1)/2)*dz;
x = ((0 : 1 : Mx-1) - (Mx-1)/2)*dx;

xp = 0;
zp = 0;

[Z, X] = meshgrid(z, x);

z0=40e-3;
w0=sqrt(lambda*z0/pi);
W_z = w0 * sqrt(1 + (Z ./ z0).^2);
R_z = Z .* (1 + (z0 ./ Z).^2);
sigma_z = 1 ./ tan(Z ./ z0);

term1 = (w0 ./ W_z);
term2 = exp(-((X - xp).^2) ./ (W_z.^2));
term3 = exp(1j*k*Z + 1j*(k.*((X - xp).^2)) ./ 2.*R_z + 1j*sigma_z);

U = term1 .* term2 .* term3;

I=abs(U.^2);
I=I/max(max(I));
I=I.^(0.25);
I=uint8(I*255);

imagesc(z*1e6, x*1e6, I)
colormap(gray)
title(sprintf("Gaussian Wave Propagation with w0=%d um", w0*1e6));
xlabel("microns")
ylabel("microns")

figure
imagesc(z*1e6, x*1e6, angle(U))
colormap(gray)
colorbar
title(sprintf("Gaussian Wave Phase with w0=%d um", w0*1e6));
xlabel("microns")
ylabel("microns")