%close all;
clc;

lambda = 632.9e-9;
k = 2*pi/lambda;
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

U = exp(1j * k .* sqrt((Z - zp).^2 + (X - xp).^2));
U = U ./ (max(abs(U(:))));

v = VideoWriter('converging_spherical_wave.avi');
v.FrameRate = 12;
open(v);

for t = v.FrameRate*2:v.FrameRate*6
    u = real(U .* exp(-1j * 2*pi * f * (t)).^2);
    u = (u + 1) / 2;
    writeVideo(v,u);
end

close(v);