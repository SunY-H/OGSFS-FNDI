function FNMDI_D = FN_MDI_D(input,Y,alpha)

data = [input,Y];
[n,col] = size(data);
[partion,~,cj] = unique(data(:,col));
class_num = length(partion);
class = cell(1,class_num);
for i = 1:class_num
    class{i} = find(cj==i);
end
int_relation = FN_Relation(data,alpha);

FN_granual = find(int_relation ~= 0);
FNDI_1 = log2(n * n / length(FN_granual));

FD = zeros(n,class_num);
for i = 1: n
    for j = 1:class_num
        FD(i,j) = (sum(int_relation(i,class{j})))/sum(int_relation(i,:));
    end
end
FNDI_2 = find(FD ~= 0);

for k = 1:n
    fuzzy_neighbor_temp1 = int_relation(k,:);
    FN_zeronum = find(fuzzy_neighbor_temp1 == 0);
    for j = 1:class_num
        FD_temp = FD(:,j)';
        number = find((fuzzy_neighbor_temp1 - FD_temp) <= 0);
        n2 = length(number) - length(FN_zeronum);       
    end 
end

FNMDI_D = log2(n * n * n2 / FNDI_1 /length(FNDI_2));

% FNMDI1 = FN_MDI(data1,data2,alpha);
% FNMDI2 = FN_MDI(data1,alpha);
% FNMDI3 = FN_MDI(data2,alpha);

% FNID = FNMDI1 / (FNMDI2 + FNMDI3);

end
