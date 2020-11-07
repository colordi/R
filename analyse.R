library(openxlsx)
library(vegan)
library(iNEXT)
library(reshape2)
library(ggplot2)
library(indicspecies)



# 创建一个用于分析的dataframe
create_data <- function(df,formula,values,fun.aggregate,len=1) {
  # 生成透视表
  data = dcast(df,formula,value.var = values,fun.aggregate = fun.aggregate)
  # 生成索引
  empty_vector <- c() # 初始化一个空的向量
  # 生成重复项的角标列
  for (i in table(data[1])) {
    empty_vector <- append(empty_vector,c(1:i))
  }
  mark_col <- data.frame(empty_vector)
  # 创建索引
  index <- paste(data[,1],mark_col[,1],sep = "_")
  # 生成用于分析的表格
  new_data <- data.frame(subset(data,select = c(-1:-len)),row.names = index)
  group <- data[,1]
  return(list(result = new_data,group=group))
}

# 物种累积曲线绘制
draw_curve <- function(data) {
  data_in <- iNEXT(data,q=0,datatype = 'abundance')
  ggiNEXT(data_in,type = 1,facet.var = 'none') +theme(text = element_text(family = 'STXihei'))
}

# 计算多样性指数
cal_diversity <- function(data) {
  abundance <- apply(data,1,sum) #计算所有样地的多度
  richness <- rowSums(data > 0) #计算所有样地的物种丰富度*
  ace <- estimateR(data)[4, ] #ACE指数
  result <- data.frame(abundance,richness,ace,row.names = row.names(data))
  return(result)
}

# NMDS
cal_nmds <- function(data,group,k=2) {
  NMDS <- metaMDS(data,k=k,trymax = 100)#进行NMDS分析，k为对应的排序轴，默认为2，trymax为尝试次数
  stressplot(NMDS)#绘制shepard图查看拟合效果
  #等级聚类
  data_dist <- vegdist(data, method = "bray")#计算距离矩阵
  data_clust <- hclust(data_dist, method = "average")
  plot(data_clust, main = "",xlab = "",ylab = "")
  
  #进行ANOSIM计算
  anosim.result<-anosim(data_dist,group,permutations = 999)
  summary(anosim.result)
  mds.fig <- ordiplot(NMDS, type = "none") #绘制空白图
  #开始绘图
  #png('test.png',width = 3000, height = 3000, res = 300)
  mds.fig <- ordiplot(NMDS, type = "none") #绘制空白图
  #绘制样地坐标
  s = 1
  for (i in unique(group)) {
    colors <- c('green','blue','yellow','red')
    points(mds.fig, "sites", pch = s, col = "green", cex = 1.25,
           select = group == i)
    s <- s + 1
  }
  #绘制物种坐标
  #text(mds.fig,'species',col='blue',cex=0.75)
  orditorp(NMDS,display ="species",col = "black",cex=0.75,air=1,font=3)
  #绘制样地类型置信椭圆
  ordiellipse(NMDS,groups = group,conf = 0.95 ,label=F)
  #叠加聚类结果
  ordicluster(NMDS, data_clust, col = "gray")
}

# 指示物种计算
indval <- function(data) {
  group <- row.names(data)
  indval <- multipatt(data,group,duleg = TRUE,control = how(nperm = 999))
  summary(indval,invalcomp=TRUE)
}



