# Windows

## Conda build

The installation procedure is created with [Miniconda](https://conda.io/en/latest/miniconda.html) package.

### Install Miniconda

* Download the latest release of [Miniconda Windows installer](https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe).

* Install Miniconda
```cmd
start /wait "" ..\NASTRAN\Miniconda3-latest-Windows-x86_64.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%CD%\..\Miniconda3
```

* Create new **nastran-95** environment
```cmd
%CD%\Miniconda3\condabin\conda.bat create -n nastran-95 -y
```

* Activate **nastran-95** environment
```cmd
%CD%\Miniconda3\condabin\conda.bat activate nastran-95
```

* Install basic **Linux** commands
```cmd
conda install m2-base -y
```

* Install **gfortran** compiler
```cmd
conda install m2w64-gcc-fortran -y
```

* Install **make** utility
```cmd
conda install m2w64-make -y
```

* Install **mkl-devel** package
```cmd
conda install mkl-devel -y
```

* Build **nastran** executable and auxiliary utilities
```cmd
mingw32-make all
```
