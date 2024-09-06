clc;
clear;
%%
load('sampledata_singleformat.mat')
load('idxTrain.mat')
load('idxValidation.mat')
load('idxTest.mat')
load('xx.mat')
load('sc.mat')
load('ec.mat')
load('zlgs.mat')
load('zdgs.mat')
load('jxgs.mat')
%%
XTrain = sample(idxTrain,:);
TTrain = label_size(idxTrain,:);
XValidation = sample(idxValidation,:);
TValidation = label_size(idxValidation,:);
XTest = sample(idxTest,:);
TTest = label_size(idxTest,:);
%%

YTestxx = xx.predictFcn(XTest); 
MAPExx = mean(abs(((YTestxx-TTest)./TTest)));
RMSExx = sqrt(mean((YTestxx-TTest).^2));

YTestec = ec.predictFcn(XTest); 
MAPEtec = mean(abs(((YTestec-TTest)./TTest)));
RMSEtec = sqrt(mean((YTestec-TTest).^2));

YTestsc = sc.predictFcn(XTest); 
MAPEsc = mean(abs(((YTestsc-TTest)./TTest)));
RMSEsc = sqrt(mean((YTestsc-TTest).^2));

YTestzlgs = zlgs.predictFcn(XTest); 
MAPEzlgs = mean(abs(((YTestzlgs-TTest)./TTest)));
RMSEzlgs = sqrt(mean((YTestzlgs-TTest).^2));

YTestzdgs = zdgs.predictFcn(XTest); 
MAPEtzdgs = mean(abs(((YTestzdgs-TTest)./TTest)));
RMSEtzdgs = sqrt(mean((YTestzdgs-TTest).^2));

YTestjxgs = jxgs.predictFcn(XTest); 
MAPEjxgs = mean(abs(((YTestjxgs-TTest)./TTest)));
RMSEjxgs = sqrt(mean((YTestjxgs-TTest).^2));
%%
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
syt1 = zlgs.predictFcn(xc1);
syt2 = zlgs.predictFcn(xc2);
syt3 = zlgs.predictFcn(xc3);
syt4 = zlgs.predictFcn(xc4);
syt5 = zlgs.predictFcn(xc5);
syt6 = zlgs.predictFcn(xc6);
syt7 = zlgs.predictFcn(xc7);
syt8 = zlgs.predictFcn(xc8);
syt9 = zlgs.predictFcn(xc9);
figure
h1 = histogram(syt1);
figure
h2 = histogram(syt2);
figure
h3 = histogram(syt3);
figure
h4 = histogram(syt4);
figure
h5 = histogram(syt5);
figure
h6 = histogram(yt6);
figure
h7 = histogram(syt7);
figure
h8 = histogram(syt8);
figure
h9 = histogram(syt9);