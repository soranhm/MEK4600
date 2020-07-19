function [info,y,Fs] = soundf(Filename)
info = audioinfo(Filename);
[y,Fs] = audioread(Filename);
