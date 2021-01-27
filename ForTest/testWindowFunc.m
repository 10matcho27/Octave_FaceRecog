clear all;
close all;

im0 = imread("sample0.jpg");
gray0 = rgb2gray(im0);
gray0 = regionSegment(gray0,113);

%%10000にはimdataのphaseかけたファイルを渡す。
windowFunc(im0,10000,0,0);
