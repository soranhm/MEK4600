% %CASE 1
% k = 1:10:400;
% g = 9.81; h = 0.06;
% w = sqrt(g*k.*tanh(k.*h));
% figure(1)
% plot(k,w)
% hold on
% plot(k(27),w(27), 'r*')
% xlabel('k')
% ylabel('w')
% title('Finner k, naar w = 50')

%CASE 2
% sigma = 0.074;
% rho = 1000;
% g = 9.81;
% h = 0.056
% k2 = 1;
% omg = 25
% sos = ((g * k2 + (sigma/rho)*k2^3)*tanh(k2*h)) - omg^2
% sos2 = ((g * k2 + (sigma/rho)*k2^3)*tanh(k2*h)) - omg^2
% while 1
%     if (sos * sos2) < 0
%         break
%     end
%     sos = ((g * k2 + (sigma/rho)*k2^3)*tanh(k2*h)) - omg^2
%     k2 = k2 + 0.1;
%     sos2 = ((g * k2 + (sigma/rho)*k2^3)*tanh(k2*h)) - omg^2
% end
% k = k2
% 
% h = 0.056;
% sigma = 0.074;
% rho = 1000;
% k = 1:1:200;
% g = 9.81;
% omg2 = sqrt((g*k+(sigma/rho)*k.^3).*tanh(k.*h));
% plot(k,omg2)
% hold on
% plot(k(63),omg2(63), 'r*')
% xlabel('k')
% ylabel('w')
% title('Finner k, naar w = 25')

[f,P1] = FFT(f,Fs)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
ylim([0 0.016])
