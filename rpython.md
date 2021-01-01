R Markdown
----------

``` r
summary(cars)
```

    ##      speed           dist       
    ##  Min.   : 4.0   Min.   :  2.00  
    ##  1st Qu.:12.0   1st Qu.: 26.00  
    ##  Median :15.0   Median : 36.00  
    ##  Mean   :15.4   Mean   : 42.98  
    ##  3rd Qu.:19.0   3rd Qu.: 56.00  
    ##  Max.   :25.0   Max.   :120.00

Including Plots
---------------

You can also embed plots, for example:

![](rpython_files/figure-markdown_github/pressure-1.png)

Note that the `echo = FALSE` parameter was added to the code chunk to
prevent printing of the R code that generated the plot.

``` python
import pandas
input_path = '/Users/sanjeev/Downloads/data/bovine/metrics/GSE106538/aggregated_GSE106538_metrics.csv'
res = pandas.read_csv(input_path)
print(res.head())
```

    ##    Unnamed: 0  ... %Of_positive_match_labels
    ## 0           0  ...                      0.90
    ## 1           1  ...                      0.92
    ## 2           2  ...                      0.90
    ## 3           3  ...                      0.91
    ## 4           4  ...                      0.87
    ## 
    ## [5 rows x 9 columns]

``` python
print('\n heads of car dataframe: \n', r.cars.head())
```

    ## 
    ##  heads of car dataframe: 
    ##     speed  dist
    ## 0    4.0   2.0
    ## 1    4.0  10.0
    ## 2    7.0   4.0
    ## 3    7.0  22.0
    ## 4    8.0  16.0

``` python
print(res.tail())
```

    ##    Unnamed: 0  ... %Of_positive_match_labels
    ## 5           5  ...                      0.89
    ## 6           6  ...                      0.85
    ## 7           7  ...                      0.82
    ## 8           8  ...                      0.88
    ## 9           9  ...                      0.86
    ## 
    ## [5 rows x 9 columns]


## This is the end of the markdown file!