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


### RStudio on turing/wahab
```
salloc --job-name=rstudio
enable_lmod
module load container_env rstudio
crun rstudio
```

### eclipse on cluster
```
salloc -p gpu -c 8 --gres gpu:1 --job-name=eclipse
enable_lmod
module load container_env pytorch-gpu/1.9.0
crun -p ~/envs/deepTools eclipse
```

### install module to ~/envs/deepTools
```
crun    -p ~/envs/deepTools pip install XYZ
```

### Run Jupyter Lab on Cluster
##### for more check the email from Min on Sep. 17, 2021 (jsun)
##### crun -p ~/envs/deepTools jupyter lab --ip=0.0.0.0 --port=A_RANDOM_PORT_NUMBER
##### For the port number please pick a random number larger than 10000, and less than 20000
```
crun -p ~/envs/deepTools jupyter lab --notebook-dir=/scratch-lustre/ml-csm --ip=0.0.0.0 --port=11523

```



 
