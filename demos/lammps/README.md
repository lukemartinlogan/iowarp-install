# Install

## IOWARP
```
spack install iowarp +mpiio +vfd
```

## ADIOS2

```
spack load iowarp

scspkg create adios2
cd $(scspkg pkg src adios2)
git clone https://github.com/ornladios/ADIOS2.git
cd ADIOS2
mkdir build
cd build
cmake ../ \
-DCMAKE_INSTALL_PREFIX=$(scspkg pkg root adios2) \
-DCMAKE_CXX_COMPILER=g++ \
-DCMAKE_C_COMPILER=gcc \
-DADIOS2_USE_SST=OFF \
-DBUILD_DOCS=ON \
-DBUILD_TESTING=ON \
-DADIOS2_BUILD_EXAMPLES=ON \
-DADIOS2_USE_MPI=ON \
-DADIOS2_USE_Derived_Variable=ON
make -j32 install
```

Add adios2 to spack:
```
nano ~/.spack/packages.yaml
```

```
packages:
  adios2:
    externals:
    - spec: adios2@2.9.0
      prefix: /home/llogan/.scspkg/packages/adios2
```

## COEUS
```
spack load iowarp
module load adios2

scspkg create coeus
cd $(scspkg pkg src coeus)
git clone https://github.com/lukemartinlogan/coeus-adapter.git --recurse-submodules
cd coeus-adapter
mkdir build
cd build
cmake ../ -DCMAKE_INSTALL_PREFIX=$(scspkg pkg root coeus)
make -j32 install
```

## LAMMPS
```
spack install lammps^adios2@2.9.0^mpi
```

# Jarvis

```
spack load iowarp lammps
module load adios2
jarvis env build iowarp
jarvis ppl load yaml iowarp-install/lammps.yaml
jarvis ppl run
```