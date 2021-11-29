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

1. df.add_prefix('X_') - adds prefix to all the col names
2. df.add_suffix('_Y')
3. df.loc[::-1] - revers row order
4. df.loc[:, ::-1] - reverse col order
5. df.select_dtype(include='number') - select numeric data
6. df.select_dtype(include=['number', 'category']) - select multiple data types
7. df.select_dtypes(exclude='number') - exclude
8. pd.to_numeric(df.col, errots='coerce').fillna(0)
9. df = df.apply(pd.numeric errots='coerce').fillna(0) - apply to all the cols
10. df.info(memory_usage='deep') - 
11. df_reduced = pd.read_csv(file, use_cols = [selected cols])  - read only slected cols
12. df_reduced = pd.read_csv(file, use_cols = [selected cols], dtype={selsected : dtypes}) 
13. pd.concat((pd.read_csv(file) for file in files), ignore_index=True) - read from multiple files
14. pd.concat((pd.read_csv(file) for file in files), axis='columns') - concatenate along columns
15. df = pd.read_clipboard() - creates df from copying data from excel
16. df1 = df.saple(frac=0.75, random_state=124) - sample a subset
17. df2 = df.drop(df1.index) - remaining data after sampling - index values should be unique
18. df[(df.col==cond1) | (df.col==cond2)] - alternative: df[df.col.isin([cond1, cond2])]
19. df[~df.col.isin([cond1, cond2])] -  EXCLUDE
20. df[df.col.isin(df.col.value_counts().nlargest(n).index)] - Filter df by largest categories
21. df.isna().sum() - total missing values or NaNs
22. df.dropna(axis='columns') drops columns with NaN
23. df.dropna(thresh=len(df)*0.9, axis='columns')
24. 
25. 
26. df.values - returns numpy array
27. df.info()
28. df.describe()
29. df.dtypes
30. df['column'] - returns a series
31. df[['column']] - returns dataframe
32. df_dropped = df.drop(['col']) == df.drop(['col'], inplace=True)
33. df.loc[ind] - returns sliced rows
34. df.loc[-1] - DO NOT work, matching for the label
35. df.iloc[-1] - Works! df.iloc[[0, 1, -1]], matching for the index
36. df.loc[(df['col']==cond1) & (df['col2']==cond2)] - wrap multiple conditions in brackets
37. df.groupby('year') - suitable to parallel computing, separate slice for each year's data
38. df.groupby([columns])
39. df.groupby(['col1'])['col2'].mean() - slices data on col1 and finds mean on col2. If col1 = year and col2 = life expectance, finds mean life expectance for eatch year
40. df.groupby(['col1'])['col2'].agg(custom aggregate function) -  df.groupby(['col1'])['col2'].agg(np.std/custfunc)
41. df.groupby(['col1', col2])[['col3', col4]].agg(fun) - double brackets around second list of columns - Returns HEIRARCHICAL index
42. df.groupby(['col1', col2])[['col3', col4]].agg(fun).reset_index() - resets index back to original
43. df.groupby(['col1', col2])[['col3', col4]].transform(func) ## CHECK how it works
44. df.groupby(['col1', 'col2']).col3.mean().unstack() - converts to readable dataframe * CHECK how it works
45. df.melt(id_vars=col1, var_name=col2, value_name=col3) - keeps col1 and creates new columns with rest of the data
46. df.melt(id_vars=[col1, col2 col3], var_name=col4, value_name=col5)
47. piping data in pandas similar to R (check for examples) (https://www.youtube.com/watch?v=5rNu16O3YNE around 1.02h)
48. df['col'].str.split('_', expand=True) - returns dataframe of splits as columns
49. df['col'].str.split('_').str.get(0) - gives first column of splits 
50. df[['first', 'second', 'last']] = df.name.str.split(' ', expand=True)
51. df_new = df.col.apply(pd.Series) - splits a column that has lists as values into multiple cols i.e. len(list)
52. __check pd.pivot() vs pd.pivot_table()__
53. _df.pivot_table(index=[col1, col2 col3], columns=col4, values=col5).reset_index()_ - Reverse of melt()
54. df['col'].apply(my_func) - applies function to all the values of the col
55.  df['col'].apply([func1, func2]) - apply multiple functions
56. df['col'].apply(my_func, **kwargs)
57. df.apply(my_func) - applies the function column-wise
58. 
59. 
60.  
61. 
62. 
63. 
