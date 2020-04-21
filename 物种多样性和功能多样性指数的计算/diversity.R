#计算物种多样性的函数
species_diversity <- function(data,output=FALSE){
  library(vegan) #导入vegan多样性计算包
  data[is.na(data)] <- 0 #把数据中的所有缺失值补成0
  abundance <- apply(data,1,sum) #计算所有样地的多度
  richness <- rowSums(data > 0) #计算所有样地的物种丰富度*
  shannon_index <- diversity(data, index = 'shannon', base = exp(1))#计算Shannon指数*
  shannon_diversity <- exp(1)^shannon_index#Shannon多样性
  pielou <- shannon_index / log(richness, exp(1))#Pielou均匀度*
  gini_simpson_index <- diversity(data, index = 'simpson')#Simpson指数
  simpson_diversity <- 1 / (1 - gini_simpson_index)#Simpson多样性
  equitability <- 1 / (richness * (1 - gini_simpson_index))#Simpson均匀度
  chao1 <- estimateR(data)[2, ]#chao1指数
  ace <- estimateR(data)[4, ]#ACE指数
  goods_coverage <- 1 - rowSums(data == 1) / rowSums(data)#goods_coverage指数
  #把结果保存在output对象中
  result <- data.frame(abundance,richness,shannon_index,shannon_diversity,pielou,
                       gini_simpson_index,simpson_diversity,equitability,
                       chao1,ace,goods_coverage,row.names = row.names(data))
  if (output== TRUE){write.xlsx(result,rowNames = T,file="多样性指数分析结果.xlsx")}
  return(result)
}
#计算功能多样性的函数
function_diversity <- function(abundance,trait,output = FALSE){
  library(FD)#功能多样性分析包
  #蚂蚁多度数据转换
  abundance[is.na(abundance)] <- 0#把多度数据中的缺失值用0替换
  abundance <- data.matrix(abundance)#把多度数据转换为矩阵
  index <- dbFD(trait,abundance)# 计算指数
  result <- data.frame(index$FRic,
                       index$FEve,
                       index$FDiv,
                       index$FDis,
                       index$RaoQ
                       )
  if (output == TRUE) {write.xlsx(result,file = '功能多样性指数分析结果.xlsx',rowNames=T)}
  return(result)
}


  
  
  