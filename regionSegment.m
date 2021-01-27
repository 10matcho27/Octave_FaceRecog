function image = regionSegment(imdata,threshold)
  [sizex,sizey] = size(imdata);
  for col = 1:sizey
    for row = 1:sizex
      if (imdata(row,col)>threshold)
        imdata(row,col)=255;
      else
        imdata(row,col)=0;
      endif
    endfor
  endfor
  image = imdata;
endfunction
