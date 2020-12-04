```R
library(WGCNA)
library(pheatmap)
library(grid)
library(flashClust)
library(rUtils)
# source('E:/users/javon/coding/github/Javon-WS/r/packages/utils/R/convMatIdx1to2.R')
# The following setting is important, do not omit.
options(stringsAsFactors = FALSE);
# Allow multi-threading within WGCNA. This helps speed up certain calculations.
# At present this call is necessary for the code to work.
# Any error here may be ignored but you may want to update WGCNA if you see one.
enableWGCNAThreads()
dataDir <- 'R:/projects/tissue-regen/data/mouse-cardiac-fibro/rna/expr/pooled/'

ana_dir <- 'R:/projects/tissue-regen/analysis/mouse-cardiac-fibro/rna/module/'

expr_data <- read.csv(file = paste0(dataDir, '/tpm_gene.csv'), stringsAsFactors = FALSE)
sample_info <- read.csv(file='https://raw.githubusercontent.com/ODU-CSM/functional-genomics/master/data-analysis/mouse-cadiac-fibro/rna/samples-info.md?token=AM4TEPP77XHKVZGFCZ655DC72KPUG')
```

    Allowing parallel execution with up to 7 working processes.
    


```R
head(expr_data)
```


<table>
<caption>A data.frame: 6 × 15</caption>
<thead>
	<tr><th></th><th scope=col>seqid</th><th scope=col>start</th><th scope=col>end</th><th scope=col>gene_symbol</th><th scope=col>gene_id</th><th scope=col>Uninjured_C15</th><th scope=col>Uninjured_C16</th><th scope=col>D3_C17</th><th scope=col>D3_C18</th><th scope=col>D7_C20</th><th scope=col>W2_C22</th><th scope=col>W2_C23</th><th scope=col>W4_C24</th><th scope=col>W4_C25</th><th scope=col>D7_C26</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>1</td><td>3073253</td><td>3074322</td><td>4933401J01Rik</td><td>ENSMUSG00000102693</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td></tr>
	<tr><th scope=row>2</th><td>1</td><td>3205901</td><td>3671498</td><td>Xkr4         </td><td>ENSMUSG00000051951</td><td>0.02</td><td>0.05</td><td>0.31</td><td>0.00</td><td>0.59</td><td>0.00</td><td>0.35</td><td>0.03</td><td>0.19</td><td>0.82</td></tr>
	<tr><th scope=row>3</th><td>1</td><td>3365731</td><td>3368549</td><td>Gm37180      </td><td>ENSMUSG00000103377</td><td>0.09</td><td>0.60</td><td>0.06</td><td>1.55</td><td>0.41</td><td>1.79</td><td>0.54</td><td>0.86</td><td>0.00</td><td>0.00</td></tr>
	<tr><th scope=row>4</th><td>1</td><td>3375556</td><td>3377788</td><td>Gm37363      </td><td>ENSMUSG00000104017</td><td>1.15</td><td>1.07</td><td>0.15</td><td>2.66</td><td>0.60</td><td>1.42</td><td>1.35</td><td>0.51</td><td>1.61</td><td>0.00</td></tr>
	<tr><th scope=row>5</th><td>1</td><td>3464977</td><td>3467285</td><td>Gm37686      </td><td>ENSMUSG00000103025</td><td>0.00</td><td>0.85</td><td>0.00</td><td>0.00</td><td>4.74</td><td>0.00</td><td>0.37</td><td>0.00</td><td>1.42</td><td>1.52</td></tr>
	<tr><th scope=row>6</th><td>1</td><td>3512451</td><td>3514507</td><td>Gm37329      </td><td>ENSMUSG00000103201</td><td>0.00</td><td>0.00</td><td>0.04</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td></tr>
</tbody>
</table>




```R

data_use <- expr_data[, c(4, 6:ncol(expr_data))]


uninjured <- c("Uninjured_C15", "Uninjured_C16")
d3 <- c("D3_C17", "D3_C18")
d7 <- c("D7_C20", "D7_C26")
w2 <- c("W2_C22", "W2_C23")
w4 <- c("W4_C24", "W4_C25")
```


```R
# remove genes that had no expression at any stage
data_use <- data_use[apply(data_use[, 2:ncol(data_use)], 1, 
                           function(x){if(length(which(x == 0)) == length(x)) return(FALSE) else return(TRUE)}), ] # 19040, no gene is removed from this

# thresholds used to filter out low expressed gene
min_fpkm <- 0.1 # minimum of FPKM
min_nCell <- 1 # minimum of number cells in which the expression of a gene is at least min_fpkm
################################

keep <- apply(data_use[, 2:ncol(data_use)], 1, 
              function(x){if(length(which(x >= min_fpkm)) < min_nCell) return(FALSE) else return(TRUE)})
data_use <- data_use[keep, ]

# save the data for future use
# write.csv(data_use, file = paste0(ana_dir, '/data/module-gene.fpkm.csv'),
#           row.names = FALSE, quote = FALSE)

# Merge data from the same developmental stage
data_merged <- data.frame(gene = data_use$gene_symbol)
data_merged <- cbind(data_merged, uninjured = apply(data_use[, match(uninjured, names(data_use))], 1, mean))
data_merged <- cbind(data_merged, d3 = apply(data_use[, match(d3, names(data_use))], 1, mean))
data_merged <- cbind(data_merged, d7 = apply(data_use[, match(d7, names(data_use))], 1, mean))
data_merged <- cbind(data_merged, w2 = apply(data_use[, match(w2, names(data_use))], 1, mean))
data_merged <- cbind(data_merged, w4 = apply(data_use[, match(w4, names(data_use))], 1, mean))
```


