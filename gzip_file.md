### View contents of gzip files on linux withouth unzipping.

```
zcat file.gz | head -n 10
```
```
 gzip -cd file.gz | head
 ```
 
 ```
 zcat file.gz | tail -10
```
```
zcat file.gz | wc -l
```
```
zmore file.gz
```
```
zless file.gz
```


### Reading gzip files in python without unzipping.

```python
f=gzip.open('file.gz','rb')
file_content=f.read()
print file_content

```



### Reading gzip files as pandas dataframe without unzipping.

```python
import gzip
import pandas as pd
df = pd.read_csv('sample.txt.gz', compression='gzip', sep='\t')

```

```python
df = pd.read_csv('sample.tar.gz', compression='gzip', header=0, sep=',', quotechar='"')
```
Description of compression from pandas.read_csv() function:
  compression{‘infer’, ‘gzip’, ‘bz2’, ‘zip’, ‘xz’, None}, default ‘infer’
For on-the-fly decompression of on-disk data. If ‘infer’ and filepath_or_buffer is path-like, then detect compression from the following extensions: ‘.gz’, ‘.bz2’, ‘.zip’, or ‘.xz’ (otherwise no decompression). If using ‘zip’, the ZIP file must contain only one data file to be read in. Set to None for no decompression.



