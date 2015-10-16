# Install native mojo

Mojo application is exeutable multiplatform Linux and android ..etc.

* https://github.com/domokit/mojo

This is memo when I tried to install into ubuntu on vmware fusion. 

## environment 
* ubuntu-ja-14.04-desktop-amd64.iso（ISOイメージ） (md5sum: f5edb84f00b9fcd1d059f04901eea7c5)
  * https://www.ubuntulinux.jp/download/ja-remix
* date
  * 2015/10/16

## [1] install Curl and git
#### [1-1]
* sudo apt-get install git
* sudo apt-get install curl
* sudo apt-get install emacs

## [2] install depot_tools
* http://www.chromium.org/developers/how-tos/install-depot-tools

### [2-1] clone depot_tools form git repository
* git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

### [2-2] set path
* export PATH=`pwd`/depot_tools:"$PATH"

## [3] checkout code
### [3-1]
* fetch mojo --target_os=android
* cd src
* ./build/install-build-deps.sh
* mojo/tools/mojob.py gn

### [4] Build and Run mojo on Linux
* ninja -C out/Debug -j 10
* out/Debug/mojo_shell mojo:spinning_cube

