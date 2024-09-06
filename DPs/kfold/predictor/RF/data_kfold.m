clc;clear
load("data.mat")
%% 提取放进预测器里的数据
xtrain1 = datasets{1, 1}.x_train;
ttrain1 = datasets{1, 1}.t_train;
xval1 = datasets{1, 1}.x_val;
tval1 = datasets{1, 1}.t_val;

xtrain2 = datasets{1, 2}.x_train;
ttrain2 = datasets{1, 2}.t_train;
xval2 = datasets{1, 2}.x_val;
tval2 = datasets{1, 2}.t_val;

xtrain3 = datasets{1, 3}.x_train;
ttrain3 = datasets{1, 3}.t_train;
xval3 = datasets{1, 3}.x_val;
tval3 = datasets{1, 3}.t_val;

xtrain4 = datasets{1, 4}.x_train;
ttrain4 = datasets{1, 4}.t_train;
xval4 = datasets{1, 4}.x_val;
tval4 = datasets{1, 4}.t_val;

xtrain5 = datasets{1, 5}.x_train;
ttrain5 = datasets{1, 5}.t_train;
xval5 = datasets{1, 5}.x_val;
tval5 = datasets{1, 5}.t_val;

xtrain6 = datasets{1, 6}.x_train;
ttrain6 = datasets{1, 6}.t_train;
xval6 = datasets{1, 6}.x_val;
tval6 = datasets{1, 6}.t_val;

xtrain7 = datasets{1, 7}.x_train;
ttrain7 = datasets{1, 7}.t_train;
xval7 = datasets{1, 7}.x_val;
tval7 = datasets{1, 7}.t_val;

xtrain8 = datasets{1, 8}.x_train;
ttrain8 = datasets{1, 8}.t_train;
xval8 = datasets{1, 8}.x_val;
tval8 = datasets{1, 8}.t_val;

xtrain9 = datasets{1, 9}.x_train;
ttrain9 = datasets{1, 9}.t_train;
xval9 = datasets{1, 9}.x_val;
tval9 = datasets{1, 9}.t_val;

xtrain10 = datasets{1, 10}.x_train;
ttrain10 = datasets{1, 10}.t_train;
xval10 = datasets{1, 10}.x_val;
tval10 = datasets{1, 10}.t_val;

save("fold.mat","fold4","fold5","fold6","fold7","fold8","fold9","fold10")