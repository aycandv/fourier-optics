clear;
close all;

%% SETUP

lambda = 632.9e-9;
k = 2*pi/lambda;

Mx = 2048;
My = 2048;

dx = 5e-6;
dy = 5e-6;
x = ((0 : 1 : Mx-1) - (Mx-1)/2)*dx;
y = ((0 : 1 : My-1) - (My-1)/2)*dy;
[X, Y] = meshgrid(x, y);

dfx = 1 / (Mx*dx);
dfy = 1 / (My*dy);
fx = ((0 : 1 : Mx-1) - (Mx-1)/2)*dfx;
fy = ((0 : 1 : My-1) - (My-1)/2)*dfy;
[Fx, Fy] = meshgrid(fx, fy);

%% DIFFRACTION FIELD OF RECTANGULAR APERTURE

wx = [5e-3, 500e-6, 50e-6, 40e-6, 30e-6];
wy = [5e-3, 500e-6, 50e-6, 30e-6, 40e-6];
z = [0, 0.04, 0.08, 0.12];

for i=1:length(wx)
    figure(i)
    sgtitle(sprintf("wx=%d microns, wy=%d microns", wx(i)*1e6, wy(i)*1e6))
   for j=1:length(z)
       u = (abs(X) <= wx(i)/2) .* (abs(Y) <= wy(i)/2);
       U = FT2(u);
       H = exp(1j * 2*pi * z(j) * sqrt(1/(lambda^2) - Fx.^2 - Fy.^2));
       U_z = U .* H;
       u_z = IFT2(U_z);

       subplot(1, length(z), j)
       imagesc(x*1e3, y*1e3, abs(u_z))
       title(sprintf("z=%d cm", z(j)*1e2))
       colormap(gray)
       xlabel("mm")
       ylabel("mm")
   end
   colorbar
end
