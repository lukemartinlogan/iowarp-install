#!/bin/bash
git clone https://github.com/microsoft/vcpkg
ls
cp -r ./ports/* ./vcpkg/ports/
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg install hermes


