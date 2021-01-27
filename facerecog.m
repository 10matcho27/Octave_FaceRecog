%--settings--
threshold = 113;
height = 1.8;
width = 1;
partition = 5;
num = 0;
%precision = 3;
%小さいほど高精度

%--read image--
imdata = imread("sample5.jpg");

%RGB to Gray and region segment
graydata = rgb2gray(imdata);
graydata = regionSegment(graydata,threshold);

phaseenh = phase(graydata);

[sizey, sizex] = size(imdata);
rate = sizey/height/partition;
precision = 4*rate/24;

figure(1)
imshow(imdata);
%for debug
%imshow(graydata);
hold on;
  

while((rate+precision)*height<sizey)
  rate = rate+precision;
  raster(imdata,graydata/255,phaseenh/255,rate,height);
  if(rate*height>sizey)
    break
  endif
endwhile

