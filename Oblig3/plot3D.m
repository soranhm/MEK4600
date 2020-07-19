
% Description:
%   Generate 3D plot from reconstructed tomgoraphs
%
% Features:
%   Apply isosurface to show the 3D contour
%
% Notes:
%   Can also use contour3?
%   To be improved
%
% Author:
%   Bin Hu
%
% Revisions:
%--------------------------------------------------------------------------


% NOTE RAHOF: Increase nb to get smoother plots!

clear xx3
len3D = length(xt3D);
np=nbeams;
for i = 1: np
    for j = 1:np
        for k = 1:len3D
            xx3(k,j,i) = 1 - xt3D(k,np - i +1,j);
        end
    end
end

% Find pixels outside pipe
[xgrid,ygrid]=meshgrid(1:np,1:np);
ind=(xgrid-np/2).^2+(ygrid-np/2).^2>=(0.95*np/2)^2;

% Set pixels outside pipe to zero
for k=1:len3D
    xx3(k,ind)=0;
end

figure;
[xgrid,ygrid,zgrid]=meshgrid(linspace(-1,1,np),1:len3D,linspace(1,-1,np));
isosurface(xgrid,ygrid,zgrid,xx3,0.95,'FaceColor','blue');
xlim([-1,1]);
ylim([0,len3D]);
zlim([-1,1]);
set(gca,'PlotBoxAspectRatioMode','Manual')
set(gca,'PlotBoxAspectRatio',[1 10 1])
ylabel('Frame number')
xlabel('Length')
zlabel('Height')
set(gcf,'Renderer','zbuffer')