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
crun -c -p ~/envs/fugep # python env
```

##### create env with yml file
```
module load python3
crun  mamba env create -p ~/envs/dart_eval -f environment.yml
```
#### Step 4: Install fugep in the environment by running the following command within cloned fugep directory
```
crun -p ~/envs/fugep python setup.py install
```
### Conda env
Create conda env
```
crun -c -s -p ~/envs/new_env  # conda env
```
Install package:

```
crun -p ~/envs/new_env conda install xxxxxx
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
or
salloc -p high-gpu-mem -c 8 --gres gpu:1
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



### Login to the cluster with remote desktop
Get a compute node
 
```
salloc -c 4
```

```
salloc -c 4 -p gpu --gres gpu:1 # if you need gpu
```
 

Load modules:
 
```
enable_lmod

module load container_env tensorflow-gpu/2.4.1
```
 ### Run pycharm with the crun prefix include the environment , for example:
 
```
crun -p ~/envs/pp pycharm
```
 

When pycharm is launched, it will ask you to pick a python interpreter, you need to use following steps:

Previously configured interpreter
Click "…" on the right

Click "Virtualenv Environment" on the left side of the new dialog window
Click "…" on the right

Just type in your environment concat with "/bin/python", like this:
/home/mdong003/envs/pp/bin/python


### Run pycharm with existing conda env
```
crun -p ~/envs/conda_env pycharm

Conda executable: /opt/micromamba/bin/conda

Use existing environment: /home/sdodl001/envs/conda_env
```

```
salloc -c 8

salloc -c 8 -p gpu --gres gpu:1 # if you need gpu
salloc -c 8 -p high-gpu-mem --gres gpu:1 # if you need gpu
```
```
enable_lmod

module load container_env tensorflow-gpu/2.4.1
```
```
crun -p ~/envs/pp pycharm
```
```
When pycharm is launched, it will ask you to pick a python interpreter, you need to use following steps:
Previously configured interpreter
Click "…" on the right
Click "Virtualenv Environment" on the left side of the new dialog window
Click "…" on the right
Just type in your environment concat with "/bin/python", like this:
/home/mdong003/envs/pp/bin/python
```

```
# Loading modules prior to custom env

### Graph_Mamba:
module load container_env python3/2023.2-py310
crun -p ~/envs/Graph_Mamba pycharm

### hyena_dna
module load container_env python3
crun -p ~/envs/hyena_dna pycharm

### mamba
module load container_env tensorflow-gpu/2.12.0
crun -p ~/envs/mamba pycharm

### CpG_Mamba
module load container_env python3/2023.2-py310
crun -p ~/envs/CpG_Mamba pycharm

### caduceus
module load container_env python3
crun -p ~/envs/caduceus pycharm

### mamba
```
 
