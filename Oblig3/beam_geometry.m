function area = beam_geometry(nbeams, camIndex)
% Description:
%   Compute the area fraction occupied by horizontal beams in the pipe,
%   holdup(i). The sum of holddup(i) is unity.
%
% Features:
%
% Notes:
%   Vertical beams are considered the same since they are orthogonally
%   identical
%
% Author:
%   Bin Hu
%
% Revisions:
%   2012-Feb-22   Created function
%--------------------------------------------------------------------------

%geometry
system_geometry;

%obtain non-dimensional geometry scaled with pipe radius, i.e. dia/2
r = dia/2;
rs = 1.0;
if(camIndex == 1)
    as = a1/r;
    bs = b1/r;
    cs = c1/r;   
else
    as = a2/r;
    bs = b2/r;
    cs = c2/r; 
end

dcs = cs/nbeams;
%compute the coordinates that beams cross inner pipe wall.
area = zeros(nbeams, 1);
holdup = zeros(nbeams+1, 1);

%compute the area fractions covered by each (or grouped) beam
for i = 1:nbeams+1
    
    if i< nbeams/2
        holdup(i) = 0;
    else
        holdup(i) = 1;
    end
    
    q = (i - nbeams/2 - 1.0)*dcs/(as + bs);
    w = as * (i - nbeams/2 - 1.0) * dcs/(as + bs);
    tmp = q^2*w^2 - (q^2 + 1)*(w^2 - 1);
    if (tmp >= 0)
        x1 = (-q*w- sqrt(tmp))/(q^2 + 1);
        y1 = x1*q + w;
        x2 = (-q*w+ sqrt(tmp))/(q^2 + 1);
        y2 = x2*q + w;
        len = sqrt(rs^2 - ((x1-x2)^2 + (y1-y2)^2)/4);

        if i< nbeams/2+1
            del = acos(len/rs);
        else
            del = pi - acos(len/rs);
        end

        holdup (i) = 1/pi * (del - cos(del)*sin(del));
    end
    
    if(i>1)
        area(i-1) = (holdup(i) - holdup(i-1));
    end
end

end