function gaborResult = gaborFeatures(img,gabor)

img = double(img);

%% Filter the image using the Gabor filter bank

% Filter input image by each Gabor filter
[u,v] = size(gabor);
gaborResult = cell(u,v);
for i = 1:u
    for j = 1:v
        gaborResult{i,j} = imfilter(img, gabor{i,j});
    end
end


