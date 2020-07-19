subplot(2,2,1);
cdfplot(Law1)
hold on
cdfplot(Law2)
cdfplot(Law3)
legend('Law1','Law2','Law3')

subplot(2,2,2);
histogram(Law1)
legend('Law1')

subplot(2,2,3);
histogram(Law2)
legend('Law2')

subplot(2,2,4);
histogram(Law3)
legend('Law3')
