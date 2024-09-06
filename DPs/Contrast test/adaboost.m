clc;clear


% 加载数据集（例如，使用内置的Fisher's iris数据集）
load('F:\ycy\修改\分类\1D-CNN\sampledata_singleformat.mat')
load("F:\ycy\修改\分类\RF\idxTest.mat")
load("F:\ycy\修改\分类\RF\idxTrain.mat")
load("F:\ycy\修改\分类\RF\idxValidation.mat")
XTrain = sample(idxTrain,:);
TTrain = label(idxTrain,:);
XValidation = sample(idxValidation,:);
TValidation = label(idxValidation,:);
X = cat(1,XTrain,XValidation);
Y = cat(1,TTrain,TValidation);

XTest = sample(idxTest,:);
TTest = label(idxTest,:);


% % 特征矩阵和标签向量
% X = meas;
% Y = strcmp(species, 'setosa'); % 将标签转换为二元分类问题

% 设置 AdaBoost 参数
numTrees = 20; % 弱分类器的数量
learningRate = 1; % 学习率

% 创建 AdaBoost 模型
template = templateTree('MaxNumSplits', 1); % 创建决策树模板，每棵树为单节点
adaBoostModel = fitcensemble(X, Y, 'Method', 'AdaBoostM1', ...
    'NumLearningCycles', numTrees, 'Learners', template, ...
    'LearnRate', learningRate);

% 预测
Y_pred = predict(adaBoostModel, X);

% 计算分类准确率
accuracy = mean(Y_pred == Y);

% 输出分类准确率
fprintf('分类准确率: %.4f\n', accuracy);

% 计算预测分数
[~, score] = predict(adaBoostModel, X);

% % 计算 ROC 曲线和 AUC
% [Xroc, Yroc, T, AUC] = perfcurve(Y, score(:, 2), true);
% 
% % 输出 AUC 值
% fprintf('AUC: %.4f\n', AUC);
% 
% % 绘制 ROC 曲线
% figure;
% plot(Xroc, Yroc);
% xlabel('False Positive Rate');
% ylabel('True Positive Rate');
% title('ROC Curve');

%%
YTest = predict(adaBoostModel, XTest);
TT = single(TTest);
YT = single(YTest);
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



