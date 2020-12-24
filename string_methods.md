## String methods in python
Split text
```python
text.split(sep='')
```
Strip special characters
```python
import re
seq = 'AEKTIPEGMJ 24860#%*&^^$*'
re.sub(r'[^ATGC]',r'',seq)
```
