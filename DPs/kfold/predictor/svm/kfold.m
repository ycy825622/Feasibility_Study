clc;clear
%%
load("F:\ycy\修改\预测\SVM\sampledata_singleformat.mat")
load("F:\ycy\修改\预测\SVM\idxTrain.mat")

% 将训练集分为10折，取数据集的十分之一用来计算已知模型的准确性
XTrain = sample(idxTrain,:);
TTrain = label_size(idxTrain,:);
X = XTrain;
Y = TTrain;


% 定义 k 值
k = 10; % 假设使用 10 折交叉验证

% 定义一个函数来计算分类准确率
% compute_accuracy = @(true_labels, predicted_labels) sum(true_labels == predicted_labels) / numel(true_labels);

% 计算每折的大小
num_samples = size(X, 1);
fold_size = floor(num_samples / k);

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
    x_train = XTrain(cv_train_idx,:);
    t_train = TTrain(cv_train_idx,:);
    x_val = XTrain(cv_val_idx,:);
    t_val = TTrain(cv_val_idx,:);
    % 保存每次训练的数据
    datasets{i}.x_train = x_train;
    datasets{i}.t_train = t_train;
    datasets{i}.x_val = x_val;
    datasets{i}.t_val = t_val;

    % % 在每一折的数据上面计算准确率
    % [YTestzds,scores] = dzs.predictFcn(x_train);
    % 
    % % 计算当前折的交叉验证准确率
    % [ACC(i),PRE(i)] = funrf(t_train, YTestzds);
    % cv_accuracy(i) = compute_accuracy(t_train, YTestzds);
end

save("data.mat","datasets")




