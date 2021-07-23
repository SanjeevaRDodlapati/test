
```console
sacct -T -S2021-06-16 -E2021-06-17 -o JobID,Partition,QOS,JobName%15,User,State,Elapsed,NNodes,NCPUs,NodeList,ExitCode,End -X
```
