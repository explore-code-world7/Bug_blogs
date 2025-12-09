# use vcpkg
* Install vcpkg
```bash
$ git clone https://github.com/Microsoft/vcpkg.git
$ cd vcpkg
$ ./bootstrap-vcpkg.sh
```
* set as env variables
```bash
$echo 'export PATH="$PATH:/path/to/vcpkg"'>> ~/.bashrc
$ source ~/.bashrc
$ ./vcpkg integrate install
```
* install cpp lib
```bash
$ ./vcpkg install nanoflann
$ ./vcpkg install eigen3
```
* 把vcpkg安装的cpp库加入环境变量
```bash
$export eigen3_DIR=/home/chenlei/Project/DeepSDF/third-party/vcpkg/installed/x64-linux/share/eigen3
```


# use git 
* compile& install to system lib
```bash
git clone --recursive https://github.com/stevenlovegrove/Pangolin.git
cd  Pangolin/
mkdir build
cd build
cmake  ..
make
sudo make install
```
* test
```bash
ls /usr/local/include/pangolin
```
