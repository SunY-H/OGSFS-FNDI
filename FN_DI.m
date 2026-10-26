function FNDI = FN_DI(X,Y,alpha)

data = [X,Y];
[n,~] = size(data);
int_relation = FN_Relation(data,alpha);
FN_granual = find(int_relation ~= 0);
FNDI = log2(n * n / length(FN_granual));

end

