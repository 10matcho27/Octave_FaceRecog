function res = windowFunc(imdata,imdata_phase,windWidth,windHeight)
  %第一段階髪の毛rgbからgray(領域分割後)に変換したものを利用。
  part = 4;
  res = [0,0];
  %imshow(imdata);
  imdata = rgb2gray(imdata);
  imdata = regionSegment(imdata,113);
  imshow(imdata);
  hold on;
  
  %%test用データ
  startx = 45;
  wid = 110-startx;
  starty = 30;
  windWidth = wid;
  windHeight = wid*1.4;
  %%%%%%%%%%%%%
  
  h = rectangle ("Position", [startx, starty, wid, wid*1.4], "Curvature", [0.1, 0.2], "EdgeColor", "r");

  
  %testとして上から顔の縦長1/3のところまでの画素値合計と残り領域の画素値合計の割合を見る。
  wind = imdata(starty:starty+wid*1.4-1,startx:startx+wid-1)/255;
  [sizewy,sizewx]=size(wind);
  
  wind1_3upper = wind(1:floor(sizewy/part),1:sizewx);
  wind1_3lower = wind(floor(sizewy/part)+1:sizewy,1:sizewx);
  s_u = sizewy/part*sizewx;
  s_l = s_u*(part-1);

  %枠内の1の個数
  sumup = sum(sum(wind1_3upper,2))
  sumlow = sum(sum(wind1_3lower,2))
  
  res1 = sumup/s_u
  res2 = sumlow/s_l
  
  %0<res1<0.335?, 0.6?<res2
  
  if(res1>0.335||res2<0.6)
    %%not face
    res = 0
    return
  endif
  
  %%Step1通過
  %%phase()は
  winda = phase(wind*255);
  %imdata = phase(imdata)/255;
  windLeftEye = winda(floor(3/8*windHeight):floor(1/2*windHeight),floor(windWidth/8):floor(windWidth/2))/255;
  windRightEye = winda(floor(3/8*windHeight):floor(1/2*windHeight),floor(windWidth/2):floor(windWidth*7/8))/255;
  [eyey,eyex] = size(windLeftEye)
  
  %{
  figure(3)
  imshow(windRightEye*255);
  hold on;
  h = rectangle ("Position", [7, 4.5, 2*5, 1*5], "Curvature", [0.1, 0.2], "EdgeColor", "r");
  %}
  
  %%%%%%%%%%%%%%%%raster%%%%%%%%%%%%%%%%
  col = 1;
  row = 1;
  rate = floor(eyey/3)
  minleft = 10000;
  minright = 10000;
  s = 2*rate*rate;
  
  figure(3)
  imshow(windRightEye*255);
  hold on;
  
  while((1*rate+row-1) < eyey)
    col = 1;
    while((2*rate+2*(col-1)) < eyex)
      sumLeftEye = sum(sum(windLeftEye(row:row+rate,2*(col-1)+1:2*(col-1)+2*rate),2));
      sumRightEye = sum(sum(windRightEye(row:row+rate,2*(col-1)+1:2*(col-1)+2*rate),2));
      h = rectangle ("Position", [2*(col-1)+1, row, 2*rate, 1*rate], "Curvature", [0.1, 0.2], "EdgeColor", "r");
      hold on;
      if(sumLeftEye < minleft)
        minleft = sumLeftEye;
      endif
      if(sumRightEye < minright)
        minright = sumRightEye;
      endif
      col = col+1;
    endwhile
    row=row+1;
  endwhile
  minleft/s
  minright/s
  if(!((minleft/s<0.20)&&(minright/s<0.20)))
    res = 0;
    return
  endif
  
  %%Step2目通過
  %%鼻頭の判定
  figure(4)
  imshow(wind*255);
  figure(6)
  imshow(winda);
  
  %%sizewy,sizewxがwindのx,yのサイズ
  %{
  nose = wind(floor(3*sizewy/8):floor(5*sizewy/8),floor(3*sizewx/8):floor(5*sizewx/8));
  [x,y] = size(nose)
  s = x*y;
  imshow(nose)
  nose1 = sum(sum(nose/255,2))/s
  %}
  nose = wind(floor(3*sizewy/8):floor(63*sizewy/100),floor(19*sizewx/50):floor(31*sizewx/50))
  [y,x] = size(nose);
  s = x*y;
  figure(5)
  imshow(nose*255)
  nose2 = sum(sum(nose,2))/s

  
  res = 1;
  return
  
endfunction
