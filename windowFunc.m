function pass = windowFunc(graydata,phaseenh)
  pass = 0;
  part = 4;
  
  [sizey, sizex] = size(graydata);
  upper = graydata(1:floor(sizey/part),1:sizex);
  lower = graydata(1+floor(sizey/part):sizey,1:sizex);
  s_u = sizey/part*sizex;
  s_l = s_u*(part-1);
  
  sumup = sum(sum(upper,2));
  sumlow = sum(sum(lower,2));
  
  res1 = sumup/s_u;
  res2 = sumlow/s_l;
  
  ##res1 < 0.34, res2 > 0.76 && res2 < 0.85
  if(!((res1<0.5)&&(res2>0.76)&&(res2<0.85)))
    %%not face
    pass = 0;
    return
  endif
  
  %{
  figure(2)
  imshow(graydata*255)
  pause(0.3)
  %}
  
  %%STEP1通過
  leftEye = phaseenh(floor(3/8*sizey):floor(1/2*sizey),floor(sizex/8):floor(sizex/2));
  rightEye = phaseenh(floor(3/8*sizey):floor(1/2*sizey),floor(sizex/2):floor(sizex*7/8));
  [eyey, eyex] = size(leftEye);
  
  col = 1;
  row = 1;
  rate = floor(eyey/3);
  minleft = 10000;
  minright = 10000;
  s = 2*rate*rate;
  
  while((1*rate+row-1) < eyey)
    col = 1;
    while((2*rate+2*(col-1)) < eyex)
      sumLeftEye = sum(sum(leftEye(row:row+rate,2*(col-1)+1:2*(col-1)+2*rate),2));
      sumRightEye = sum(sum(rightEye(row:row+rate,2*(col-1)+1:2*(col-1)+2*rate),2));
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
  %minleft/s<0.20&&minright/s<0.20
  if(!((minleft/s<0.12)&&(minright/s<0.12)))
    pass = 0;
    return
  endif
  %res = [minleft/s,minright/s];
  %%STEP2通過
  nose = graydata(floor(3*sizey/8):floor(63*sizey/100),floor(19*sizex/50):floor(31*sizex/50));
  [nosey, nosex] = size(nose);
  nose_s = nosey*nosex;
 
  nose_sum = sum(sum(nose,2))/nose_s;
  %nose_sum < 0.8
  if(nose_sum < 0.82)
    pass = 0;
    return
  endif
  
  %%STEP3通過
  halfFaceUnd = phaseenh(floor(sizey/1.8):sizey*0.95,floor(sizex/4):floor(3*sizex/4));
  [halfFacey, halfFacex] = size(halfFaceUnd);
  
  %{
  figure(2)
  imshow(graydata*255)
  pause(0.5)
  %}
  
  row = 1;
  mouth_h = floor(halfFacey/12);
  min_mouth = 10000;
  s_mouth = mouth_h*halfFacex;
  step = mouth_h/2;
  
  while((step*row+mouth_h) <= halfFacey)
    sum_mouth = sum(sum(halfFaceUnd(1+floor(step*row):floor(step*row+mouth_h),1:halfFacex)));
    if(sum_mouth < min_mouth)
      min_mouth = sum_mouth;
    endif
    row = row+1;
  endwhile
  
  min_mouth/s_mouth
  if(min_mouth/s_mouth > 0.53)
    pass = 0;
    return
  endif
  
  result = min_mouth/s_mouth;
  
  pass = 1;
  return
  
endfunction
