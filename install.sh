#!/bin/bash
git clone https://github.com/microsoft/vcpkg
pwd
ls
cp -r ./ports/* ./vcpkg/ports/
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg install content-transfer-engine
