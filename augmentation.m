clc
clear
close all

load('./data/data_seg.mat');

angle = 0:15:180;

[M, N, K, num_data] = size(seg_data);

Label = zeros(num_data*4,1);
aug_data = zeros(M, N, K,num_data*4);

per = 0;

for n = 1:num_data
    
    if mod(n,num_data/10) == 0
        per = round(n/num_data*1000);
        per = per/10;
    end
    
    clc
    disp(['data ' num2str(n) ' ...'])
    disp([num2str(per) '% is completed'])
    
    
    img = seg_data(:,:,:,n);
    img = im2double(img);
    img = img./max(img(:));
    
    img1 = ROTATION(img,angle);
    img2 = MIRROR(img);
    
    IMG = cat(3,img,img2);

    aug_data(:,:,1,(n-1)*4+1:n*4) = IMG;
    Label((n-1)*4+1:n*4) = label(n);
end

label = Label;
aug_data = uint8(255*aug_data);

save('./data/aug_data.mat','aug_data','label','-v7.3')
