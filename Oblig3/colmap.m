function [cmap] = colmap()
% Description:
%   Define a color map for x-ray system
%
% Features:
%   Recommended color scheme: oil-red, gas-green, water-blue
%   50-50% mixing of either two-phase is set to white
%
% Notes:
%   The colors are based on RGB 
%
% Author:
%   Bin Hu
%
% Revisions:
%   2012-Feb-22   Created function
%   2012-Apr-23   Added water phase
%   2012-Jun-28   Added global variable, flag_fluids
%--------------------------------------------------------------------------

global flag_fluids

gas = [0 1 0];
oil = [1 0 0];
wat = [0 0 1];
mix = [1 1 1];

ncolor = 50;

%allocate colors to phase 1 and 2
if flag_fluids == 1                 %gas-water
    phase1 = gas;
    phase2 = wat;
elseif flag_fluids == 2             %gas-oil
    phase1 = gas;
    phase2 = oil;    
elseif flag_fluids == 3             %oil-water
    phase1 = oil;
    phase2 = wat;       
elseif flag_fluids == 4             %gas-oil-water
    phase1 = gas;
    phase2 = oil; 
    phase3 = wat; 
end

if(flag_fluids ~= 4)
    for i = 1: ncolor
        cmap(i,:) = phase2 + (mix - phase2)/ncolor*i;
    end

    for i = ncolor + 1: 2*ncolor 
        cmap(i,:) = mix + (phase1 - mix)/ncolor*(i - ncolor);
    end
end

end
