# import package
library(iNEXT)
library(ggplot2)
library(openxlsx)

## 把当前脚本所在路径设置为工作路径
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# load data
data <- read.xlsx('data.xlsx',rowNames = TRUE)
data[is.na(data)] <- 0

# data analysis
data_in <- iNEXT(data,q=0,datatype = 'abundance')
ggiNEXT(data_in,type = 1,facet.var = 'none')
