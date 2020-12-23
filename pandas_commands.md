## Useful pandas commands

Split string with separator
```python
df.str.split(pat='', expand=True) # pat = ' ' or '/' or ',' etc.
df.str.split(n=2, expand=True)
```
split from right
```python
df.str.rsplit(pat='', expand=True)
df.str.rsplit(n=2, expand=True)
```

selecting columns
```python
df1 = df.reindex(columns=filtered_columns)
```
selecting index-wise
```python
df.reindex(new_index, fill_value=0)
```
DataFrame.reindex supports two calling conventions

(index=index_labels, columns=column_labels, ...)

(labels, axis={'index', 'columns'}, ...)
