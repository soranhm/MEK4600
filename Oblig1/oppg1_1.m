coord = imread('mpwoco.bmp');
imagesc(coord)

%Select reference points in pixel coordinate            
h=impoly;
pixel = h.getPosition;

% Define matching reference points in world coordinate
world = [20 -10; 15 -10; 10 -10;5 -10;0 -10;20 -5; 15 -5;10 -5; 5 -5; 0 -5]/100;

%MASKING
im1 = imread('mpim1b.bmp'); 
im2 = imread('mpim1c.bmp');

opt = setpivopt('range',[-20 20 -20 20],'subwindow',64,64,.50);
piv = normalpass([],im1,[],im2,[],opt);
[U,V,x,y] = replaceoutliers(piv);

% create a polygonal mask 
figure(1); 
imagesc(im1); 
set(gca,'Ydir','normal') 
h = impoly(); 
mask = h.createMask();
               
figure(2);
scale = 5
quiver(x,y,scale*U,scale*V)
title('Outlier replacement (50% overlap), with windows 64x64');

% Create coordinate transformation
[tform,err,errinv] = createcoordsystem(pixel,world,'linear')

dt = 0.012; %s
[U4,V4,x,y] = replaceoutliers(piv,mask);
[Uw,Vw,xw,yw] = pixel2world(tform,U4,V4,x,y,dt);

% Surface
[idx1,eta1] = max(mask);
%[idx2,eta2] = max(mask2);
[etax,etay] = tformfwd(tform,1:1280,eta1);
figure;
quiver(xw,yw,Uw,Vw);
hold on;
plot(etax,etay,'r');
hold off;
xlabel(' x [ m ] ');
ylabel(' y [ m ] ');

k = 7.95; a = 0.0205; omg = 8.95;
crest_indeks = 26; % Column at crest

figure;
subplot(2,1,1)    
plot(a*omg*exp(k*yw(:,crest_indeks)),yw(:,crest_indeks))
xlabel(' U [ m ] ');
ylabel(' y [ m ] ');
hold on
plot(abs(Uw(:,crest_indeks)),yw(:,crest_indeks),'*')
title('Analytiske mot numeriske ved x\_crest (64x64)');
legend('Eksprimentelt','Numerisk')

subplot(2,1,2) 
plot(abs(Uw(:,crest_indeks)/(a*omg)),k*yw(:,crest_indeks),'*')
hold on
plot(exp(k*yw(:,crest_indeks)),k*yw(:,crest_indeks))
title('Analytiske mot numeriske skalering ved x\_crest (64x64)')
legend('numerisk','Eksprimentelt')