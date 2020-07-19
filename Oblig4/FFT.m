function [f,P1] = FFT(y,Fs)

Fs = Fs;            % Sampling frequency                    
L = length(y);         % Length of signal 
Y = fft(y);

P2 = abs(Y/L);
P1 = P2(1:floor(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:floor(L/2))/L;
