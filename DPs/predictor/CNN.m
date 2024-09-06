clc;
clear;
%%
load('sampledata_singleformat.mat')
load('1D CNN.mat')
load('idxValidation.mat')
load('idxTrain.mat')
load('idxTest.mat')
%%
np = 181;

for k = 1:size(sample,1)
    xd{k} = [squeeze(sample(k,1:np));squeeze(sample(k,(np+1):end))];
    
end

XTrain = xd(idxTrain);
XValidation = xd(idxValidation);
XTest = xd(idxTest);
TTrain = label_size(idxTrain);
TValidation = label_size(idxValidation);
TTest = label_size(idxTest);
YTest = predict(net,XTest);
MAPE = mean(abs(((YTest-TTest)./TTest)));
RMSE = sqrt(mean((YTest-TTest).^2));
%% 提取厚度
XTest1 = sample(idxTest,:);
nt = 0.1:0.1:0.9;
for k = 1:length(nt)
    temp = round((TTest-nt(k))*10);
    xt{k} = XTest1(temp==0,:);
    yt{k} = TTest(temp==0);
end

xc1 = xt{1,1};%厚度0.1
xc2 = xt{1,2};%厚度0.2
xc3 = xt{1,3};%厚度0.3
xc4 = xt{1,4};%厚度0.4
xc5 = xt{1,5};%厚度0.5
xc6 = xt{1,6};%厚度0.6
xc7 = xt{1,7};%厚度0.7
xc8 = xt{1,8};%厚度0.8
xc9 = xt{1,9};%厚度0.9
%% cnn
%load('1D CNN net.mat')
np = 181;
for n = 1:size(xc1,1)
    xd1{n} = [squeeze(xc1(n,1:np));squeeze(xc1(n,(np+1):end))];
    
end
for n = 1:size(xc2,1)
    xd2{n} = [squeeze(xc2(n,1:np));squeeze(xc2(n,(np+1):end))];
    
end
for n = 1:size(xc3,1)
    xd3{n} = [squeeze(xc3(n,1:np));squeeze(xc3(n,(np+1):end))];
    
end
for n = 1:size(xc4,1)
    xd4{n} = [squeeze(xc4(n,1:np));squeeze(xc4(n,(np+1):end))];
    
end
for n = 1:size(xc5,1)
    xd5{n} = [squeeze(xc5(n,1:np));squeeze(xc5(n,(np+1):end))];
    
end
for n = 1:size(xc6,1)
    xd6{n} = [squeeze(xc6(n,1:np));squeeze(xc6(n,(np+1):end))];
    
end
for n = 1:size(xc7,1)
    xd7{n} = [squeeze(xc7(n,1:np));squeeze(xc7(n,(np+1):end))];
    
end
for n = 1:size(xc8,1)
    xd8{n} = [squeeze(xc8(n,1:np));squeeze(xc8(n,(np+1):end))];
    
end
for n = 1:size(xc9,1)
    xd9{n} = [squeeze(xc9(n,1:np));squeeze(xc9(n,(np+1):end))];
    
end

yt1 = predict(net,xd1);
yt2 = predict(net,xd2);
yt3 = predict(net,xd3);
yt4 = predict(net,xd4);
yt5 = predict(net,xd5);
yt6 = predict(net,xd6);
yt7 = predict(net,xd7);
yt8 = predict(net,xd8);
yt9 = predict(net,xd9);
figure
h1 = histogram(yt1);
figure
h2 = histogram(yt2);
%hold on
figure
h3 = histogram(yt3);
figure
h4 = histogram(yt4);
figure
h5 = histogram(yt5);
figure
h6 = histogram(yt6);
figure
h7 = histogram(yt7);
figure
h8 = histogram(yt8);
figure
h9 = histogram(yt9);