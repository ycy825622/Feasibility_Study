clc;
clear;
load sampledata_singleformat.mat;
load('f.mat')

%% 取特定频率点的介电与电导率（厚度0.5）
l = 5000;
s = 5:9:size(sample,1);
for k = 1:l
 a(k,:) = sample(s(k),:);
end
%%  5Ghz(81列 181+81列)
m = 2500;
n = m+1;%肿瘤组织与正常组织的分界线
%肿瘤组织的介电特性值
jd = a(1:m,81);
dd = a(1:m,262);
%正常组织的介电特性值
jd1 = a(n:l,81);
dd1 = a(n:l,262);
% 计算均值
aa = mean(jd);
bb = mean(jd1);
cc = mean(dd);
ee = mean(dd1);
figure
scatter(jd,dd);
hold on
scatter(jd1,dd1);
hold on
scatter(48.3898,4.3668);
hold on
scatter(39.3567,3.7934);
hold on
scatter(aa,cc);
hold on
scatter(bb,ee);
xlabel('Permittivity'),ylabel('Conductivity (S/m)');
legend('Tumor tissue','Normal tissue','Tumor tissue','Normal tissue')
%%  2Ghz(21列 181+21列)
m = 2500;
n = m+1;%肿瘤组织与正常组织的分界线
%肿瘤组织的介电特性值
jd2 = a(1:m,21);
dd2 = a(1:m,202);
%正常组织的介电特性值
jd3 = a(n:l,21);
dd3 = a(n:l,202);
figure
scatter(jd2,dd2);
hold on
scatter(jd3,dd3);
hold on
scatter(53.9580,1.1648);
hold on
scatter(43.7950,1.3609);
xlabel('Permittivity'),ylabel('Conductivity (S/m)');
legend('Tumor tissue','Normal tissue','Tumor tissue','Normal tissue')
%%  9Ghz(161列 342列)
m = 2500;
n = m+1;%肿瘤组织与正常组织的分界线
%肿瘤组织的介电特性值
jd4 = a(1:m,161);
dd4 = a(1:m,342);
%正常组织的介电特性值
jd5 = a(n:l,161);
dd5 = a(n:l,342);
figure
scatter(jd4,dd4);
hold on
scatter(jd5,dd5);
hold on
scatter(41.2029,10.1294);
hold on
scatter(33.9814,8.3102);
xlabel('Permittivity'),ylabel('Conductivity (S/m)');
legend('Tumor tissue','Normal tissue','Tumor tissue','Normal tissue')


%% 取特定频率点的介电与电导率（厚度0.2）
l = 5000;
s2 = 2:9:size(sample,1);
for k = 1:l
 a2(k,:) = sample(s2(k),:);
end
%%  5Ghz(81列 181+81列)
m = 2500;
n = m+1;%肿瘤组织与正常组织的分界线
%肿瘤组织的介电特性值
jd2 = a2(1:m,81);
dd2 = a2(1:m,262);
%正常组织的介电特性值
jd21 = a2(n:l,81);
dd21 = a2(n:l,262);
% 计算均值
aa = mean(jd2);
bb = mean(jd21);
cc = mean(dd2);
ee = mean(dd21);
figure
scatter(jd2,dd2);
hold on
scatter(jd21,dd21);
hold on
scatter(45.3894,4.1825);
hold on
scatter(39.3488,3.7963);
hold on
scatter(aa,cc);
hold on
scatter(bb,ee);
xlabel('Permittivity'),ylabel('Conductivity (S/m)');
legend('Tumor tissue','Normal tissue','Tumor tissue','Normal tissue')
%%  2Ghz(21列 181+21列)
m = 2500;
n = m+1;%肿瘤组织与正常组织的分界线
%肿瘤组织的介电特性值
jd22 = a2(1:m,21);
dd22 = a2(1:m,202);
%正常组织的介电特性值
jd23 = a2(n:l,21);
dd23 = a2(n:l,202);
figure
scatter(jd22,dd22);
hold on
scatter(jd23,dd23);
hold on
scatter(50.7426,1.2384);
hold on
scatter(43.7927,1.3612);
xlabel('Permittivity'),ylabel('Conductivity (S/m)');
legend('Tumor tissue','Normal tissue','Tumor tissue','Normal tissue')
%%  9Ghz(161列 342列)
m = 2500;
n = m+1;%肿瘤组织与正常组织的分界线
%肿瘤组织的介电特性值
jd24 = a2(1:m,161);
dd24 = a2(1:m,342);
%正常组织的介电特性值
jd25 = a2(n:l,161);
dd25 = a2(n:l,342);
figure
scatter(jd24,dd24);
hold on
scatter(jd25,dd25);
hold on
scatter(38.6924,9.4154);
hold on
scatter(33.9591,8.3137);
xlabel('Permittivity'),ylabel('Conductivity (S/m)');
legend('Tumor tissue','Normal tissue','Tumor tissue','Normal tissue')



%% 取特定频率点的介电与电导率（厚度0.8）
l = 5000;
s8 = 8:9:size(sample,1);
for k = 1:l
 a8(k,:) = sample(s8(k),:);
end
%%  5Ghz(81列 181+81列)
m = 2500;
n = m+1;%肿瘤组织与正常组织的分界线
%肿瘤组织的介电特性值
jd8 = a8(1:m,81);
dd8 = a8(1:m,262);
%正常组织的介电特性值
jd81 = a8(n:l,81);
dd81 = a8(n:l,262);
figure
scatter(jd8,dd8);
hold on
scatter(jd81,dd81);
hold on
scatter(49.5436,4.4699);
hold on
scatter(39.3596,3.7923);
xlabel('Permittivity'),ylabel('Conductivity (S/m)');
legend('Tumor tissue','Normal tissue','Tumor tissue','Normal tissue')
%%  2Ghz(21列 181+21列)
m = 2500;
n = m+1;%肿瘤组织与正常组织的分界线
%肿瘤组织的介电特性值
jd82 = a8(1:m,21);
dd82 = a8(1:m,202);
%正常组织的介电特性值
jd83 = a8(n:l,21);
dd83 = a8(n:l,202);
figure
scatter(jd82,dd82);
hold on
scatter(jd83,dd83);
hold on
scatter(55.1077,1.1378);
hold on
scatter(43.7958,1.3608);
xlabel('Permittivity'),ylabel('Conductivity (S/m)');
legend('Tumor tissue','Normal tissue','Tumor tissue','Normal tissue')
%%  9Ghz(161列 342列)
m = 2500;
n = m+1;%肿瘤组织与正常组织的分界线
%肿瘤组织的介电特性值
jd84 = a8(1:m,161);
dd84 = a8(1:m,342);
%正常组织的介电特性值
jd85 = a8(n:l,161);
dd85 = a8(n:l,342);
figure
scatter(jd84,dd84);
hold on
scatter(jd85,dd85);
hold on
scatter(42.0402,10.5850);
hold on
scatter(33.9899,8.3093);
xlabel('Permittivity'),ylabel('Conductivity (S/m)');
legend('Tumor tissue','Normal tissue','Tumor tissue','Normal tissue')