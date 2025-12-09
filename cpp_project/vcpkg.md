# Install vcpkg
```
$ git clone https://github.com/Microsoft/vcpkg.git
$ cd vcpkg
$ ./bootstrap-vcpkg.sh
```
* set as env variables
```
$echo 'export PATH="$PATH:/path/to/vcpkg"'>> ~/.bashrc
$ source ~/.bashrc
$ ./vcpkg integrate install
```
* install cpp lib
```
$ ./vcpkg install nanoflann
$ ./vcpkg install eigen3
```
