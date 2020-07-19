% Filtrer ut st?y og plotter mot tid
[b,a] = butter(2,0.01);
%Run 2 , D = 12 mm
[info,y,Fs] =  soundf('run2/uten_flow.wav');
[info1,y1,Fs1] = soundf('run2/re_263.wav');
[info2,y2,Fs2] = soundf('run2/re_366.wav');
[info3,y3,Fs3] = soundf('run2/re_1713.wav');
[info4,y4,Fs4] = soundf('run2/re_3056.wav');
[info5,y5,Fs5] = soundf('run2/re_10478.wav');
 

yut = y2 - y;
%yf= filter(b,a,y2);
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);
plot(t,y)
% figure(1)
% subplot(311)
% plot(t,y,'r')
% subplot(312)
% plot(t,y2,'b')
% subplot(313)
% plot(t,yut,'g')

% figure(2)
% [f,P1] = FFT(y,Fs);
% plot(f,P1) 
% hold on
% [f3,P3] = FFT(y3,Fs3);
% plot(f3,P3) 
% size(P3)
% size(P1)
% plot((f3(1:669313) - f(1:669313)),(P1(1:669313)-P3(1:669313)))
% %legend('utenflow','med re 1713')  
% ylim([0 0.006])
% xlim([0 100])