function [x,y] = raster(imdata,rgb,rectWidth,rectHeight,figNum)
  %imdataがrbgのとき、sizeyがgrayの三倍になるため注意。
  [sizex,sizey] = size(imdata)
  stepWid = rectWidth/10;
  stepNum = (sizex/rectWidth-1)*10;
  row = 0;
  
  figure(figNum);
  imshow(rgb);
  hold on;
  
  while ((stepWid*(row)+rectHeight) < sizey)
    for col = 0:stepNum
      h = rectangle ("Position", [0+stepWid*col, 0+stepWid*row, rectWidth, rectHeight], "Curvature", [0.1, 0.2]);
      hold on;
    endfor
    row+=1;
    %stepWid*(row+1)+rectHeight
  endwhile
  %{
  for col = 0:stepNum
    h = rectangle ("Position", [0+stepWid*col, 0, rectWidth, rectHeight], "Curvature", [0.1, 0.2]);
    hold on;
  endfor
  %}
  
  x = [123,0];
  y = [456,1];
endfunction
