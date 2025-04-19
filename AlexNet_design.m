     img = imread('path_to_your_image.jpg');
     img = imresize(img, [227 227]); % Resize the image to the input size of AlexNet
     label = classify(net, img);
     imshow(img);
     title(char(label));