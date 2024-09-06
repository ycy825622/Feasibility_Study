clc;clear
%%
load("F:\ycy\修改\预测\1D-CNN\sampledata_singleformat.mat")
load("F:\ycy\修改\预测\1D-CNN\idxTrain.mat")
load('F:\ycy\修改\预测\1D-CNN\idxValidation.mat')
%%
np = 181;

for k = 1:size(sample,1)
    xd{k} = [squeeze(sample(k,1:np));squeeze(sample(k,(np+1):end))];
    
end
% 将训练集分为10折，取数据集的十分之一用来计算已知模型的准确性
XTrain = xd(:,idxTrain);
TTrain = label_size(idxTrain,:);
X = XTrain;
Y = TTrain;
XValidation = xd(idxValidation);
TValidation = label_size(idxValidation);
%% 定义一个网络模型
np = 181;

filterSize = 5;
numFilters = 16;
layers = [ ...
 sequenceInputLayer(2,MinLength=181)
 convolution1dLayer(filterSize,numFilters,Padding="causal")
 reluLayer
 layerNormalizationLayer
 convolution1dLayer(filterSize,2*numFilters,Padding="causal")
 reluLayer
 layerNormalizationLayer
 convolution1dLayer(filterSize,4*numFilters,Padding="causal")
 reluLayer
 layerNormalizationLayer
 globalAveragePooling1dLayer
 fullyConnectedLayer(1)
 regressionLayer];

options = trainingOptions("adam", ...
 MaxEpochs=500, ...
 ValidationData={XValidation, TValidation}, ...
 OutputNetwork="best-validation-loss", ...
 Plots="training-progress", ...
 Verbose=false);
% net = trainNetwork(XTrain,TTrain,layers,options);

% 定义 k 值
k = 10; % 假设使用 10 折交叉验证

% 定义一个函数来计算分类准确率
% compute_accuracy1 = @(true_size, predicted_size) mean(abs(((predicted_size-true_size)./true_size)));
compute_accuracy2 = @(true_size, predicted_size) sqrt(mean((predicted_size-true_size).^2));


% 定义一个函数来计算分类准确率
% compute_accuracy = @(true_labels, predicted_labels) sum(true_labels == predicted_labels) / numel(true_labels);

% 计算每折的大小
num_samples = size(X, 2);
fold_size = floor(num_samples / k);
% 初始化交叉验证准确率
% MAPE = zeros(k, 1);
RMSE = zeros(k, 1);
% 设置随机种子，确保每次生成的随机索引相同
rng(1)

% 随机打乱数据索引
idx = randperm(num_samples);

% 分割数据并进行交叉验证
for i = 1:k
    % 计算当前折的起始和结束索引
    start_idx = (i - 1) * fold_size + 1;
    end_idx = min(i * fold_size, num_samples);
    
    % 获取当前折的训练集和验证集
    cv_train_idx = [idx(1:start_idx-1), idx(end_idx+1:end)];
    cv_val_idx = idx(start_idx:end_idx);
    % 从原始数据中提取训练集和验证集
    x_train = XTrain(:,cv_train_idx);
    t_train = TTrain(cv_train_idx,:);
    x_val = XTrain(:,cv_val_idx);
    t_val = TTrain(cv_val_idx,:);
    % 保存每次训练的数据
    datasets{i}.x_train = x_train;
    datasets{i}.t_train = t_train;
    datasets{i}.x_val = x_val;
    datasets{i}.t_val = t_val;
    % 在训练集上训练模型
    net = trainNetwork(x_train,t_train,layers,options);
    % % 在每一折的数据上面计算准确率
    % [YTestzds,scores] = dzs.predictFcn(x_train);
    
    Yval = predict(net,x_val);


    % 计算当前折的交叉验证准确率
    % MAPE(i) = compute_accuracy1(TTest, YTest);
    RMSE(i) = compute_accuracy2(t_val, Yval);

    % % 计算当前折的交叉验证准确率
    % [ACC(i),PRE(i)] = funrf(t_train, YTestzds);
    % cv_accuracy(i) = compute_accuracy(t_train, YTestzds);
end

save("data.mat","datasets")




