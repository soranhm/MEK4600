function [Re u] = Re_fra_liter(kg_ved_sekund,sekund,d)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% parametre
g = 9.81; % m/s2
ny = 1e-6; % m2/s
% d = 0.006; % diameter i m
rho = 1000; % tetthet i kg/m3
areal = pi*(d/2).^2;


for rad_loop = 1:size(kg_ved_sekund,1)
    for kolonne_loop = 1:(size(kg_ved_sekund,2)-1)
        F(rad_loop,kolonne_loop) = (kg_ved_sekund(rad_loop,kolonne_loop+1)-kg_ved_sekund(rad_loop,kolonne_loop))/(sekund(rad_loop,kolonne_loop+1)-sekund(rad_loop,kolonne_loop));
    end
end
    
massefluksrate = mean(F,2); % liter pr sek
fluksrate = massefluksrate/rho; % i m^3/s
fluksrate_liter = 1000*fluksrate;

u = fluksrate/areal; % i m/s
Re = u*d/ny;




end

