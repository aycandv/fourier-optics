clear;
close all;


wavelength = 500e-9;
k = 2*pi/wavelength;
f = 20e-2;
R_lens = 0.5e-2;
R_g = 1e-3;

Mx = 2048;
My = 2048;

dx = 10e-6;
dy = 10e-6;

x = ((0 : 1 : Mx-1) - (Mx-1)/2)*dx;
y = ((0 : 1 : My-1) - (My-1)/2)*dy;
[X, Y] = meshgrid(x, y);

dfx = 1 / (Mx*dx);
fx = ((0 : 1 : Mx-1) - (Mx-1)/2)*dfx;
dfy = 1 / (My*dy);
fy = ((0 : 1 : My-1) - (My-1)/2)*dfy;
[Fx, Fy] = meshgrid(fx, fy);

image = imread("ImEx6.bmp");
image = im2double(image);

a = sqrt(X.^2 + Y.^2) < R_lens;
t_lens = a .* exp(-1j * k * sqrt(X.^2 + Y.^2 + f^2));

H = exp(1j * 2*pi * f * sqrt(1/(wavelength^2) - Fx.^2 - Fy.^2)); % free space propagation
G = 1;
G = sqrt(X.^2 + Y.^2) >= R_g;

u_i = image;
U_i = FT2(u_i);

u_L1 = IFT2(U_i .* H);
U_L1 = FT2(u_L1 .* t_lens);

u_f = IFT2(U_L1 .* H) .* G;
U_f = FT2(u_f);

u_L2 = IFT2(U_f .* H);
U_L2 = FT2(u_L2 .* t_lens);

u_o = IFT2(U_L2 .* H);
U_o = FT2(u_o);

figure
imshow(abs(u_i).^0.9)
figure
imshow(abs(u_L1).^0.9)
figure
imshow(abs(u_f).^0.9)
figure
imshow(abs(u_L2).^0.9)
figure
imshow(abs(u_o).^0.9)
