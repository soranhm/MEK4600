function [winSize,overlap,fftSize] = spectF(Fs)
% Window duration (in seconds):
dur = 0.5;
% Spectrogram settings (in samples):
winSize = round(Fs*dur);
overlap = round(winSize/2);
fftSize = winSize;
% Plot the spectrogram: