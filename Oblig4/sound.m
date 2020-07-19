% %Run 2 , D = 12 mm
% [info,y,Fs] = soundf('uten_flow.wav');
% [info1,y1,Fs1] = soundf('re_23.wav');
% [info2,y2,Fs2] = soundf('re_471.wav');
% [info3,y3,Fs3] = soundf('re_6631.wav');
% [info4,y4,Fs4] = soundf('re_8754.wav');
% [info5,y5,Fs5] = soundf('re_14326.wav');
% 
% 
% % y = smooth(y);
% % y1 = smooth(y1);
% % y2 = smooth(y2);
% % y3 = smooth(y3);
% % y4 = smooth(y4);
% % y5 = smooth(y5);
% % % y = medfilt1(y);
% % % y1 = medfilt1(y1);
% % % y2 = medfilt1(y2);
% % 
% % %Signal plot
% % figure(1)
% % subplot(311);
% %t = 0:seconds(1/Fs):seconds(info.Duration);t = t(1:end-1);
% % plot(t,y)
% % legend('uten flow')
% % title('Signal plot')
% % subplot(312);
% % t1 = 0:seconds(1/Fs1):seconds(info1.Duration);t1 = t1(1:end-1);
% % plot(t1,y1)
% % legend('Re = 156')
% % subplot(313);
% % t2 = 0:seconds(1/Fs2):seconds(info2.Duration);t2 = t2(1:end-1);
% % plot(t2,y2)
% % legend('Re = 482')
% % xlabel('Time')
% % ylabel('Audio Signal')
% % figure(2)
% % subplot(311);
% % t3 = 0:seconds(1/Fs3):seconds(info3.Duration);t3 = t3(1:end-1);
% % plot(t3,y3)
% % legend('Re = 1713')
% % title('Signal plot')
% % subplot(312);
% % t4 = 0:seconds(1/Fs4):seconds(info4.Duration);t4 = t4(1:end-1);
% % plot(t4,y4)
% % legend('Re = 5562')
% % subplot(313);
% % t5 = 0:seconds(1/Fs5):seconds(info5.Duration);t5 = t5(1:end-1);
% % plot(t5,y5)
% % legend('Re = 7578')
% % xlabel('Time')
% % ylabel('Audio Signal')
% % 
% % FREQ MOT PSD
% % rng default
% % figure(2)
% [pxx,f] = pwelch(y,Fs);
% [pxx1,f1] = pwelch(y1,Fs1);
% [pxx2,f2] = pwelch(y2,Fs2);
% [pxx3,f3] = pwelch(y3,Fs3);
% [pxx4,f4] = pwelch(y4,Fs4);
% [pxx5,f5] = pwelch(y5,Fs5);
%loglog(f5,pxx5,f1,pxx1,f,pxx)

% p=polyfit(log(f5),log(pxx5),7);
% pxx51=polyval(p,f5);
% figure()
% plot(f5,pxx51)
%hold on
%loglog(f5,pxx5)
loglog(f5,pxx5,f4,pxx4,f3,pxx3,f2,pxx2,f1,pxx1,f,pxx)
% xlabel('Frequency (Hz)')
% ylabel('PSD (dB/Hz)')
% title('Power Spectral Density Estimates')
legend('Re = 14326','Re = 8754','Re = 6631','Re = 471','Re = 23','Re = 0')
% %legend('Re = 7578','Re = 5562','Re = 1713')
axis tight

%TID VS FREQ FARGE
% figure(3)
% subplot(311)
% [winSize,overlap,fftSize] = spectF(Fs);
% spectrogram(y,winSize,overlap,fftSize,Fs,'yaxis');
% title('frekvens plot, med Re = 0, Re = 156 og Re = 482')  
% ylim([0 10])
% subplot(312)
% [winSize1,overlap1,fftSize1] = spectF(Fs1);
% spectrogram(y1,winSize1,overlap1,fftSize1,Fs1,'yaxis');
% ylim([0 10])
% subplot(313)
% [winSize2,overlap2,fftSize2] = spectF(Fs2);
% spectrogram(y2,winSize2,overlap2,fftSize2,Fs2,'yaxis');
% ylim([0 10])
% figure(4)
% subplot(311)
% [winSize3,overlap3,fftSize3] = spectF(Fs3);
% spectrogram(y3,winSize3,overlap3,fftSize3,Fs3,'yaxis');
% title('frekvens plot, med Re = 1713, Re = 5562 og Re = 7578') 
% ylim([0 10])
% subplot(312)
% [winSize4,overlap4,fftSize4] = spectF(Fs4);
% spectrogram(y4,winSize4,overlap4,fftSize4,Fs4,'yaxis');
% ylim([0 10])
% subplot(313)
% [winSize5,overlap5,fftSize5] = spectF(Fs5);
% spectrogram(y5,winSize5,overlap5,fftSize5,Fs5,'yaxis');
% ylim([0 10])