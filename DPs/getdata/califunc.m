function [cp] = califunc(sp,dp)
%CALIFUNC 此处显示有关此函数的摘要
%   此处显示详细说明
[fn,sn] = size(sp{1});
for i = 1:sn
    for j = 1:fn
        A = [-sp{1}(j,i),1,dp{1}(j,i);
            -sp{2}(j,i),1,dp{2}(j,i);
            -sp{3}(j,i),1,dp{3}(j,i)];
        b = [sp{1}(j,i)*dp{1}(j,i);
            sp{2}(j,i)*dp{2}(j,i);
            sp{3}(j,i)*dp{3}(j,i)];
        cp(j,i,:) = inv(A'*A)*A'*b;

    end
end

end

