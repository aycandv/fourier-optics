close all;
clc;

%% SETUP

lambda = 632.9e-9;

k = 2*pi/lambda;

theta = 0*pi/4;
psi = 0*pi/4;
kx = k * sin(theta);
kz = k * cos(theta);

c = 3e8;
f = c / lambda;
T = 1 / f;

dx = 10e-6;
dy = 10e-6;

Mx = 2048;
My = 2048;

x = ((0 : 1 : Mx-1) - (Mx-1)/2)*dx;
y = ((0 : 1 : My-1) - (My-1)/2)*dy;

[X, Y] = meshgrid(x, y);
Z = 0;

%% PART A

figure('Position', [0, 0, 1000, 200]);
sgtitle("Interference of 2 Point Sources with Different X-Position")

for i=0:100:400
    x1 = (i/2)*1e-6;
    y1 = 0.0e-6;
    z1 = -0.5;

    U1 = exp(1j * k .* sqrt((X - x1).^2 + (Y - y1).^2 + (Z - z1).^2));
    U1 = U1 ./ (max(abs(U1(:))));

    x2 = (-i/2)*1e-6;
    y2 = 0.0e-6;
    z2 = -0.5;

    U2 = exp(1j * k .* sqrt((X - x2).^2 + (Y - y2).^2 + (Z - z2).^2));
    U2 = U2 ./ (max(abs(U2(:))));

    super_position = real((abs(U1 + U2).^2));
    
    subplot(1,5, (i/100)+1);
    imagesc(x*1e3,y*1e3,super_position);
    colormap(gray)
    title(sprintf('X-Axis Separation = %i %sm', i, "\mu"));
    xlabel("mm")
    ylabel("mm")
end

%% PART B

figure('Position', [0, 0, 1000, 200]);
sgtitle("Interference of 2 Point Sources with Different Y-Position")

for i=0:100:400
    y1 = (i/2)*1e-6;
    x1 = 0.0e-6;
    z1 = -0.5;

    U1 = exp(1j * k .* sqrt((X - x1).^2 + (Y - y1).^2 + (Z - z1).^2));
    U1 = U1 ./ (max(abs(U1(:))));

    y2 = (-i/2)*1e-6;
    x2 = 0.0e-6;
    z2 = -0.5;

    U2 = exp(1j * k .* sqrt((X - x2).^2 + (Y - y2).^2 + (Z - z2).^2));
    U2 = U2 ./ (max(abs(U2(:))));

    super_position = real(abs(U1 + U2).^2);
    
    subplot(1,5, (i/100)+1);
    imagesc(x*1e3,y*1e3,super_position);
    colormap(gray)
    title(sprintf('Y-Axis Separation = %i %sm', i, "\mu"));
    xlabel("mm")
    ylabel("mm")
end

%% PART C

figure('Position', [0, 0, 1000, 200]);
sgtitle(sprintf("Interference of 2 Point Sources with %s & x=100 %sm", "y=x\timestan(\theta)", "\mu"))

for i=0:100:400
    theta = i/100*pi/4;
    
    x1 = 50e-6;
    y1 = x1 * tan(theta);
    z1 = -0.5;

    U1 = exp(1j * k .* sqrt((X - x1).^2 + (Y - y1).^2 + (Z - z1).^2));
    U1 = U1 ./ (max(abs(U1(:))));

    x2 = -50e-6;
    y2 = x2 * tan(theta);
    z2 = -0.5;

    U2 = exp(1j * k .* sqrt((X - x2).^2 + (Y - y2).^2 + (Z - z2).^2));
    U2 = U2 ./ (max(abs(U2(:))));

    super_position = real(abs(U1 + U2).^2);
    
    subplot(1,5, (i/100)+1);
    imagesc(x*1e3,y*1e3,super_position);
    colormap(gray)
    title(sprintf('%s = %i%s/4',"\theta", i/100, "\pi"));
    xlabel("mm")
    ylabel("mm")
end

%% PART D

figure('Position', [0, 0, 1000, 200]);
sgtitle(sprintf("Interference of 2 Point Sources with Different Z-Position"))

for i=-4:5
    
    x1 = 50e-6;
    y1 = 0;
    z1 = 5e-3 * i - 0.5;

    U1 = exp(1j * k .* sqrt((X - x1).^2 + (Y - y1).^2 + (Z - z1).^2));
    U1 = U1 ./ (max(abs(U1(:))));

    x2 = -50e-6;
    y2 = 0;
    z2 = -0.5;

    U2 = exp(1j * k .* sqrt((X - x2).^2 + (Y - y2).^2 + (Z - z2).^2));
    U2 = U2 ./ (max(abs(U2(:))));

    super_position = real(abs(U1 + U2).^2);
    
    subplot(2,5, i+5);
    imagesc(x*1e3,y*1e3,super_position);
    colormap(gray)
    title(sprintf('Z-Position Diff= %i mm',5 * i));
    xlabel("mm")
    ylabel("mm")
end