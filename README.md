# Install IOWarp

## conda

1. Install Miniconda.
2. `$ source ~/miniconda3/bin/activate`
3. `$ conda install hyoklee::iowarp`

## snap

1. Install `snapd`.
2. Run `sudo snap install iowarp`.

## vcpkg

1. Install `git`.
2. `$ git clone https://github.com/iowarp/iowarp-install`
3. Run `$ ./install.sh`.

# Continuous Integration

| Test    | Status |
| --------| ------ |
| Ubuntu 24.04 |[![lin](https://github.com/iowarp/iowarp-install/actions/workflows/lin.yml/badge.svg)](https://github.com/iowarp/iowarp-install/actions/workflows/lin.yml) [![conda](https://github.com/iowarp/iowarp-install/actions/workflows/lin-cnd.yml/badge.svg)](https://github.com/iowarp/iowarp-install/actions/workflows/lin-cnd.yml)|
