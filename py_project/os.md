

# 加快删除
✅ 批量删除（一次 rm）比大量分散地逐个删除快吗？

非常快。差别可以达到几十倍。

为什么？

📌 原因 1：每次删除一个文件都要修改目录 inode（昂贵的目录操作）
删除文件成本主要不是删除数据，而是：
* 在父目录中查找该文件名
* 修改父目录的目录项
* 修改 inode 表
* 更新 journal（ext4 日志）
每删除一个文件都要跑这一套流程。
成百上千小文件 → 成百上千次重复动作 → 慢得惊人。

📌 原因 2：EXT4 的目录结构是 hashtable + log journaling

删除 1 个文件 = 写 journal
删除 10000 个文件 = 写 10000 次 journal

而 rm 一次删 10000 个文件：

→ 目录项被批量修改
→ journal 触发次数更少
→ EXT4 自己可优化操作顺序


原因 3：Python 循环 os.remove() 非常慢

逐个执行：

os.remove("file1.pkl")
os.remove("file2.pkl")
...


每次调用都发生：

Python → C → kernel 调用

系统调用开销巨大

上万次调用等于上万次系统调用。

rm 直接由 shell 内建实现，一条命令发给 kernel → 极快。

## 方法 1：用 subprocess 调用 rm（最推荐，最快）
```python
import subprocess
import glob

files = glob.glob("/path/to/traj/*.pkl")
subprocess.run(["rm", "-f"] + files)
```

这样 Python 不执行 N 次系统调用，而是 只调用一次 rm。


### 方法 2：先将文件移动到一个临时目录，再整体删除（超快）
删除目录比删除目录里的很多文件快得多：
```python
import shutil
import os
import uuid

src_dir = "/path/to/traj"
tmp_dir = f"/tmp/delete_{uuid.uuid4()}"

# 1. rename 目录（几乎即时）
os.rename(src_dir, tmp_dir)

# 2. 再后台删除 tmp_dir
shutil.rmtree(tmp_dir)
```

因为 rename 是 O(1)，不会受目录中文件个数影响。
再删除整个目录，EXT4 可以批量处理，速度比逐文件快得多。
