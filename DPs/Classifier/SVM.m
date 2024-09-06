%%
clc;
clear;
%%
load('sampledata_singleformat.mat')
load('idxTrain.mat')
load('idxValidation.mat')
load('idxTest.mat')
% load('xx.mat')
% load('ec.mat')
% load('sc.mat')
load('zdgs.mat')
% load('zlgs.mat')
% load('jxgs.mat')
%%
XTrain = sample(idxTrain,:);
XValidation = sample(idxValidation,:);
XTest = sample(idxTest,:);
TTrain = label(idxTrain,:);
TValidation = label(idxValidation,:);
TTest = label(idxTest,:);
%%
% YTestxx = xx.predictFcn(XTest);
% YTestec = ec.predictFcn(XTest);
% YTestsc = sc.predictFcn(XTest);
% YTestzlgs = zlgs.predictFcn(XTest);
YTestzdgs = zdgs.predictFcn(XTest);
% YTestjxgs = jxgs.predictFcn(XTest);
%%
% confusionchart(TTest,YTestxx);
% figure
% confusionchart(TTest,YTestec);
% figure
% confusionchart(TTest,YTestsc);
% figure
% confusionchart(TTest,YTestzlgs);
figure
confusionchart(TTest,YTestzdgs);
% figure
% confusionchart(TTest,YTestjxgs);
TT = TTest;
YT = YTestzdgs;
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
