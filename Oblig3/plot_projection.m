function [projection_plot, holdup_plot] = plot_projection(Tgas1, Tgas2, ...
    h_gas1m, h_gas2m, gasholdup1, gasholdup2,...
    a, b, sample_rate, tick_interval)
% Description:
%   Generate projection plots and holdup plot
%
% Features:
%   a and b are the min and max values for x-axis
%
% Notes:
%   Since it is a two-phase algorithm, variables 'gas' are used to describe
%   the light phase.
% Author:
%   Bin Hu
%
% Revisions:
%--------------------------------------------------------------------------

close all;

%obtain fluid information
global flag_fluids

%define whether to display the images (1). For faster speed, set it to 0
ivisible = 1;

Tgas1x = Tgas1(a:b,:);
Tgas2x = Tgas2(a:b,:);
h_gas1mx = h_gas1m (a:b);
h_gas2mx = h_gas2m (a:b);
%sample_rate = 5; % sample per second
%tick_interval = 2; % second between adjacent ticks

aspratio = [7 1 1]; %define aspect ratio
d = 0.06; % define margines
fs = 12;     % define font size
fslabel = 14; % define font size for labels
xlabeltxt = 'Time, s';
ylabeltxt = 'r/R, -';

if(ivisible == 0)
    projection_plot = figure('Visible', 'off');
else
    projection_plot = figure;    
end

fig_position = [150 150 1000 500];

%subplot 1 for cam1
s1 = subplot(2,1,1);
imagesc(Tgas1x');
set(gca,'PlotBoxAspectRatio',aspratio);
%colorbar;
colormap(colmap());
caxis([0 1]);

%labels
xlabel(xlabeltxt);
h_xlabel = get(gca,'XLabel');
set(h_xlabel,'FontSize',fslabel); 

ylabel(ylabeltxt);
h_ylabel = get(gca,'YLabel');
set(h_ylabel,'FontSize',fslabel); 

%re-scale labels
[nx ny] = size(Tgas1x);
xlab = 1 : sample_rate * tick_interval: nx;
xticktxt = 0 :tick_interval: floor(nx/sample_rate);
ylab = 1 : (ny-1)/2: ny;
yticktxt = 1: -1: -1;

set(gca,'XTick',xlab);
set(gca,'XTickLabel',xticktxt);
set(gca,'YTick',ylab);
set(gca,'YTickLabel',yticktxt);

%subplot 2 for cam2
s2 = subplot(2,1,2);
imagesc(Tgas2x');
set(gca,'PlotBoxAspectRatio',aspratio);
%colorbar;
colormap(colmap());
caxis([0 1]);

set(gcf, 'Position', fig_position);

%labels
xlabel(xlabeltxt);
h_xlabel = get(gca,'XLabel');
set(h_xlabel,'FontSize',fslabel); 

ylabel(ylabeltxt);
h_ylabel = get(gca,'YLabel');
set(h_ylabel,'FontSize',fslabel); 

%re-scale labels
[nx ny] = size(Tgas2x);
xlab = 1 : sample_rate * tick_interval: nx;
xticktxt = 0 :tick_interval: floor(nx/sample_rate);
ylab = 1 : (ny-1)/2: ny;
yticktxt = 1: -1: -1;

set(gca,'XTick',xlab);
set(gca,'XTickLabel',xticktxt);
set(gca,'YTick',ylab);
set(gca,'YTickLabel',yticktxt);

%poistion and font
set(s1,'position',[d 0.5+d 1-2*d 0.5-2*d]);
set(s2,'position',[d 2*d 1-2*d 0.5-2*d]);
set([s1 s2],'FontSize',fs);

%holdup traces plot
if(ivisible == 0)
    holdup_plot = figure('Visible', 'off');
else
    holdup_plot = figure;    
end

plot(a:b,h_gas1mx,'b',a:b,h_gas2mx,'r');
set(gcf, 'Position', [150,600,1000,300]);
set(gca,'FontSize',fs,'PlotBoxAspectRatio',aspratio,'XTick',xlab,'XTickLabel',xticktxt);
xlabel('Time, sec','FontSize',fslabel);
%ylabel('HL, -','FontSize',fslabel);
ylim([0,1]);

set(gca,'position',[1.5*d 1*d 1-2*d 1-1.5*d]);

if flag_fluids == 1                 %gas-water flow
    ylabel('HW, -','FontSize',fslabel);
    legend(['HW-Cam1 =' num2str(1-gasholdup1)],['HW-Cam2 =' num2str(1-gasholdup2)],...
    'Location','NorthOutside','Orientation','horizontal');
elseif flag_fluids == 2             %gas-oil flow
    ylabel('HO, -','FontSize',fslabel);
    legend(['HO-Cam1 =' num2str(1-gasholdup1)],['HO-Cam2 =' num2str(1-gasholdup2)],...
    'Location','NorthOutside','Orientation','horizontal');
elseif flag_fluids == 3              %oil-water flow
    ylabel('HW, -','FontSize',fslabel);
    legend(['HW-Cam1 =' num2str(1-gasholdup1)],['HW-Cam2 =' num2str(1-gasholdup2)],...
    'Location','NorthOutside','Orientation','horizontal');
end

end
