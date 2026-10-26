%对数据进行归一化函数
function new=normlize_data(Data_2)
%     找出每列的最大最小值
    maxold=max(Data_2);
    minold=min(Data_2);
%     张成与old一样大小,主要对行进行复制，列不用变
    m=size(Data_2,1);
    maxnew=repmat(maxold,m,1);
    minnew=repmat(minold,m,1);
    new=(Data_2-minnew)./(maxnew-minnew);
end