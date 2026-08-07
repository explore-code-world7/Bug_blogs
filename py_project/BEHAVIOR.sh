# set
./setup.sh --omnigibson --bddl --joylo --dataset --eval --primitives

TORCH_CUDA_ARCH_LIST="10.0+PTX" ./setup.sh --omnigibson --bddl --joylo --dataset --eval --primitives

TORCH_CUDA_ARCH_LIST="10.0+PTX"  

# verson修正
python -m pip install   "packaging==25.0"   "setuptools-scm>=6.2,<9"

# 安装lerobot
export PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple
git clone   --branch release/b1k   --single-branch   https://github.com/wensi-ai/lerobot.git   lerobot
python -m pip install -e --no-build-isolation --no-deps ".[dataset]"

# 安装curobo
git clone https://github.com/StanfordVL/curobo
cd curobo
git checkout 78612f45cef52c3fa0298de243a54cd7ca614414
git rev-parse HEAD
TORCH_CUDA_ARCH_LIST="10.0+PTX" python -m pip install -e --no-build-isolation --no-deps .


# set nvcc
export CUDA_HOME=/usr/local/cuda-12.8
export PATH="$CUDA_HOME/bin:$PATH"
export LD_LIBRARY_PATH="$CUDA_HOME/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
hash -r

# set代理
env -u http_proxy -u https_proxy     -u HTTP_PROXY -u HTTPS_PROXY     -u all_proxy -u ALL_PROXY \
   PIP_RETRIES=15 PIP_TIMEOUT=120\
    ./setup.sh       --omnigibson       --bddl       --joylo       --dataset       --eval       --primitives

# 设置git的config格式
git config --global http.version HTTP/1.1


# 指定CUDA架构
TORCH_CUDA_ARCH_LIST="10.0+PTX"


# 安装GCC/G++14
env \
  -u http_proxy -u https_proxy \
  -u HTTP_PROXY -u HTTPS_PROXY \
  -u all_proxy -u ALL_PROXY \
  conda install -c conda-forge \
    gcc_linux-64=14 \
    gxx_linux-64=14 \
    ninja \
    -y

export CC="$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-gcc"
export CXX="$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-g++"
export CUDAHOSTCXX="$CXX"

env \
  -u http_proxy -u https_proxy \
  -u HTTP_PROXY -u HTTPS_PROXY \
  -u all_proxy -u ALL_PROXY \
  CC="$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-gcc" \
  CXX="$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-g++" \
  CUDAHOSTCXX="$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-g++" \
  TORCH_CUDA_ARCH_LIST="10.0+PTX" \
  PIP_RETRIES=15 \
  PIP_TIMEOUT=120 \
  ./setup.sh \
    --omnigibson \
    --bddl \
    --joylo \
    --dataset \
    --eval \
    --primitives


## package conflict
python -m pip install \
  "click==8.1.7" \
  "pillow==11.3.0" \
  "psutil==5.9.8" \
  "typing-extensions==4.12.2" \
  "huggingface-hub==1.0.0" \
  "tyro==0.8.14" \
  "ipython<9" \
  "packaging==25.0" \
  "websockets==15.0.1" \
  "setuptools-scm>=6.2,<9"

python -m pip uninstall -y typeguard vcs-versioning

export HF_HUB_DISABLE_XET=1
export HF_HUB_DOWNLOAD_TIMEOUT=600
