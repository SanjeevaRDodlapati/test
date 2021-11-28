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

### Slicing/selecting dataframe
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

1. df.values - returns numpy array
2. df.info()
3. df.dtypes
4. df['column'] - returns a series
5. df[['column']] - returns dataframe
6. df_dropped = df.drop(['col']) == df.drop(['col'], inplace=True)
7. df.loc[ind] - returns sliced rows
8. df.loc[-1] - DO NOT work, matching for the label
9. df.iloc[-1] - Works! df.iloc[[0, 1, -1]], matching for the index
10. df.loc[(df['col']==cond1) & (df['col2']==cond2)] - wrap multiple conditions in brackets
11. df.groupby('year') - suitable to parallel computing, separate slice for each year's data
12. df.groupby([columns])
13. df.groupby(['col1'])['col2'].mean() - slices data on col1 and finds mean on col2. If col1 = year and col2 = life expectance, finds mean life expectance for eatch year
14. df.groupby(['col1'])['col2'].agg(custom aggregate function) -  df.groupby(['col1'])['col2'].agg(np.std/custfunc)
15. df.groupby(['col1', col2])[['col3', col4]].agg(fun) - double brackets around second list of columns - Returns HEIRARCHICAL index
16. df.groupby(['col1', col2])[['col3', col4]].agg(fun).reset_index() - resets index back to original
17. df.melt(id_vars=col1, var_name=col2, value_name=col3) - keeps col1 and creates new columns with rest of the data
18. df.melt(id_vars=[col1, col2 col3], var_name=col4, value_name=col5)
19. piping data in pandas similar to R (check for examples) (https://www.youtube.com/watch?v=5rNu16O3YNE around 1.02h)
20. df['col'].str.split('_', expand=True) - returns dataframe of splits
21. __check pd.pivot() vs pd.pivot_table()__
22. _df.pivot_table(id_vars=[col1, col2 col3], var_name=col4, value_name=col5)_ - Reverse of melt()
23. 
24. 
25.  
26. 
27. 
28. 
