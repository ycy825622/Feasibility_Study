clc;
clear;
load('sp.mat', 'sp_meas')
load('sp_addnoise.mat')% 第三维分别按照snr=200（维度1）,snr=50（维度2）,snr=10（维度3）;排列
a = sp_meas{1, 1};
bb = sp_addnoise{1, 1};
b = squeeze(bb(:,:,1,:));

aa = 1*10^9:50*10^6:10*10^9;
%% normal
a1 = a(:,1);%厚度为0.1的反射系数
a2 = a(:,2);%厚度为0.2的反射系数
a3 = a(:,3);%厚度为0.3的反射系数
a4 = a(:,4);%厚度为0.4的反射系数
a5 = a(:,5);%厚度为0.5的反射系数
a6 = a(:,6);%厚度为0.6的反射系数
a7 = a(:,7);%厚度为0.7的反射系数
a8 = a(:,8);%厚度为0.8的反射系数
a9 = a(:,9);

b1 = squeeze(b(:,1,20));
b2 = squeeze(b(:,2,20));
b3 = squeeze(b(:,3,20));
b4 = squeeze(b(:,4,20));
b5 = squeeze(b(:,5,20));
b6 = squeeze(b(:,6,20));
b7 = squeeze(b(:,7,20));
b8 = squeeze(b(:,8,20));
b9 = squeeze(b(:,9,20));

c1 = abs(b1-a1)./abs(a1);
[m1,p1] = max(c1);
c2 = abs(b2-a2)./abs(a2);
[m2,p2] = max(c2);
c3 = abs(b3-a3)./abs(a3);
[m3,p3] = max(c3);
c4 = abs(b4-a4)./abs(a4);
[m4,p4] = max(c4);
c5 = abs(b5-a5)./abs(a5);
[m5,p5] = max(c5);
c6 = abs(b6-a6)./abs(a6);
[m6,p6] = max(c6);
c7 = abs(b7-a7)./abs(a7);
[m7,p7] = max(c7);
c8 = abs(b8-a8)./abs(a8);
[m8,p8] = max(c8);
c9 = abs(b9-a9)./abs(a9);
[m9,p9] = max(c9);

[n1,q1] = min(c1);
[n2,q2] = min(c2);
[n3,q3] = min(c3);
[n4,q4] = min(c4);
[n5,q5] = min(c5);
[n6,q6] = min(c6);
[n7,q7] = min(c7);
[n8,q8] = min(c8);
[n9,q9] = min(c9);





% d2 = angle(a2-b2);
% d5 = angle(a5-b5);
% d8 = angle(a8-b8);
% c2 = abs(a2-b2)./abs(a2);
% figure
% histogram(c2);
% c5 = abs(a5-b5)./abs(a2);
% figure
% histogram(c5);
% c8 = abs(a8-b8)./abs(a2);
% figure
% histogram(c8);

% d2 = angle(a2-b2);
% d5 = angle(a5-b5);
% d8 = angle(a8-b8);

% figure
% plot(aa,c2);
% hold on
% plot(aa,d2);
% figure
% plot(aa,c5);
% hold on
% plot(aa,d5);
% figure
% plot(aa,c8);
% hold on
% plot(aa,d8);
% 
% figure
% histogram(c2);
% hold on
% histogram(d2);
% figure
% histogram(c5);
% hold on
% histogram(d5);
% figure
% histogram(c8);
% hold on
% histogram(d8);

