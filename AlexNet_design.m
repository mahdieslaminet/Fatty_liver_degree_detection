clc
clear
close all

%% Laod Data

load('./data/data_seg.mat');
label = categorical(label);

 mkdir ./net AlexNet_design

%% Shuffling Data
[m, n ,k, N_data] = size(seg_data);
imageSize = [m, n ,k];

ind_tr = round(0.7*N_data);
ind_vl = round(0.8*N_data);

idx = randperm(N_data);

X = uint8(255*seg_data(:,:,:,idx));
T = label(idx);

clear seg_data

%% Train, Test and Validation Data Sepratation
X_Tr = X(:,:,:,1:ind_tr);
X_Vl = X(:,:,:,1+ind_tr:ind_vl);
X_Ts = X(:,:,:,1+ind_vl:end);

T_Tr = T(1:ind_tr);
T_Vl = T(1+ind_tr:ind_vl);
T_Ts = T(1+ind_vl:end);

%% AlexNet Architecture
Layers = [
    imageInputLayer(imageSize)
    
    convolution2dLayer(3,64,'Padding','same')
    reluLayer   
    
    convolution2dLayer(3,64,'Padding','same')
    reluLayer   
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,128,'Padding','same')
    reluLayer
    
    convolution2dLayer(3,128,'Padding','same')
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
     
    convolution2dLayer(3,256,'Padding','same')
    reluLayer
    
    convolution2dLayer(3,256,'Padding','same')
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,512,'Padding','same')
    reluLayer
    
    convolution2dLayer(3,512,'Padding','same')
    reluLayer
    
    convolution2dLayer(3,512,'Padding','same')
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,512,'Padding','same')
    reluLayer
    
    convolution2dLayer(3,512,'Padding','same')
    reluLayer
    
    fullyConnectedLayer(1000)
    reluLayer
    dropoutLayer(0.5)
    
    fullyConnectedLayer(4)
    softmaxLayer
    classificationLayer];

%% CNN Options
miniBatchSize = 32;

opts = trainingOptions('adam', ...
    'InitialLearnRate',0.0001,...
    'L2Regularization',0.0005,...
    'LearnRateDropFactor',0.2, ...
    'LearnRateDropPeriod',5, ...
    'ExecutionEnvironment','gpu', ...
    'MiniBatchSize',miniBatchSize, ...
    'MaxEpochs',15, ...
    'Shuffle','every-epoch', ...
    'Plots','training-progress', ...
    'Verbose',false, ...
    'ValidationData',{X_Vl,T_Vl},...
    'ValidationFrequency',42,...
    'ValidationPatience', 84);

%% Train Network
[net,traininfo] = trainNetwork(X_Tr,T_Tr,Layers,opts);

Y_Tr = classify(net,X_Tr,'MiniBatchSize',miniBatchSize);
Y_Vl = classify(net,X_Vl,'MiniBatchSize',miniBatchSize);
Y_Ts = classify(net,X_Ts,'MiniBatchSize',miniBatchSize);
Y = classify(net,X,'MiniBatchSize',miniBatchSize);

Y_Tr_ =  categorical(double(Y_Tr)>1);
Y_Vl_ =  categorical(double(Y_Vl)>1);
Y_Ts_ =  categorical(double(Y_Ts)>1);
Y_ =  categorical(double(Y)>1);

T_Tr_ = categorical(double(T_Tr)>1);
T_Vl_ = categorical(double(T_Vl)>1);
T_Ts_ = categorical(double(T_Ts)>1);
T_ = categorical(double(T)>1);

plotconfusion(T_Tr_,Y_Tr_','Train',T_Vl_,Y_Vl_','Validation',...
              T_Ts_,Y_Ts_','Test',T_,Y_','All')
savefig('.\net\AlexNet_design\confusion_matrix2x2.fig')

%% Evaluation Network
acc_tr = sum(Y_Tr == T_Tr')./numel(T_Tr)*100
acc_vl = sum(Y_Vl == T_Vl')./numel(T_Vl)*100
acc_ts = sum(Y_Ts == T_Ts')./numel(T_Ts)*100
acc = sum(Y == T')./numel(T)*100

plotconfusion(T_Tr,Y_Tr','Train',T_Vl,Y_Vl','Validation',T_Ts,Y_Ts','Test',T,Y','All')
savefig('.\net\AlexNet_design\confusion_matrix4x4.fig')

trainACC = traininfo.TrainingAccuracy;
valACC = traininfo.ValidationAccuracy;
trainLoss = traininfo.TrainingLoss;
valLoss = traininfo.ValidationLoss;

figure

subplot(2,1,1);
plot(trainACC, 'b',  'LineWidth', 1.5);
hold on
plot(valACC, 'k.', 'MarkerSize', 20);
axis([0 length(trainACC) 0 105])
grid minor

subplot(2,1,2);
semilogy(trainLoss, 'r', 'LineWidth', 1.5)
hold on
semilogy(valLoss, 'k.-', 'MarkerSize', 20);
axis([0 length(trainACC) -1 max(trainLoss)+1])
grid minor


savefig('.\net\AlexNet_design\training_progress.fig')

