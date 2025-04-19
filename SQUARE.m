function img_out = SQUARE(img_in, x, y, k);

    img_out = img_in;
    
    img_out(x:x+k, y-1:y+1) = 1;
    img_out(x:x+k, y+k-1:y+k+1) = 1;
    img_out(x-1:x+1, y:y+k) = 1;
    img_out(x+k-1:x+k+1, y:y+k) = 1;