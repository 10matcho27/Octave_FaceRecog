
function res = phase(imdata)
  %口目鼻が強調される。
  %imdata = imread(fileName);
  
  [sizex1,sizey1] = size(imdata);
  fdata1 = fftshift(fft2(fftshift(imdata)))/sqrt(sizex1*sizey1);

  % 位相限定相関（エッジ強調）
  amp_fdata1 = abs(fdata1); %振幅
  phase_fdata1 = atan2(imag(fdata1),real(fdata1)); %位相４
  filtereddata1 = ifftshift(abs(ifft2(exp(i*phase_fdata1))));
  %figure(cont1+1);
  %imshow(abs(filtereddata1),[]);
  
  threshold = max(max(filtereddata1))/(2.0+9/5);
  filtereddata1_aft = regionSegment(filtereddata1,threshold);
  
  %{
  figure(2)
  imshow(abs(-filtereddata1_aft+imdata),[]);
  %}
  
  %↑の-filtereddata1_aft+imdataで特徴点をよりはっきり抽出
  
  res = -filtereddata1_aft+imdata;
  
  
endfunction
