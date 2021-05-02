clear;
close all;

%% SETUP

lambda = 632.9e-9;
k = 2*pi/lambda;

Mx = 2^20;

dx = 200e-9;
x = ((0 : 1 : Mx-1) - (Mx-1)/2)*dx;

dfx = 1 / (Mx*dx);
fx = ((0 : 1 : Mx-1) - (Mx-1)/2)*dfx;

z = [0.025, 0.05, 0.075, 0.1];
wx = [10e-6, 5e-6, 2e-6];
colors = ["#0072BD", "#D95319", "#EDB120", "#7E2F8E"];
legends = cell(1,length(z));

for i=1:length(wx)
    figure(i)
   for j=1:length(z)
       u = (abs(x) <= wx(i)/2);
       U = FT2(u);
       H = exp(1j * 2*pi * z(j) * sqrt(1/(lambda^2) - fx.^2));
       U_z = U .* H;
       u_z = IFT2(U_z);

       plot(x, abs(u_z), color=colors(j))
       title(sprintf("w = %d um", wx(i)*1e6));
       legends{j} = sprintf("z=%f", z(j));
       hold on
   end
   legend(legends)
   xlim([-0.1 0.1])
end
