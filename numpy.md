# Numpy commands

gene0 = [100, 200, 50, 400]
gene1 = [50, 0, 0, 100]
gene2 = [350, 100, 50, 200]
expression_data = [gene0, gene1, gene2]

a = np.array(expression_data)

1. a.size
1. .ndim
1. a.shape
1. a.dtype
1. a.strides
1. a.flags
1. a.ravel()
1. a.T
1. a.argmax() - gives index of max
1. a.flatten() - copy, changes don't affect original array
1. a.ravel() - gives a view of original, changes will affect original array
1. np.argsort(a) - returns indexes of sorted array
2. np.vectorize(obj)
3. 

