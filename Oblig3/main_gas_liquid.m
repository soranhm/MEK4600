% function main_gas_liquid()
% Description:
%   (1) Calculate the chordal holdups from x-ray measurements based on
%   calibrations of two single-phase values
%   (2) Generate projection plots and holdup plot
%   (3) This is used for gas-water flow.
%
% Features:
%       
%   
% Notes:
%
% Author:
%   Bin Hu
%
% Revisions:
%
%--------------------------------------------------------------------------

%clear all;
clc;
clear all;
close all;
global flag_fluids;

%define fluid phases, 
%   gas-water       if flag_fluids = 1
%   gas-oil         if flag_fluids = 2
%   oil-water       if flag_fluids = 3
%   gas-oil-water   if flag_fluids = 4
flag_fluids = 1;
system_geometry;
nbeams = 32;
sample_rate = 100; % sampling rate, 1/sec.

%input parameters
ctPlotInterval = 1;
exp_file_name = 'gr4/case3_data.txt';

%compute the beam geometry for holdup calculations
area1 = beam_geometry(nbeams, 1);
area2 = beam_geometry(nbeams, 2);

%load calibrations
caliData = load('calibration_data.mat');
gas1softCal = caliData.unnamed1(1,:);
wat1softCal = caliData.unnamed1(2,:);
gas2softCal = caliData.unnamed1(3,:);
wat2softCal = caliData.unnamed1(4,:);

%load raw experimental data
expData = load(exp_file_name);
len_exp = length(expData);
interval = 1;

denom1 = log(gas1softCal./wat1softCal);
denom2 = log(gas2softCal./wat2softCal);

%loop to process the measured data
i = 1;
fprintf(1,'Computation progress:         ');

for k = 1: interval: len_exp
    dataI = expData(k, 5:end);
    expdataI = reshape(dataI, [nbeams 4])';
    cam1soft = expdataI(1,:);
    cam2soft = expdataI(3,:);

    % %convert exp data to holdup values
    % %compute the denominators, which are only functions of calibrations

    gas1x = max(0.0,min(1.0, log(cam1soft./wat1softCal)./denom1));
    gas2x = max(0.0,min(1.0, log(cam2soft./wat2softCal)./denom2));

    %store the holdup values at different time
    Tgas1x(i,:) = gas1x;
    Tgas2x(i,:) = gas2x;
    
    % compute cross-sectional averaged holdups at different time
    h_gas1x = dot(area1, gas1x);
    h_gas2x = dot(area2, gas2x);
    
    %store cross-sectional averaged holdups at different time
    h_gas1m(i) = h_gas1x;
    h_gas2m(i) = h_gas2x;
    
    %progressbar(k/kmax);
    i = i + 1;
    fprintf(1,'\b\b\b\b\b\b\b%6.2f%%',k/len_exp * 100);
end

fprintf('\n')

% %compute averaged phase holdups over the sampling time
gasholdup1 = mean(h_gas1m);
gasholdup2 = mean(h_gas2m);

%plot projections and holdup traces
[p_max, n] = size(Tgas1x);
[projection_plot HL_plot] = plot_projection(...
    Tgas1x,Tgas2x,1 - h_gas1m, 1 - h_gas2m,...
    gasholdup1, gasholdup2,...
    1,p_max-3,sample_rate,10);


% %save plot figures in Camera1 folder
% saveas(projection_plot,fullfile('test',[' tes-projection.tif']),'tiffn');
% saveas(HL_plot,fullfile(folder_name,[file_name_short '-liquid-holdup.tif']),'tiffn');

%Plot CTs
%xt3D = show_CT(Tgas1x, Tgas2x, ctPlotInterval);

%Plot 3D
	