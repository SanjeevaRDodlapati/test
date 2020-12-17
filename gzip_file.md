### View contents of gzip files on linux withouth unzipping.



### Reading gzip files in python without unzipping.



### Reading gzip files as pandas dataframe without unzipping.

```python
df = pd.read_csv('sample.txt.gz', compression='gzip', sep='\t')

```

```python
df = pd.read_csv('sample.tar.gz', compression='gzip', header=0, sep=',', quotechar='"')
```
Description of compression from pandas.read_csv() function:
  compression{‘infer’, ‘gzip’, ‘bz2’, ‘zip’, ‘xz’, None}, default ‘infer’
For on-the-fly decompression of on-disk data. If ‘infer’ and filepath_or_buffer is path-like, then detect compression from the following extensions: ‘.gz’, ‘.bz2’, ‘.zip’, or ‘.xz’ (otherwise no decompression). If using ‘zip’, the ZIP file must contain only one data file to be read in. Set to None for no decompression.
