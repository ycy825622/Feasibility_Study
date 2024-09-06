clc;clear
%%
load('F:\ycy\修改\分类\1D-CNN\sampledata_singleformat.mat')
[idxTrain,idxTest] = trainingPartitions(length(label), [0.9 0.1]); % 70% training and validation data set and a 30% testing data set.
XTrain = sample(idxTrain,:);
TTrain = label(idxTrain,:);
XTest = sample(idxTest,:);
TTest = label(idxTest,:);
% 特征矩阵和标签向量
X_train = XTrain;
Y_train = TTrain;
X_test = XTest;
Y_test = TTest;

% 设置随机森林参数
numTrees = 15; % 决策树的数量
maxDepth = 10; % 最大树深

% 初始化特征选择
numFeatures = size(XTrain, 2);
selectedFeatures = true(1, numFeatures); % 初始化所有特征为选中状态


% 递归特征消除
while sum(selectedFeatures) > 1
    % 创建随机森林分类模型
    template = templateTree('MaxNumSplits', maxDepth - 1); % MaxNumSplits = maxDepth - 1
    randomForestModel = fitcensemble(X_train(:, selectedFeatures), Y_train, 'Method', 'Bag', ...
        'NumLearningCycles', numTrees, 'Learners', template);

    % 计算每个特征的重要性
    importance = oobPermutedPredictorImportance(randomForestModel);

    % 找到最不重要的特征
    [~, leastImportantFeature] = min(importance);

    % 删除最不重要的特征
    selectedFeatureIndices = find(selectedFeatures);
    selectedFeatures(selectedFeatureIndices(leastImportantFeature)) = false;

    % 输出当前特征数量
    fprintf('剩余特征数量: %d\n', sum(selectedFeatures));
end

% 最终的特征选择结果
finalSelectedFeatures = find(selectedFeatures);

% 使用最终选择的特征创建最终的随机森林模型
randomForestModelFinal = fitcensemble(X_train(:, finalSelectedFeatures), Y_train, 'Method', 'Bag', ...
    'NumLearningCycles', numTrees, 'Learners', template);

% 在测试集上进行预测
[Y_pred, scores] = predict(randomForestModelFinal, X_test(:, finalSelectedFeatures));

% 计算测试集上的分类准确率
accuracy = mean(Y_pred == Y_test);

% 输出分类准确率
fprintf('测试集分类准确率: %.4f\n', accuracy);

% % 计算 ROC 曲线和 AUC
% [Xroc, Yroc, ~, AUC] = perfcurve(Y_test, scores(:, 2), true);
% 
% % 输出 AUC 值
% fprintf('测试集 AUC: %.4f\n', AUC);
% 
% % 绘制 ROC 曲线
% figure;
% plot(Xroc, Yroc);
% xlabel('False Positive Rate');
% ylabel('True Positive Rate');
% title('ROC Curve');

%%
% YTest = predict(adaBoostModel, XTest);
TT = single(TTest);
YT = single(Y_pred);
TP = 0 %真阳性(TP)是正确预测的含肿瘤信号的数量
for i = 1:13500
    if YT(i) == 0
        if TT(i) == 0
            if YT(i) == TT(i)
                TP = TP+1
            end
        end
    end
end

TN = 0 %真阴性(TN)是正确预测的无肿瘤信号的数量
for j = 1:13500
    if YT(j) == 1
        if TT(j) == 1
            if YT(j) == TT(j)
                TN = TN+1
            end
        end
    end
end
FP = 0  %假阳性(FP)是预测为含肿瘤信号的无肿瘤信号的数量(预测的结果是肿瘤，但是实际情况为正常)。
for i = 1:13500
    if YT(i) == 0
        if TT(i) == 1
            
                FP = FP+1
            
        end
    end
end

FN = 0 %假阴性(FN)是预测为无肿瘤信号的含肿瘤信号的数量(预测的结果是正常，但是实际情况为肿瘤)
for j = 1:13500
    if YT(j) == 1
        if TT(j) == 0
            
                FN = FN+1
            
        end
    end
end

ACC = (TP+TN)/(TP+FP+TN+FN);
PRE = TP/(TP+FP);














