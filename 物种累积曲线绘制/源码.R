##导入包
library(iNEXT)
library(openxlsx)

## 把当前脚本所在路径设置为工作路径
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#读取排列好顺序的excel文件
df <- t(read.xlsx("绘图数据.xlsx"))

source('稀疏及预测曲线脚本文件.r')#导入运算脚本
#批量储存每一行（每个样地）的物种多度到变量“Si”中
for (i in 1:nrow(df)) {
  assign(paste("S",i,sep=""),na.omit(df[i,]))#去除df中每行的缺失值并储存在变量S中
  assign(paste("out",i,sep = ""),iNEXT.Ind(get(paste("S",i,sep=""))))#计算随机抽样并将结果储存在变量out中
}

#绘图，指定输出图像的名字、宽度、长度和dpi
png('expor_name.png', width = 1800, height = 1200,res = 300)
list_sample <-  row.names(df) #生成一个用于储存样地名的列表
for (i in 1:nrow(df)) {
  out <- get(paste("out",i,sep=""))#获取out变量
  if (i > 1) (par(new=T)) #让每次绘图都进行叠加在一张图中
  plot.iNEXT(out$"q=0",xlab="",ylab="",xlim=c(1,2600),ylim=c(1,35),main="q = 0",col=1, cex.axis=1,tck=0.01, bty="l",family='Times New Roman')
  text(1.05 * max(out$"q=0"[,1]), max(out$"q=0"[,2]),list_sample[i], cex=1,family='Times New Roman')#在每一条曲线后面加上对应的样地
}
#at对应的值为x轴刻度的一半
mtext("个体数Individuals",side=1,line=3,at=1250,cex=1,font=1,family='STSongti-SC-Regular')
#at对应的值为y轴刻度的一半
mtext("物种数Species richness",side=2,line=2.5,at=17.5,cex=1,font=1,family='STSongti-SC-Regular')

dev.off()#结束绘图
