
### Checking current version and it's PATH
```console
python --version
```
```console
which python3
```

```console
type python3
```

```console
echo $PATH
```
##### setting python path in .bash_profile
```console
nano ~/.bash_profile
```
Add the path variable to .bash_profile
```console
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
```

Aiasing python
```console
nano ~/.bash_profile
alias python=python3
alias pip=pip3
```

Check
```console
type python
type python3
type pip
type pip3
```

Checking executable python
```console
python 
>>> import sys
>>> sys.executable
```
Inspecting installed package path
```console
pip show package_name
pip show pandas
```
make sure the path of the package from pip show pakcage output and sys.executable output pints to same locaton (path)


### Installing multiple versions of python



### setting default python version
