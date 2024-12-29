#!/bin/bash
git clone https://github.com/microsoft/vcpkg
pwd
ls
cp -r ./ports/* ./vcpkg/ports/
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg install hermes
cd ..
cp -r ./vcpkg/installed/x64-linux/* "${PREFIX}/"
pip install .


