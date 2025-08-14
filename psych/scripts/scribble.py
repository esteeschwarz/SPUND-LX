import sys
print(sys.executable)
import subprocess
import sys

def install(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

# Example usage:
#install("numpy<=1.24.4")
import numpy
print(numpy.__file__)

print(numpy.__version__)
#/Users/guhl/.virtualenvs/3-11/bin/python -m pip install numpy==1.24.4
