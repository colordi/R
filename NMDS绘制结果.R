library(vegan)
library(openxlsx)

data <- read.xlsx("/Users/yandi/Documents/GitHub/R/NMDS数据源.xlsx",sheet = 2,rowNames = TRUE)
data[is.na(data)] <- 0

NMDS <- metaMDS(data,k=2,trymax = 100)

# 完善的绘制
par(family='STXihei') # 指定字体，避免中文乱码
fig <- ordiplot(NMDS,type="none") #绘制空白图

## 样地坐标
## 为样地分组
group <- read.xlsx("/Users/yandi/Documents/GitHub/R/NMDS数据源.xlsx",sheet = 3,rowNames = F)
points(fig,"sites",pch = 5,col='green',cex=1.25,select = group$类型 == "C") #把C类型进行绘制
points(fig,"sites",pch = 6,col='red',cex=1.25,select = group$类型 == "W") #把W类型进行绘制
points(fig,"sites",pch = 7,col='blue',cex=1.25,select = group$类型 == "S") #把S类型进行绘制

## 物种坐标
orditorp(NMDS,display = "species",col = "black",cex = 0.75)

## 绘制置信椭圆
ordiellipse(NMDS,groups = group$类型,conf = 0.95,label = F)

##绘制图例
legend('bottomright',c('C','W','S'),pch = c(5,6,7),col = c('green','red','blue'),inset = 0.01)
legend('topright',inset = 0.01,'stress=0.110')
