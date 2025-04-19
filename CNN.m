clc
clear
close all

%% Laod Data

load('./data/data_seg.mat');
label = categorical(label);

mkdir ./net CNN

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

%% CNN Architecture
layers = [
    imageInputLayer(imageSize,'name','Input')
    
    convolution2dLayer(7,8,'Padding','same','name','Conv1')
    batchNormalizationLayer('name','BN1')
    reluLayer('name','Relu1')
    dropoutLayer(0.01,'name','Drop1')
    maxPooling2dLayer(2,'Stride',2,'name','MaxPool1')
    
    convolution2dLayer(5,16,'Padding','same','name','Conv2')
    batchNormalizationLayer('name','BN2')
    reluLayer('name','Relu2')
    dropoutLayer(0.05,'name','Drop2')
    maxPooling2dLayer(2,'Stride',2,'name','MaxPool2')
    
    convolution2dLayer(3,32,'Padding','same','name','Conv3')
    batchNormalizationLayer('name','BN3')
    reluLayer('name','Relu3')
    dropoutLayer(0.1,'name','Drop3')
    maxPooling2dLayer(2,'Stride',2,'name','MaxPool3')
    
    fullyConnectedLayer(4,'name','FC1')
    dropoutLayer(0.2,'name','Drop')
    softmaxLayer('name','SoftMax')
    classificationLayer('name','classification')];

lgraph = layerGraph(layers);
plot(lgraph)
% analyzeNetwork(layers);

%% CNN Options
miniBatchSize = 32;

opts = trainingOptions('adam', ...
    'LearnRateSchedule','piecewise', ...
    'InitialLearnRate',0.01,...
    'L2Regularization',0.0005,...
    'LearnRateDropFactor',0.5, ...
    'LearnRateDropPeriod',5, ...
    'ExecutionEnvironment','gpu', ...
    'MiniBatchSize',miniBatchSize, ...
    'MaxEpochs',20, ...
    'Shuffle','every-epoch', ...
    'Plots','training-progress', ...
    'Verbose',false, ...
    'ValidationData',{X_Vl,T_Vl},...
    'ValidationFrequency',42,...
    'ValidationPatience', 84);

%% Train Network
[net,traininfo] = trainNetwork(X_Tr,T_Tr,layers,opts);

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
savefig('.\net\CNN\confusion_matrix2x2.fig')

%% Evaluation Network
acc_tr = sum(Y_Tr == T_Tr')./numel(T_Tr)*100
acc_vl = sum(Y_Vl == T_Vl')./numel(T_Vl)*100
acc_ts = sum(Y_Ts == T_Ts')./numel(T_Ts)*100
acc = sum(Y == T')./numel(T)*100

plotconfusion(T_Tr,Y_Tr','Train',T_Vl,Y_Vl','Validation',T_Ts,Y_Ts','Test',T,Y','All')
savefig('.\net\CNN\confusion_matrix4x4.fig')

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

savefig('.\net\CNN\training_progress.fig')




