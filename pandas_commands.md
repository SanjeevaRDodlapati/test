## Useful pandas commands

### Split string with separator
```python
df.column_name.str.split(pat='', expand=True) # pat = ' ' or '/' or ',' etc.
df.column_name.str.split(n=2, expand=True)
```
split from right
```python
df.column_name.str.rsplit(pat='', expand=True)
df.column_name.str.rsplit(n=2, expand=True)
```
Slicing string vlaues of pandas dataframe
```python
df.column_name.str.[m:n]
```

### selecting columns
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
