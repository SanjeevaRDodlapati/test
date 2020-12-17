### View contents of gzip files on linux withouth unzipping.

```console
zcat file.gz | head -n 10
```

```console
 gzip -cd file.gz | head
 ```
 
```console
 zcat file.gz | tail -10
```

```console
zcat file.gz | wc -l
```

```console
zmore file.gz
```

```console
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
df = pd.read_csv('sample.tar.gz', compression='gzip', header=0, sep=',')
```
Description of compression from pandas.read_csv() function:




