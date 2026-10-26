function FNMDI = FN_MDI(input1,input2,Y,alpha)

data1 = [input1;Y];
data2 = [input2;Y];
[n, ~]=size(Y);

[int_relation_1,~] = FN_Relation(data1,alpha);
FN_granual_1 = find(int_relation_1 ~= 0);
FNDI_1 = log2(n * n / length(FN_granual_1));

[int_relation_2,~] = FN_Relation(data2,alpha);
FN_granual_2 = find(int_relation_2 ~= 0);
FNDI_2 = log2(n * n / length(FN_granual_2));

int_relation = zeros(n);
for i=1:n
    for j=1:n
        if int_relation_1(i,j) <= int_relation_2(i,j)
            int_relation(i,j) = int_relation_1(i,j);
        else
            int_relation(i,j) = int_relation_2(i,j);
        end
    end
end
FN_granual = find(int_relation ~= 0);
FN_H = log2(n * n / length(FN_granual));

FNMDI = log2(n * n * FN_H / FNDI_1 /FNDI_2);

end
