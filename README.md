# 生态数据分析的R代码

生态学分析所用的`R`代码，用于绘制物种累积曲线、计算物种多样性、群落结构相似性的非度量多维尺度分析（NMDS）和指示物种计算。

需要以下包：
```r
library(openxlsx)
library(vegan)
library(iNEXT)
library(reshape2)
library(ggplot2)
library(indicspecies)
```

包含以下函数：
- `create_data(df,formula,values,fun.aggregate,len=1)`
- `draw_curve(data)`
- `cal_diversity(data)`
- `cal_nmds(data,group,k=2)`
- `indval(data) `

## `create_data(df,formula,values,fun.aggregate,len=1)`
创建一个数据透视表格式的数据框，该数据框行名（索引）是透视表最顶级行名加上重复出现的次数，偏于进行数据分析。其中参数如下：
- df：为原始数据框；
-  formula：公式类型，`row1+row2+... ~ col1+col2+...`，`~`分隔的前面部分是数据透视表的行名，后面的是数据透视表的列名；
- values：数据透视表的值，即需要进行汇总的列名，该列名为字符串类型，需要用`""`括起来；
- fun.agregate：聚合函数，用于对值需要显示的结果进行聚合，例如`sum`、`mean`等；
- len：根据formula参数进行调整，用于控制数据框输出的结果只有聚合结果和行名（索引），例如fromula的行有2个，**则需要指定len=2**；
结果返回一个列表，其中result是用于分析的数据框，group是分组的类别，用于后续分析。

## `draw_curve(data)`
绘制物种累积曲线，其结果仅绘制希尔数为0阶，以物种多度为类型的物种累积曲线。
- data：数据框类型，需要满足列名为分组类别，行名为物种名，元素值为物种数量
无返回值

## `cal_diversity(data)`
计算三个常见的物种多样性指数，分别为abundance多度，richness物种丰富度，ace估计值。
- data：数据框类型，需要满足列名为物种名，行名为分组类别，元素值为物种数量，**与上述刚好相反**
返回计算出结果的数据框

## `cal_nmds(data,group,k=2) `
计算NMDS的显著性，并绘制NMDS的聚类图
- data：数据框类型，需要满足列名为物种名，行名为分组类别，元素值为物种数量
无返回值

##  `indval(data) `
显示具有显著效应的指示物种
- data：数据框类型，需要满足列名为物种名，行名为分组类别，元素值为物种数量
无返回值