```R
dim(data_use)
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>17713</li><li>11</li></ol>




```R
head(data_merged)
```


<table>
<caption>A data.frame: 6 × 6</caption>
<thead>
	<tr><th></th><th scope=col>gene</th><th scope=col>uninjured</th><th scope=col>d3</th><th scope=col>d7</th><th scope=col>w2</th><th scope=col>w4</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>2</th><td>Xkr4   </td><td> 0.035</td><td>0.155</td><td> 0.705</td><td> 0.175</td><td> 0.110</td></tr>
	<tr><th scope=row>3</th><td>Gm37180</td><td> 0.345</td><td>0.805</td><td> 0.205</td><td> 1.165</td><td> 0.430</td></tr>
	<tr><th scope=row>4</th><td>Gm37363</td><td> 1.110</td><td>1.405</td><td> 0.300</td><td> 1.385</td><td> 1.060</td></tr>
	<tr><th scope=row>5</th><td>Gm37686</td><td> 0.425</td><td>0.000</td><td> 3.130</td><td> 0.185</td><td> 0.710</td></tr>
	<tr><th scope=row>7</th><td>Gm38148</td><td> 0.015</td><td>0.115</td><td> 0.055</td><td> 0.090</td><td> 0.265</td></tr>
	<tr><th scope=row>12</th><td>Sox17  </td><td>13.480</td><td>2.525</td><td>18.655</td><td>16.750</td><td>20.820</td></tr>
</tbody>
</table>




```R
dim(data_merged)
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>17713</li><li>6</li></ol>




```R
datMat <- t(data_use[, 2:ncol(data_use)])

# tom <- TOMsimilarity((0.5 + 0.5 * cor(datMat, use = 'p')) ^ 12)
# # The computation of tom takes a lot of time (over one hour)
# # So, here we save it once it is computed and loaded later for quickly generating the pdf document.
# # Note, if data for computing tom is changned, it needs to be recomputed.
# save(tom, file = paste0(ana_dir, '/data/tom.RData'))

load(paste0(ana_dir, '/data/tom.RData'))

tree <- flashClust(as.dist(1 - tom), method = 'average')
unmergedLabels = cutreeDynamic(dendro = tree, distM = 1-tom,
		deepSplit = 2, cutHeight = NULL,
		minClusterSize = 30,
		pamRespectsDendro = FALSE );
unmergedColors = labels2colors(unmergedLabels)
```

     ..cutHeight not given, setting it to 0.988  ===>  99% of the (truncated) height range in dendro.
     ..done.
    


```R
table(unmergedColors)
```


    unmergedColors
      antiquewhite4         bisque4           black            blue           brown 
                 51              84             780             918             916 
             brown4          coral1            cyan       darkgreen        darkgrey 
                 85              52             529             256             207 
        darkmagenta  darkolivegreen      darkorange     darkorange2         darkred 
                119             133             183              86             304 
      darkseagreen4   darkslateblue   darkturquoise     floralwhite           green 
                 54              80             251              87             831 
        greenyellow          grey60       honeydew1           ivory  lavenderblush3 
                666             388              56              95              56 
          lightcyan      lightcyan1      lightgreen      lightpink4 lightsteelblue1 
                396              97             363              62              98 
        lightyellow         magenta          maroon   mediumpurple3    midnightblue 
                314             720              63             103             469 
       navajowhite2          orange      orangered4   paleturquoise  palevioletred3 
                 64             207             107             135              66 
               pink           plum1           plum2          purple             red 
                757             107              76             681             780 
          royalblue     saddlebrown          salmon         salmon4         sienna3 
                311             154             542              68             118 
            skyblue        skyblue3       steelblue             tan        thistle1 
                158             109             151             649              68 
           thistle2       turquoise          violet           white          yellow 
                 73            1096             134             172             866 
        yellowgreen 
                112 



```R
plotDendroAndColors(tree, unmergedColors, "Dynamic Tree Cut",
		dendroLabels = FALSE, hang = 0.03,
		addGuide = TRUE, guideHang = 0.05)

# compute module eigengenes 
ME <- moduleEigengenes(datMat, unmergedColors)
cor_ME <- cor(ME$eigengenes, use = 'p') # correlation among modules
# merge highly correlated modules
merge = mergeCloseModules(datMat, unmergedLabels, MEs = NULL, cutHeight = 0.5, verbose = 3)
# Numeric module labels
moduleLabels = merge$colors;
# Convert labels to colors
moduleColors = labels2colors(moduleLabels)
# create the (label, color) map
unique_lbls <- unique(moduleLabels)
lbl_clr_map <- data.frame(label = unique_lbls, color = rep('', length(unique_lbls)))
for (iLbl in 1:length(unique_lbls)) {
	lbl_clr_map$color[iLbl] <- moduleColors[moduleLabels == unique_lbls[iLbl]][1]
}
```

    


    
![png](output_11_1.png)
    



```R

```
