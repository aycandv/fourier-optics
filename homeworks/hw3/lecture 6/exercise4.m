clear;
close all;


Mx = 1024;
My = 1024;

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

P = [64, 16, 4, 1];
R = 0.05e-3;

for i=1:length(P)
    image = imread("lena.png");
    image = sqrt(im2double(image));
    image = image(:,:,1);
    num_of_sections = 1024 / P(i);
    for j=1:2:num_of_sections
        image(:, P(i)*j:P(i)*(j+1)-1) = 0;
    end
    
    p = sqrt(X.^2 + Y.^2) < R;
    phi = 0;
    H_coh = p;

    H_inc = IFT2(abs(FT2(H_coh)).^2);
    I_inc = IFT2(FT2(abs(image).^2) .* H_inc);

    figure(2)
    subplot(1, length(P), i)
    imshow(abs(I_inc))
end

