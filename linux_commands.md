## Useful linux commands

To display size of the current directory
```console
du -h
```
	
To display size of a specific folder
```console
du -h folder_path
```
To display total size
```console
du -ch folder_path
```
or
```console
du -ch folder_path | grep total
```

To get more access previleges use (requires user password)
```console
sudo du -h folder_path
```

To get the size of entire directory in tree format (need to install tree, if not exists)
```console
tree -d -h
```

