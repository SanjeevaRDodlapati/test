### Creatign env on wahab
#### Step 1 : Clone fugep on your home directory
```
$ git clone repo/address/from/github
```
#### Step 2: 
```
enable_lmod
module load container_env pytorch-gpu/1.3.1 #or any other environment that Min built for you before
```
#### Step 3: Create an environment using the following command
```
crun -c -p ~/envs/fugep
```

#### Step 4: Install fugep in the environment by running the following command within cloned fugep directory
```
crun -p ~/envs/fugep python setup.py install
```



## Conda Envs:
Check existing envs
```
conda info --envs # or
conda env list
```

Create env
```
conda create --name myenv
```

Create with specific python version
 ```
 conda create -n myenv python=3.6 #or
 coda create -n myenv python
 ```
 ```
 conda activate myenv
 ```
 
 Remove/deactivate env
 ```
 conda deactivate
 ```
 
 ```
 conda env remove -n myenv
 ```
 
