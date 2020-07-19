% imii = imread('all_images__00012841.jpg'); 
% figure(1); 
% imagesc(imii); 
% set(gca,'Ydir','normal') 
% h = impoly(); 
% mask = h.createMask();
%                
% for k=41:79
%   im1 = imread(sprintf('all_images__000128%d.jpg',k));
%   im2 = imread(sprintf('all_images__000128%d.jpg',k+1));
%   if(k==41)
%     opt1 = setpivopt('savepeaks',true,'range',[-20 20 -20 20],'subwindow',64,64,.50); 
%     opt2 = setpivopt('savepeaks',true,'range',[-10 10 -10 10],'subwindow',32,32,.50);
%     piv1 = normalpass([],im1,mask,im2,mask,opt1);
%     piv2 = normalpass(piv1,im1,mask,im2,mask,opt2);
%   else
%     piv1 = normalpass([],im1,mask,im2,mask,piv1);
%     piv2 = normalpass(piv1,im1,mask,im2,mask,piv2);
%   end
% end

[U1,V1,x1,y1] = replaceoutliers(piv1,mask);
[U2,V2,x2,y2] = replaceoutliers(piv2,mask);

[CURLZ, CAV]= curl(x1,y1,U1,V1);
[CURLZ2, CAV2]= curl(x2,y2,U2,V2);
figure;

% subplot(2,1,2) 
% contourf(x1,y1,CURLZ); title('vorticity: subwindow:64x64: range 20');
% hold on
% quiver(x1,y1,6*U1,6*V1,0); title('velocity: subwindow:64x64: range 20');

%subplot(2,1,1) 
contourf(x2,y2,CURLZ2,'linestyle','none'); title('vorticity: subwindow:32x32: range 10');
hold on
quiver(x2,y2,U2,V2); title('velocity: subwindow:32x32: range 10');
