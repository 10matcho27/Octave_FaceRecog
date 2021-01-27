close all;
clear all;
%--settings--
threshold = 113;
height = 1.40;
width = 1;

%--read image--
rgb = imread("sample6.jpg");

%RGB to Gray and region segment
gray = rgb2gray(rgb);
gray = regionSegment(gray,threshold);
figure(1)
imshow(gray)


[sizey, sizex] = size(gray)
rate = sizey/height/3;

figNum = 2
[x,y] = raster(gray,rgb,width*rate,height*rate,figNum)

