
rng default;
figure;
boxplot(x,'Labels',{'OGSFS-FNDI','OGSFS-FI','Group-SAOLA','Alpha-investing','K-OFSD','FNCE'})
title('Classification accuracy compare using KNN')
x11 = xlabel('Algorithms');
x22 = ylabel('Accuracy');