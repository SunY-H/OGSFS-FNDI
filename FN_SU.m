function FNSU = FN_SU(data1,data2,fuzzy_neighbor,FD)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%模糊邻域对称不确定性
%%% data1:属性矩阵1
%%% data2:属性矩阵2
%%% alpha:模糊邻域参数
%%% fuzzy_neighbor:模糊邻域粒.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FNMDI = FN_MDI(data1,data2,fuzzy_neighbor,FD);
FNDI1 = FN_DI(data1,fuzzy_neighbor);
FNDI2 = FN_DI(data2,fuzzy_neighbor);

FNSU = FNMDI / (FNDI1 + FNDI2);

end


