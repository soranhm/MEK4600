im1 = imread('imA.png'); 
im2 = imread('imB.png');

opt = setpivopt('range',[-8 8 -8 8],'subwindow',24,24,.50); 
piv = normalpass([],im1,[],im2,[],opt);

figure; scale = 5;

quiver(piv.x,piv.y,scale*piv.U,scale*piv.V,0);