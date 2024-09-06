clc;
clear;

load('./outputdata/sampledata_singleformat.mat');


[sample_norm,normc,norms] = normalize(sample,1);
[idx,pc] = kmeans(sample_norm,2);
[sum(idx(1:(end/2))==2)/length(idx)*2 sum(idx(1:(end/2))==1)/length(idx)*2
sum(idx((end/2+1):end)==2)/length(idx)*2  sum(idx((end/2+1):end)==1)/length(idx)*2 ]*100