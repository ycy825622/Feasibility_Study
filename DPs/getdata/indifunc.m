function dp_indi = indifunc(dp,dp0,idp,ni,myseed)
%CALDPFUNC 此处显示有关此函数的摘要
%   此处显示详细说明
if nargin == 5
    rng(myseed);
end

idp = idp/100;
sn = length(dp);

    for i = 1:sn
        sd = dp0{i}*idp;
        sd = repmat(sd,[1,1,size(dp{i},[3,4]),ni]);
        dp_indi{i} = repmat(dp{i},[ones(1,4),ni])+sd.*randn([size(dp{i}),ni]);
    end
end