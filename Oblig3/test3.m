g = 9.81; D = 0.006;
ny = 10^-6;
Re = 2000:10:4000;
h = ((Re*ny)/D).^2 * (1/(2*g))
plot(Re,h)