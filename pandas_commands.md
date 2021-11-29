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

1. pd.set_option('display.float_format' '{:.4f}.format)
2. df.style.format(format_dict) - DEFINE format_dict befor running
3. df.style.format(format_dict).hide_index().highlight_min('col', color='red').highlight_max('col', color='green')
4.  df.style.format(format_dict).background_gradient(subset='Volume', cmap='Blues')
5. df.add_prefix('X_') - adds prefix to all the col names
6. df.add_suffix('_Y')
7. df.loc[::-1] - revers row order
8. df.loc[:, ::-1] - reverse col order
9. df.select_dtype(include='number') - select numeric data
10. df.select_dtype(include=['number', 'category']) - select multiple data types
11. df.select_dtypes(exclude='number') - exclude
12. pd.to_numeric(df.col, errots='coerce').fillna(0)
13. df = df.apply(pd.numeric errots='coerce').fillna(0) - apply to all the cols
14. df.info(memory_usage='deep') - 
15. df_reduced = pd.read_csv(file, use_cols = [selected cols])  - read only slected cols
16. df_reduced = pd.read_csv(file, use_cols = [selected cols], dtype={selsected : dtypes}) 
17. pd.concat((pd.read_csv(file) for file in files), ignore_index=True) - read from multiple files
18. pd.concat((pd.read_csv(file) for file in files), axis='columns') - concatenate along columns
19. df = pd.read_clipboard() - creates df from copying data from excel
20. df1 = df.saple(frac=0.75, random_state=124) - sample a subset
21. df2 = df.drop(df1.index) - remaining data after sampling - index values should be unique
22. df[(df.col==cond1) | (df.col==cond2)] - alternative: df[df.col.isin([cond1, cond2])]
23. df[~df.col.isin([cond1, cond2])] -  EXCLUDE
24. df[df.col.isin(df.col.value_counts().nlargest(n).index)] - Filter df by largest categories
25. df.isna().sum() - total missing values or NaNs
26. df.dropna(axis='columns') drops columns with NaN
27. df.dropna(thresh=len(df)*0.9, axis='columns')
28. 
29. 
30. df.values - returns numpy array
31. df.info()
32. df.describe()
33. df.dtypes
34. df['column'] - returns a series
35. df[['column']] - returns dataframe
36. df_dropped = df.drop(['col']) == df.drop(['col'], inplace=True)
37. df.loc[ind] - returns sliced rows
38. df.loc[-1] - DO NOT work, matching for the label
39. df.iloc[-1] - Works! df.iloc[[0, 1, -1]], matching for the index
40. df.loc[(df['col']==cond1) & (df['col2']==cond2)] - wrap multiple conditions in brackets
41. df.groupby('year') - suitable to parallel computing, separate slice for each year's data
42. df.groupby([columns])
43. df.groupby(['col1'])['col2'].mean() - slices data on col1 and finds mean on col2. If col1 = year and col2 = life expectance, finds mean life expectance for eatch year
44. df.groupby(['col1'])['col2'].agg(custom aggregate function) -  df.groupby(['col1'])['col2'].agg(np.std/custfunc)
45. df.groupby(['col1', col2])[['col3', col4]].agg(fun) - double brackets around second list of columns - Returns HEIRARCHICAL index
46. df.groupby(['col1', col2])[['col3', col4]].agg(fun).reset_index() - resets index back to original
47. df.groupby(['col1', col2])[['col3', col4]].transform(func) ## CHECK how it works
48. df.groupby(['col1', 'col2']).col3.mean().unstack() - converts to readable dataframe * CHECK how it works
49. df.melt(id_vars=col1, var_name=col2, value_name=col3) - keeps col1 and creates new columns with rest of the data
50. df.melt(id_vars=[col1, col2 col3], var_name=col4, value_name=col5)
51. piping data in pandas similar to R (check for examples) (https://www.youtube.com/watch?v=5rNu16O3YNE around 1.02h)
52. df['col'].str.split('_', expand=True) - returns dataframe of splits as columns
53. df['col'].str.split('_').str.get(0) - gives first column of splits 
54. df[['first', 'second', 'last']] = df.name.str.split(' ', expand=True)
55. df_new = df.col.apply(pd.Series) - splits a column that has lists as values into multiple cols i.e. len(list)
56. __check pd.pivot() vs pd.pivot_table()__
57. _df.pivot_table(index=[col1, col2 col3], columns=col4, values=col5).reset_index()_ - Reverse of melt()
58. df.pivot_table(index='col1', columns='another col'/[cols], values='col3' aggfunc='mean/sum/count')
59.  df.pivot_table(index='col1', columns='another col'/[cols], values='col3' aggfunc='mean/sum/count', margins=True) - row & col totals as well
60. df['col'].apply(my_func) - applies function to all the values of the col
61.  df['col'].apply([func1, func2]) - apply multiple functions
62. df['col'].apply(my_func, **kwargs)
63. df.apply(my_func) - applies the function column-wise
64. 
65.pf.ProfileReport(df) ## IMPORT pandas_profiling as pf 
66.  
67. 
68. 
69. 
