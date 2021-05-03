clear;
close all;


wavelength = 500e-9;
k = 2*pi/wavelength;
f = 20e-2;
R_lens = 0.5e-2;
R_g = 1e-3;

Mx = 2048;
My = 2048;

dx = 2e-6;
dy = 2e-6;

x = ((0 : 1 : Mx-1) - (Mx-1)/2)*dx;
y = ((0 : 1 : My-1) - (My-1)/2)*dy;
[X, Y] = meshgrid(x, y);

dfx = 1 / (Mx*dx);
fx = ((0 : 1 : Mx-1) - (Mx-1)/2)*dfx;
dfy = 1 / (My*dy);
fy = ((0 : 1 : My-1) - (My-1)/2)*dfy;
[Fx, Fy] = meshgrid(fx, fy);

image = imread("lena.png");
image = sqrt(im2double(image));
U_o = padarray(image, [512, 512], 0, "both");
phi = 0;
U_o = U_o .* exp(1j * phi);

R = 1e-3;
xc = [0.1e-3, 0.4e-3, 0.7e-3, 1e-3];

for i=1:length(xc)
    p = sqrt((X - xc(i)).^2 + Y.^2) < R;
    H_coh = p;
    I_coh = abs(IFT2(FT2(U_o) .* H_coh)).^2;

    figure(1)
    subplot(1, length(xc), i)
    imshow(I_coh)

    H_inc = IFT2(abs(FT2(H_coh)).^2);
    I_inc = IFT2(FT2(abs(U_o).^2) .* H_inc);

    figure(2)
    subplot(1, length(xc), i)
    imshow(abs(I_inc))
end

