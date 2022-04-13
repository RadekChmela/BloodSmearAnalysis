clear all; close all; clc
im= im2double(imread('image-23.png'));
figure 
imshow (im)
im_r=im(:,:,1);
im_g=im(:,:,2);
im_b=im(:,:,3);

%% multithresh
image= im_r-im_b;
prahy= multithresh(image,3);
t= imquantize(image,prahy);
rgb=label2rgb(t);
figure
imshow(t,[])
figure
imshow(rgb)
red=rgb(:,:,1);
green=rgb(:,:,2);
blue=rgb(:,:,3);
figure
subplot 311
imshow(red)
subplot 312
imshow(green)
subplot 313
imshow(blue)
%%

bw=1-green;

rozodi=watershed(bw);
negativ=1-bw;
mapa=bwdist(negativ);
mapa=-mapa;
mapa(mapa==0)=-Inf;
bw2=watershed(mapa);

figure
subplot(141)
imshow(bw,[])
title('Puvodní obrazek')
subplot(142)
mesh(bwdist(1-bw))
title('Distanční mapai')
subplot(143)
mesh(mapa)
title('upravená distanční mapa')
subplot(144)
imshow(label2rgb(bw2),[])
title('Segmentace obrazu')
%%
img4 = activecontour(green, bw ,200, 'Chan-Vese'); hold on
visboundaries(img4); 

figure
imshow(labeloverlay(im, img4));