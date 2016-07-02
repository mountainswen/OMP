function [ x , error] = OMP( d,y,err,ite )
%% 输入参数
% d : 字典  为 n * m 的矩阵，其中n为每个码字的维数，m为字典中码字的个数
% y ： 待测样本
% err : 当残差小于此值时停止迭代
% ite : 当迭代次数大于这个数字时停止迭代

%% 输出参数 
% x : 系数向量

%% 
[rowA,colA] = size(d);
x = zeros(colA,1);
Y = y;
% 对每个码字进行归一化，得到归一化的字典
% for i = 1 : colA
%     d(:,i) = d(:,i)./(norm(d(:,i),2));
% end
n = 0;
r = Y;
error =  norm(r,2);
while n < ite && norm(r,2) > err
    n = n + 1;
    in_p = ((d' * r))./ norm(r,2);
    
    [~,max_pos] = max(in_p);

    x(max_pos) = x(max_pos) + r' * d(:,max_pos) / norm(r,2);
    
    r = Y - r' * d(:,max_pos) * d(:,max_pos) / norm(r,2) ;
    Y = r;
    error =  norm(r,2);
end

end
