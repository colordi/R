library(openxlsx)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source('diversity.R')

#读取第1个sheet表
abundance <- read.xlsx('功能多样性数据.xlsx',sheet = 1, rowNames = T)
#读取第2个sheet表
trait <- read.xlsx('功能多样性数据.xlsx',sheet = 2, rowNames = T)

result <- function_diversity(abundance,trait,output = F)
