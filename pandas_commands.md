## Useful pandas commands

Split string with separator
```python
df.str.split(pat='') # pat = ' ' or '/' or ',' etc.
df.str.split(n=2)
```
split from right
```python
df.str.rsplit(pat='')
df.str.rsplit(n=2)
```
