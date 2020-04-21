# 物种多样性和功能多样性指数的计算

> 通过一个自建的R脚本进行物种多样性指数和功能多样性指数的计算。
>
> 无论是物种多样性还是功能多样性，主要的计算函数均包含于`diversity.R`脚本文件中，因此在使用前请先载入该脚本。

使用前请确保R的环境中已安装以下包：

```R
install.package('vegan')
install.package('FD')
install.package('openxlsx')
```



为了方便起见，最好是将`diversity.R`脚本文件与待分析数据放入同一路径，这个可以避免绝对路径过长或转换设备之后不统一而造成的错误。  

首先在`diversity.R`脚本文件所在的目录下新建一个r脚本文件。

导入读取xlsx文件的`openxlsx`包，并将当前路径设置为工作路径：

```R
library(openxlsx)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
```

导入用于分析的`diversity.R`脚本：

```R
source('diversity.R')
```



## 物种多样性指数计算

读取数据源并生成结果：

```R
data <- read.xlsx('多样性数据.xlsx',rowNames = T)
result <- species_diversity(data,output = T)
```

注意：`species_diversity`函数的`output`参数设置为`T`表示在当前目录生成一个名为`"多样性指数分析结果.xlsx"`的`xlsx`文件，设置为`F`表示不生成`xlsx`文件，仅把结果保存在`result`变量中。

完整代码即示例文件夹下的`物种多样性分析.r`。



## 功能多样性指数计算

功能多样性指数计算与物种多样性计算步骤相似，只不过`function_diversity`函数接受两个数据框对象，分别是`abundance`多度数据和`trait`特征值数据。

读取数据源并生成结果：

```R
#读取第1个sheet表
abundance <- read.xlsx('功能多样性数据.xlsx',sheet = 1, rowNames = T)
#读取第2个sheet表
trait <- read.xlsx('功能多样性数据.xlsx',sheet = 2, rowNames = T)

result <- function_diversity(abundance,trait,output = F)

```

同样，`function_diversity`函数的`output`参数表示是否生成`xlsx`文件。

完整代码即示例文件夹下的`功能多样性分析.r`。



## 问题

因为调用外部函数的原因，会在当前目录生成一个`vert.txt`文件。