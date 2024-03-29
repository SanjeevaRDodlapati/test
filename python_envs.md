
# Conda envs
```
conda create --name py39 python=3.9
```
### Removing conda env
```
conda env remove --name env_name
```
List packages installed
```
conda list
```
```
pip list
```




# Python virtual envs through pipenv

```
pip install pipenv
```

Move to the folder where you want to create virtual env

Then,
```
pipenv install requests
```
To activate the env
```
pipenv shell
```

To check python interpreter:
```
python
>>> import sys
>>> sys.executable
```
To deactivate/exit env:
```
$ exit
```

To change python version, go to pipfile and change python version
then,
```
pipenv --python 3.9
```

To remove venv
```
pipenv --rm
```

To recreate the env:
```
pipenv install
```

To see path to env:
```
pipenv --venv
```



# Python virtual environment
```
python3 -m venv env_name
```

