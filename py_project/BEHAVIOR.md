> Collecting lerobot @ git+https://github.com/wensi-ai/lerobot@release/b1k (from lerobot[dataset] @ git+https://github.com/wensi-ai/lerobot@release/b1k->omnigibson==3.9.1)
  Cloning https://github.com/wensi-ai/lerobot (to revision release/b1k) to /tmp/pip-install-joyda6fe/lerobot_1a3dc6c6aae9418eb131d4c6b382a9c6
  Running command git clone --filter=blob:none --quiet https://github.com/wensi-ai/lerobot /tmp/pip-install-joyda6fe/lerobot_1a3dc6c6aae9418eb131d4c6b382a9c6
  Running command git checkout -b release/b1k --track origin/release/b1k
  error: RPC failed; curl 56 GnuTLS recv error (-9): Error decoding the received TLS packet.
  error: 6823 bytes of body are still expected
  fetch-pack: unexpected disconnect while reading sideband packet
  fatal: early EOF
  fatal: fetch-pack: invalid index-pack output

```bash
git config --global http.version HTTP/1.1
git config --global core.compression 0
conda activate behavior

git clone \
  --depth 1 \
  --single-branch \
  --branch release/b1k \
  https://github.com/wensi-ai/lerobot.git \
  ~/Project/Spa_Int/lerobot-b1k

python -m pip install \
  --retries 15 \
  --timeout 120 \
  --no-cache-dir \
  -e "$HOME/Project/Spa_Int/lerobot-b1k[dataset]"
```
