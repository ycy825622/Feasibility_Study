clc;
clear;
%%
load('sampledata_singleformat.mat')
load('idxTrain.mat')
load('idxValidation.mat')
load('idxTest.mat')
load('tss.mat')
load('zds.mat')
load('jxs.mat')
%%
XTrain = sample(idxTrain,:);
TTrain = label_size(idxTrain,:);
XValidation = sample(idxValidation,:);
TValidation = label_size(idxValidation,:);
XTest = sample(idxTest,:);
TTest = label_size(idxTest,:);

nt = 0.1:0.1:0.9;

for k = 1:length(nt)
    temp = round((TTest-nt(k))*10);
    xt{k} = XTest(temp==0,:);
    yt{k} = TTest(temp==0);
end

xc1 = xt{1,1};
xc2 = xt{1,2};
xc3 = xt{1,3};
xc4 = xt{1,4};
xc5 = xt{1,5};
xc6 = xt{1,6};
xc7 = xt{1,7};
xc8 = xt{1,8};
xc9 = xt{1,9};
ryt1 = zds.predictFcn(xc1);
ryt2 = zds.predictFcn(xc2);
ryt3 = zds.predictFcn(xc3);
ryt4 = zds.predictFcn(xc4);
ryt5 = zds.predictFcn(xc5);
ryt6 = zds.predictFcn(xc6);
ryt7 = zds.predictFcn(xc7);
ryt8 = zds.predictFcn(xc8);
ryt9 = zds.predictFcn(xc9);
figure
h1 = histogram(ryt1);
figure
h2 = histogram(ryt2);
figure
h3 = histogram(ryt3);
figure
h4 = histogram(ryt4);
figure
h5 = histogram(ryt5);
figure
h6 = histogram(ryt6);
figure
h7 = histogram(ryt7);
figure
h8 = histogram(ryt8);
figure
h9 = histogram(ryt9);

%YTesttss = tss.predictFcn(XTest);
load('zds.mat')
YTestzds = zds.predictFcn(XTest); 
MAPEzds = mean(abs(((YTestzds-TTest)./TTest)));
RMSEzds = sqrt(mean((YTestzds-TTest).^2));
load('tss.mat')
YTesttss = tss.predictFcn(XTest); 
MAPEtss = mean(abs(((YTesttss-TTest)./TTest)));
MSEtss = sqrt(mean((YTesttss-TTest).^2));
load('jxs.mat')
YTestjxs = jxs.predictFcn(XTest); 
MAPEjxs = mean(abs(((YTestjxs-TTest)./TTest)));
MSEjxs = sqrt(mean((YTestjxs-TTest).^2));
