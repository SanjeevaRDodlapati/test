## String methods in python
Split text
```python
text.split(sep='')
```
Strip special characters except "ATGC" for DNA seq
```python
import re
seq = 'AEKTIPEGMJ 24860#%*&^^$*'
re.sub(r'[^ATGC]',r'',seq)
```
String method on a string
```python
re.sub('[^A-Za-z0-9]+', '', tissue)
```
**String method on a column of pandas dataframe**
```python
df[col] = df[col].apply(lambda x: re.sub('[^A-Za-z0-9\.]+', '', str(x)))
```

String split on multiple delimiters:
```python
re.split('; |, |\*|\n',a)
```
