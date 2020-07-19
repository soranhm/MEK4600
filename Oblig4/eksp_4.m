% eksperiment 4

% parametre
d = 0.006; % diameter i m


% legger inn data fra forsøk, runsa kommer pr rad
kg_ved_sekund(1,:) = [0 0.80 1.40 2.05 2.70]
sekund(1,:) = [0 10 20 30 40]
kg_ved_sekund(2,:) = [0.05 0.5 0.85 1.25 1.7]
sekund(2,:) = [0 10 20 30 40]
kg_ved_sekund(3,:) = 1e-3*[32 34 35.2 35.8 36.3]
sekund(3,:) = [0 10 20 30 40]
kg_ved_sekund(4,:) = 1e-3*[36 83 1036 186 234]
sekund(4,:) = [0 10 20 30 40]
kg_ved_sekund(5,:) = 1e-3*[41 72 91 111 131]
sekund(5,:) = [0 10 20 30 40]
kg_ved_sekund(6,:) = 1e-3*[42 93 147 200 257]
sekund(6,:) = [0 10 20 30 40]
kg_ved_sekund(7,:) = [0.2 0.5 0.85 1.15 1.45]
sekund(7,:) = [0 10 20 30 40]



[Re u] = Re_fra_liter(kg_ved_sekund,sekund,d)


