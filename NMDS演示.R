# 演示
par(family='STXihei')
plot(0:10,0:10,type="n",axes=F,xlab="蚂蚁物种1的数量",ylab="")
axis(1)
points(5,0); text(5.5,0.5,labels="样地A")
points(3,0); text(3.2,0.5,labels="样地B")
points(0,0); text(0.8,0.5,labels="样地C")

par(family='STXihei')
plot(0:10,0:10,type="n",xlab="蚂蚁物种1的数量",
     ylab="蚂蚁物种2的数量")
points(5,5); text(5,4.5,labels="样地A")
points(3,3); text(3,3.5,labels="样地B")
points(0,5); text(0.8,5.5,labels="样地C")

# install.packages("scatterplot3d")为了演示3D图请先安装这个包
library(scatterplot3d)
par(family='STXihei')
d=scatterplot3d(0:10,0:10,0:10,type="n",xlab="蚂蚁物种1的数量",
                ylab="蚂蚁物种2的数量",zlab="蚂蚁物种3的数量"); d
d$points3d(5,5,0); text(d$xyz.convert(5,5,0.5),labels="样地A")
d$points3d(3,3,3); text(d$xyz.convert(3,3,3.5),labels="样地B")
d$points3d(0,5,5); text(d$xyz.convert(0,5,5.5),labels="样地C")
