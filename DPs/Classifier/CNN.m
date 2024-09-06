clc;
clear;
%%
load('sampledata_singleformat.mat')
load('CNN.mat')
load('idxValidation.mat')
load('idxTrain.mat')
load('idxTest.mat')
%%
np = 181;

for k = 1:size(sample,1)
    xd{k} = [squeeze(sample(k,1:np));squeeze(sample(k,(np+1):end))];
    
end
yd = categorical(label);
XTrain = xd(idxTrain);
XValidation = xd(idxValidation);
XTest = xd(idxTest);
TTrain = yd(idxTrain);
TValidation = yd(idxValidation);
TTest = yd(idxTest);

YTest = classify(net,XTest);
acc = sum(YTest == TTest)./numel(TTest);
confusionchart(TTest,YTest);
TT = single(TTest);
YT = single(YTest);

TP = 0 %真阳性(TP)是正确预测的含肿瘤信号的数量
for i = 1:13500
    if YT(i) == 1
        if TT(i) == 1
            if YT(i) == TT(i)
                TP = TP+1
            end
        end
    end
end

TN = 0 %真阴性(TN)是正确预测的无肿瘤信号的数量
for j = 1:13500
    if YT(j) == 2
        if TT(j) == 2
            if YT(j) == TT(j)
                TN = TN+1
            end
        end
    end
end
FP = 0  %假阳性(FP)是预测为含肿瘤信号的无肿瘤信号的数量(预测的结果是肿瘤，但是实际情况为正常)。
for i = 1:13500
    if YT(i) == 1
        if TT(i) == 2
            
                FP = FP+1
            
        end
    end
end

FN = 0 %假阴性(FN)是预测为无肿瘤信号的含肿瘤信号的数量(预测的结果是正常，但是实际情况为肿瘤)
for j = 1:13500
    if YT(j) == 2
        if TT(j) == 1
            
                FN = FN+1
            
        end
    end
end

ACC = (TP+TN)/(TP+FP+TN+FN);
PRE = TP/(TP+FP);