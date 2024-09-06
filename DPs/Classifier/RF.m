clc;
clear;
%%
load('sampledata_singleformat.mat')
load('idxTrain.mat')
load('idxValidation.mat')
load('idxTest.mat')
% load('tss.mat')
% load('dzs.mat')
%% 
XTrain = sample(idxTrain,:);
TTrain = label(idxTrain,:);
XValidation = sample(idxValidation,:);
TValidation = label(idxValidation,:);
XTest = sample(idxTest,:);
TTest = label(idxTest,:);

[YTestzds,scores] = dzs.predictFcn(XTest);

% [YTesttss,scores] = tss.predictFcn(XTest);

confusionchart(TTest,YTestzds);
%%
% figure
% confusionchart(TTest,YTesttss);
TT = TTest;
YT = yfit;
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
