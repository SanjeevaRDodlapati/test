---
title: "Identify co-expression modules"
author: "Sanjeeva"
date: "Nov 12, 2020"
output:
  html_document:
    df_print: paged
  word_document: default
---

___


```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
Samples info:

Samples are cardiac fibroblasts isolated from mice of different genotypes without injuries and that at different days after myocardial infarction. For all WT (genotype) samples, the sample size per each treament is 2. Genotype "Tcf21 KO", treatment "7d MI" also has 2 samples. For "Tcf21 ko" with "4w MI" and the other genotype "Acta2 KO", there is only 1 sample each. The details of the samples are provided in the table below. 

|      |        |   species       |   i7        |   i5        |   genotype  |   treatment  |   full name           |
|------|--------|-----------------|-------------|-------------|-------------|--------------|-----------------------|
|   C  |   C15  |   Mus musculus  |   ATTACTCG  |   AGGCTATA  |   WT        |   uninjured  |   UNINJURY 6.23       |
|   C  |   C16  |   Mus musculus  |   GAATTCGT  |   TAAGATTA  |   WT        |   uninjured  |   UNINJURY 6.30       |
|   C  |   C17  |   Mus musculus  |   TCCGGAGA  |   AGGCTATA  |   WT        |   3d MI      |   3DMI 6.23           |
|   C  |   C18  |   Mus musculus  |   GAGATTCC  |   TCAGAGCC  |   WT        |   3d MI      |   3DMI 6.30           |
|   C  |   C19  |   Mus musculus  |   CGCTCATT  |   AGGATAGG  |   WT        |   7d MI      |   7DMI 6.23           |
|   C  |   C20  |   Mus musculus  |   ATTCAGAA  |   CTTCGCCT  |   WT        |   7d MI      |   7DMI 6.30           |
|   C  |   C21  |   Mus musculus  |   CTGAAGCT  |   TAAGATTA  |   Tcf21 ko  |   7d MI      |   242 TFC21KO MI7D    |
|   C  |   C22  |   Mus musculus  |   CTGAAGCT  |   ACGTCCTG  |   WT        |   2w MI      |   2WMI #623           |
|   C  |   C23  |   Mus musculus  |   CGCTCATT  |   GCCTCTAT  |   WT        |   2w MI      |   2WMI 7.7            |
|   C  |   C24  |   Mus musculus  |   TCCGCGAA  |   GTCAGTAC  |   WT        |   4w MI      |   4W (5WMI)           |
|   C  |   C25  |   Mus musculus  |   GAATTCGT  |   TCAGAGCC  |   WT        |   4w MI      |   4WMI #142           |
|   C  |   C26  |   Mus musculus  |   ATTCAGAA  |   AGGATAGG  |   Acta2 KO  |   7d MI      |   ACTAKO 487          |
|   C  |   C27  |   Mus musculus  |   TAATGCGC  |   TAAGATTA  |   Tcf21 ko  |   7d MI      |   832 TCF21 KO 7D MI  |
|   C  |   C38  |   Mus musculus  |   CTGAAGCT  |   CTTCGCCT  |   Tcf21 ko  |   4w MI      |   245 TCKF21KO 4W MI  |
|      |        |                 |             |             |             |              |                       |

i7 - i7 Index Sequences (6 bp or 8 bp); i5 - Optional: i5 Index Sequence (6 bp or 8bp)


# Module loading
```{r, message=FALSE, warning=FALSE, results='hide'}
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

# Data Info
The total number of genes included the dataset is `r nrow(expr_data)`. The total number of unique genes is `r length(unique(expr_data$Gene.Symbol))`. So, there is no duplicated genes. Data for cells in below are contained in this dataset.

First few rows of data:
`r head(expr_data)`

### Number of rows: `r nrow(expr_data)`
### Number of columns: `r ncol(expr_data)`

```{r}
names(expr_data)[6:ncol(expr_data)]
data_use <- expr_data[, c(4, 6:ncol(expr_data))]


uninjured <- c("Uninjured_C15", "Uninjured_C16")
d3 <- c("D3_C17", "D3_C18")
d7 <- c("D7_C20", "D7_C26")
w2 <- c("W2_C22", "W2_C23")
w4 <- c("W4_C24", "W4_C25")



```


```{r}
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
There are `r length(which(!keep))` genes with a FPKM over `r min_fpkm` in less than `r min_nCell` cell(s). These genes were excluded from the subsequent analysis. The total number of remaining genes is `r nrow(data_use)`. 

# Co-expressed gene modules
## Cluster analysis
```{r, message=FALSE, results="hide"}
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

The total number clusters (co-expresson modules) resulted from the hierarchial cluster analysis are `r length(unique(unmergedColors))`. The distribution of the genes accross these clusters are:
```{r, message=FALSE}
table(unmergedColors)
```



The below is the dendrogram (figures/md-dg-1.pdf) from the cluster analyis:

```{r 'md-dg', message=FALSE, results="hide", fig.height=4, fig.width=12, warning=FALSE}
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
# save module gene list
# for (lbl in unique_lbls) {
# 	write.table(data_use$gene_symbol[moduleLabels == lbl], 
# 			file = paste0(ana_dir, '/gene_list/M', lbl, '.txt'), 
# 			row.names = FALSE, col.names = FALSE, sep = ' ', quote = FALSE)
#}
```




























