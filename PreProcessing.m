clc
clear
close all

load('./data/ultrasound.mat');

counter = 0;

se1 = strel('disk', 5);
se2 = strel('square', 150);

gaborArray = gaborFilterBank(4,4,10,10);

for i = 1:55;
    
    img = data(i).images;
    
    disp(['data ' num2str(i) ' ...'])
    
    for j = 1:10
        
        
        IMG = img(j,:,:);
        [m,n,k] = size(IMG);
        IMG = reshape(IMG,[n,k]);
        IMG = im2double(IMG);
        IMG = IMG./max(IMG(:));
        
        bw = IMG >0.1;
        bw2 = imfill(bw,'holes');
        bw3 = imopen(bw2,se1);
        BW = grayconnected(double(bw3),217,318);
        BW2 = imopen(BW, se2);
        
        [y1, x1] = find(BW2'== 1,1);
        [y2, x2] = find(BW2 == 1,1);
        
        x3 = x2;
        y3 = y2 + 75;
        
        x4 = x2;
        y4 = y3 + 75;
        
        x5 = x3 + 55;
        y5 = y3;
        
        x6 = x5;
        y6 = y4;
        
        x7 = x5;
        y7 = y5 - 75;
        
        roi1 = IMG(x1:x1+149,y1:y1+149);
        roi2 = IMG(x2:x2+149,y2:y2+149);
        roi3 = IMG(x3:x3+149,y3:y3+149);
        roi4 = IMG(x4:x4+149,y4:y4+149);
        roi5 = IMG(x5:x5+149,y5:y5+149);
        roi6 = IMG(x6:x6+149,y6:y6+149);
        roi7 = IMG(x7:x7+149,y7:y7+149);
        
        ROI = cat(3,roi1,roi2,roi3,roi4,roi5,roi6,roi7);
        
        %% Show ROI's
        
        %show_ROI;
        
        %% Gabor filter bank
        %% Apply Gabor Filter-Bank
        
        for roi_num = 1:7
            img_roi = ROI(:,:,roi_num);
            gaborResult = gaborFeatures(img_roi,gaborArray);
            
            for filt_num = 1:16
                X(:,:,filt_num) = abs(gaborResult{filt_num});
            end
            
            
            featureSet = cat(3,img_roi,X);
            
            T = data(i).fat;
            
            if T < 5
                t = 1;
            else
                if  T<20
                    t = 2;
                else
                    if T<40
                        t = 3;
                    else
                        if T<70
                            t = 4;
                        end
                    end
                end
            end
            
            for data_num = 1:8
                counter = counter+1;
                seg_data(:,:,:,counter) = featureSet;
                label(counter) = t;
            end
        end
    end
end

% save('./data/data_seg.mat','seg_data','label');




