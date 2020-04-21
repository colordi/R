library(openxlsx)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source('diversity.R')

data <- read.xlsx('多样性数据.xlsx',rowNames = T)
result <- species_diversity(data,output = T)
