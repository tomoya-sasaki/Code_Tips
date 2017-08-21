# Pybind11

## Table of Contents
1. [Install](#install)

## Install
### Python and clang
1. Install Python.
2. Install clang `$ sudo yum install clang` 
3. Install cmake `$ sudo yum install cmake`
4. In Python environment, `$ pip install pybind11`

### Pybind11
Put files into `/usr/local/include`
1. `$ cd ; makdir temp ; cd temp`
2. Clone Pybind11 `git clone --depth 1 https://github.com/pybind/pybind11.git`
3. `cd pybind11/include`. There is a folder named pybind11. We need to move it.
4. Move `sudo mv pybind11 /usr/local/include`
5. Check `cd /usr/local/include ; ls`

### Eigen
1. `$ cd ; cd temp`
2. `git clone --depth 1 https://github.com/RLovelett/eigen.git`
3. `cd eigen`
4. Move `sudo mv Eigen /usr/local/include`

### Try
