clear;clc
%%
snr = [100,50,10];
% snr = 0;
% snr = 10;
nr = 50; %sample number of random noise
ep_idp = 20; % individual difference percentage for ep (Unit%)介电
sg_idp = 20; % individual difference percentage for sg (Unit%)电导率
ni = 50; %sample number of individual samples



load('./inputdata/measdata.mat');
load('./inputdata/frequency.mat');

try
    load('./outputdata/CaliPara.mat');
catch
    cp =califunc(sp_cali,dp); % 用校准液求参数A1,A2,A3
    save('./outputdata/CaliPara.mat','cp');
end

[ep0,sg0] = caldpfunc(sp_meas,cp,f); % 求不加任何影响因素的九个厚度的DPs


sp_addnoise = addnoisefunc(sp_meas,snr,nr,1);  % sp_meas为待测液体的S参数。给S参数加噪声

[ep_ns,sg_ns] = caldpfunc(sp_addnoise,cp,f);   % 加完噪声的DPs

ep_indi = indifunc(ep_ns,ep0,ep_idp,ni,2);     % 加完个体差异的DPs
sg_indi = indifunc(sg_ns,sg0,sg_idp,ni,3);

save('./outputdata/data.mat', 'ep_indi','sg_indi','ep0','sg0');

para.snr = snr;
para.f = f;
para.ep_idp = ep_idp;
para.sg_idp = sg_idp;
para.nr = nr;
para.ni = ni;

save('./outputdata/datapara.mat','para')
% note:
% dim-1: frequency
% dim-2: thickness
% dim-3: noise level (SNR)
% dim-4: samples with given noise level
% dim-5: samples with given individual difference percentage


%% --------------生成sample-feature数据（行：samples 列：features------------
samplemk = 2:5; %to spesify the which dims are features
% samplemk = [2,4,5];
% samplemk = [4,5];

% a = ep_indi{1,1}; a1 = ep_indi{1,2};
% b = sg_indi{1,1}; b1 = sg_indi{1,2};
% a2 = a(:,5,3,:,:); a3 = a1(:,5,3,:,:);
% b2 = b(:,5,3,:,:); b3 = b1(:,5,3,:,:);
% a4 = {a2,a3}; b4 = {b2,b3};
% [sample,label,label_size]= featurefunc(a4,b4,samplemk);

[sample,label,label_size]= featurefunc(ep_indi,sg_indi,samplemk);
% save('./outputdata/sampledata_doubleformat.mat','sample','label');

sample = single(sample);
label = single(label);
label_size = single(label_size);
save('./outputdata/sampledata_singleformat.mat','sample','label','label_size');

% %% ----------------------------数据分析---------------------------------
% [sample_norm,normc,norms] = normalize(sample,1);
% [idx,pc] = kmeans(sample_norm,2,'maxiter',1000);
% 
% [sum(idx(1:(end/2))==2)/length(idx)*2 sum(idx(1:(end/2))==1)/length(idx)*2
% sum(idx((end/2+1):end)==2)/length(idx)*2  sum(idx((end/2+1):end)==1)/length(idx)*2 ]*100






