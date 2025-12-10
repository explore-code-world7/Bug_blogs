# hf download
```bash
hf download ShapeNet/ShapeNetCore --repo-type=dataset \
    --local-dir ./ --max-workers 4
```

# snapshot_download
```
from huggingface_hub import snapshot_download

snapshot_download(
    repo_id="ShapeNet/ShapeNetCore",
    repo_type="dataset",
    local_dir="./ShapeNetCore",
    max_workers=4,
    allow_patterns="*",  # 可以也只下部分文件
```
