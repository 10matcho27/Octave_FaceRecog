function undefine = raster(imdata,graydata,phaseenh,rate,height)
  [sizey, sizex] = size(graydata);
  rectWidth = rate; rectHeight = height*rate;
  precision = 10;
  stepWid = rectWidth/precision;
  stepNum = (sizex/rectWidth-1)*precision;
  row = 0; col = 0;
  pass = 0;
  pass_r = 0;
 
  
  while((round(stepWid*row)+round(rectHeight)+1) < sizey)
    while((round(stepWid*col)+round(rectWidth)+1) < sizex)
      graydataP = graydata(round(stepWid*row)+1:round(stepWid*row)+round(rectHeight),round(stepWid*col)+1:round(stepWid*col)+round(rectWidth));
      phaseenhP = phaseenh(round(stepWid*row)+1:round(stepWid*row)+round(rectHeight),round(stepWid*col)+1:round(stepWid*col)+round(rectWidth));
      pass = windowFunc(graydataP,phaseenhP);
      
      %{
      if(rate>70)
        h = rectangle ("Position", [round(stepWid*col), round(stepWid*row), round(rectWidth), round(rectHeight)], "Curvature", [0.1, 0.2], "EdgeColor", "g");
      endif
      %}
      
      if(pass == 1)
        h = rectangle ("Position", [round(stepWid*col), round(stepWid*row), round(rectWidth), round(rectHeight)], "Curvature", [0.1, 0.2], "EdgeColor", "r", "LineWidth",3);
        col = col + precision*20;
        hold on;
        pass_r = 1;
      endif
      col += 1;
    endwhile
    if(pass_r == 1)
      row = row + precision*20;
      pass_r = 0;
      pass = 0;
    endif
    row += 1;
    col = 0;
  endwhile
endfunction
