
```console
sacct -T -S2021-06-16 -E2021-06-17 -o JobID,Partition,QOS,JobName%15,User,State,Elapsed,NNodes,NCPUs,NodeList,ExitCode,End -X

```

Command for using specific type of gpu
```console
#SBATCH -C gpu_name
```

To transfer data from wahab to turing:
```console
scp -r GM12878_fugep turing.hpc.odu.edu:/scratch-lustre/ml-csm/projects/fgenom/dna-met/ENCODE/WGBS/sampled_data/clean/train
```

Turing Env loading:
```console
enable_lmod
module load container_env pytorch-gpu/1.8.1

crun.pytorch-gpu -p ~/envs/fugep python -u file.py
```

```
Run liftover
~/liftOver/liftOver source_file chain_file target_file unMapped
```
