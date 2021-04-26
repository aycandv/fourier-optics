%close all;
clc;

lambda = 632.9e-9;

k = 2*pi/lambda;

theta = 0*pi/4;
psi = 1*pi/4;
kx = k * sin(theta);
kz = k * cos(theta);


c = 3e8;
f = c / lambda;
T = 1 / f;

dt = T / 8;
dx = lambda / 32;
dz = lambda / 32;

Mx = 128;
Mz = 512;

z = ((0 : 1 : Mz-1) - (Mz-1)/2)*dz;
x = ((0 : 1 : Mx-1) - (Mx-1)/2)*dx;

xp = 0*lambda;
zp = -2*lambda;

[Z, X] = meshgrid(z, x);

U = exp(-1j * psi) * exp(-1j * (kx.*X + kz.*Z));
U = U ./ (max(abs(U(:))));

v = VideoWriter('plane_wave_psi-45_theta-0_conj.avi');
v.FrameRate = 12;
open(v);

for t = v.FrameRate*2:v.FrameRate*7
    u = real(U .* exp(-1j * 2*pi * f * (t)).^2);
    u = (u + 1) / 2;
    writeVideo(v,u);
end

close(v);