# Build Flutter

Flutter is exeutable multiplatform Linux and android ..etc by build it  yourself.

* https://github.com/flutter/engine/
* https://github.com/flutter/engine/blob/master/CONTRIBUTING.md

This is memo when I tried to install into ubuntu on vmware fusion. 

## Environment 
* ubuntu-ja-14.04-desktop-amd64.iso（ISOイメージ） (md5sum: f5edb84f00b9fcd1d059f04901eea7c5)
  * https://www.ubuntulinux.jp/download/ja-remix
* date
  * 2015/10/16
* vmware setting 
  * maybe, need storage 40GB
  * assign 2core and 4GB MEMORY

## [1] Install Curl and git and JDK
#### [1-1]
* sudo apt-get install git
* sudo apt-get install curl
* sudo apt-get install emacs

#### [1-2] install jdk
http://tecadmin.net/install-oracle-java-8-jdk-8-ubuntu-via-ppa/

* sudo add-apt-repository ppa:webupd8team/java
* sudo apt-get update
* sudo apt-get install oracle-java8-installer


## [2] Install depot_tools
* http://www.chromium.org/developers/how-tos/install-depot-tools

### [2-1] clone depot_tools form git repository
* git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

### [2-2] set path
* export PATH=`pwd`/depot_tools:"$PATH"

## [3] Checkout code
####[3-1]


## [4] Build and Run mojo on Linux
![](mono_na_sample.png)
* ninja -C out/Debug -j 10
* out/Debug/mojo_shell mojo:spinning_cube


## [5] Build and Run mojo on Android
### [5-1] install jdk
http://tecadmin.net/install-oracle-java-8-jdk-8-ubuntu-via-ppa/

* sudo add-apt-repository ppa:webupd8team/java
* sudo apt-get update
* sudo apt-get install oracle-java8-installer

### [5-2] build android env
* mojo/tools/mojob.py gn --android
* mojo/tools/mojob.py build --android

### [5-3] run sample app

![](screen.png)

* source build/android/envsetup.sh
* export PATH="$PATH":$MOJO_DIR/src/third_party/android_tools/sdk/platform-tools
* mojo/devtools/common/mojo_run https://core.mojoapps.io/spinning_cube.mojo --android



## [Memo]
### kill a process that use a particula port
* sudo netstat -lpn |grep :80
* sudo kill xxxx


### kill adb server
* adb kill-server

