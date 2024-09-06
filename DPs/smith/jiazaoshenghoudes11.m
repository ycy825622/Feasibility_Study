clc;
clear;
load('sp_addnoise.mat')
aa = sp_addnoise{1, 1}; % 肿瘤
% b = sp_addnoise{1, 2}; % 正常组织
a = squeeze(aa(:,:,3,:)); % snr = 10;
b = squeeze(aa(:,:,2,:)); % snr = 50;
c = squeeze(aa(:,:,1,:)); % snr = 200;
%a = squeeze(cp(:,:,3));% 第三个维度上的181x9
%aa = 1*10^9:50*10^6:10*10^9;%1ghz到5ghz,频率间隔为50mhz
%a1 = a(:,1);%厚度为0.1的反射系数

a2 = a(:,2,20);%厚度为0.2的反射系数
b2 = b(:,2,20);
c2 = c(:,2,20);
%a3 = a(:,3);%厚度为0.3的反射系数
%a4 = a(:,4);%厚度为0.4的反射系数

a5 = a(:,5,20);%厚度为0.5的反射系数
b5 = b(:,5,20);
c5 = c(:,5,20);
%a6 = a(:,6);%厚度为0.6的反射系数
%a7 = a(:,7);%厚度为0.7的反射系数

a8 = a(:,8,20);%厚度为0.8的反射系数
b8 = b(:,8,20);
c8 = c(:,8,20);
%a9 = a(:,9);%厚度为0.9的反射系数

figure
sa2 = smithplot(a2);

figure
sa5 = smithplot(a5);

figure
sa8 = smithplot(a8);

figure
sb2 = smithplot(b2);

figure
sb5 = smithplot(b5);

figure
sb8 = smithplot(b8);

figure
sc2 = smithplot(c2);

figure
sc5 = smithplot(c5);

figure
sc8 = smithplot(c8);