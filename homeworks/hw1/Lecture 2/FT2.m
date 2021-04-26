function output=FT2(input)
M=size(input,1);
N=size(input,2);
t=exp(1i*pi*(M-1)/M*transpose([0:1:M-1]))*exp(1i*pi*(N-1)/N*[0:1:N-1]);
output=(1/(M*N)^0.5*exp(-1i*pi*(M-1)^2/(2*M))*exp(-1i*pi*(N-1)^2/(2*N)))*t.*fft2(input.*t);