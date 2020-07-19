% Description:
%   (1) Generate tomographs from the holdups measured by the horizontal and
%   vertical x-ray beams
%
% Features:
%
% Notes:
%
% Author:
%   Bin Hu
%
% Revisions:
%--------------------------------------------------------------------------
function xt3D = show_CT (b1, b2, dn)

%save tomographs to files if isave_tif = 1
isave_tif = 0;

%define if show the tomograph on the screen, yes if ishow_CT = 1 
ishow_CT = 1;

%define figure properties
np = 32;
fig_position = [250 250 500 500];
aspratio = [1 1 1]; %define aspect ratio
fs = 12;     % define font size
fslabel = 14; % define font size for labels
clims = [0,1];

%declare values for stack view
sample_frequency = 100; %fps
data_rate = sample_frequency/dn;
tick_interval = 1;
kx = np/2;
ky = np/2;
%--------------------------------------------------------------------------
%define iteration boundaries
nl = length(b1);
n1 = 1;
n2 = nl;

senseMap = load('inverseA.txt');
xcenter_node = load('xCenter.txt');
ycenter_node = load('yCenter.txt');

%for 3D plot
xt3D = zeros(floor((n2-n1+1)/dn),np,np);
i3D = 1; %index for 3D storage matrix

%progress print
fprintf(1,'Plotting CT progress:         ');
hold off;

%iterate for tomograph plot
for i = n1: dn: n2
    %get measurement values
    b = [fliplr(b2(i,:)) b1(i,:)];

    %compute tomograph
    xlist = senseMap*b';

    for k = 1:length(xlist)
        xlist(k) = max(0.0, min(1.0,xlist(k)));
    end

    xt=reshape(xlist,np,np)';

    %store matrix for 3D plot
    xt3D(i3D, :, :) = xt;
    i3D = i3D + 1;

    %plot tomographs
    if i == n1

        %generate concentration data matrix
        kk = 1:1:np;
        xx = 2*(kk-1)/(np-1)-1;
        yy = 2*(np-kk)/(np-1)-1;

        %interpolate to make smoother plots
        [xi,yi] = meshgrid(-1:0.01:1);
        xt2 = interp2(xx,yy,xt,xi,yi,'bilinear');

        %figure;
        if ishow_CT == 1
            set(gcf, 'Visible', 'on');
        end
        set(gcf, 'Position', fig_position);
%        hfig = imagesc(xi(1,:),yi(:,1),xt2,clims); 
        [cc hfig] = contourf(xcenter_node,ycenter_node,xt); 

        set(gca,'PlotBoxAspectRatio',aspratio);
        %set(gca,'YDir','normal')

        %specify color map
        colormap(colmap());
        set(hfig,'LevelList',0:0.01:1, 'LineStyle','none')
        caxis([0 1]);
        %colorbar;

        hold on
        axis off
        axis equal

        %plot pipe edge and background
        dt=0.02;
        ns = 200;
        t = (0:1/ns:1)*2*pi;
        r = 0.95;
        x = r*cos(t);
        y = r*sin(t);
        dxy = 1.08;
        sqx = [dxy,dxy,-dxy,-dxy,dxy,dxy];
        sqy = [0,dxy,dxy,-dxy,-dxy,0];
        fill([x sqx],[y sqy],'w','LineStyle','none');
        
        %plot pipe
        plot(x,y,'LineWidth',5,'Color',[0.3,0.3,0.3]);

        %insert text for figure indices
        htxt = text(0.75,0.9,sprintf('%05i',i));
 
        %make the output directory
        output_folder = pwd;
        if ~isdir(output_folder)
            mkdir(output_folder);
        end

    else
%         xt2 = interp2(xx,yy,xt,xi,yi,'bilinear');
        set(hfig,'ZData',xt);
        set(htxt,'String',sprintf('%05i',i));
        refreshdata;
    end
    
    pause(0.01);
    
    if isave_tif == 1
        %saveas(gcf,fullfile(pwd,['t_', sprintf('%05i',i), '.tif']),'tiffn');
        saveas(gcf,fullfile(pwd,['CT_', sprintf('%05i',i), '.tif']),'tif');
    end
    
    fprintf(1,'\b\b\b\b\b\b\b%6.2f%%',i/n2 * 100);
    
end

fprintf('\n')
hold off;

end