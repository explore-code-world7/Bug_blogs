# 1. register a dataset

```python
def my_dataset_function():
  ...
  return list[dict] in the following format

from detectron2.data import DatasetCatalog
DatasetCatalog.register("my_dataset", my_dataset_function)
# later, to access the data:
data: List[Dict] = DatasetCatalog.get("my_dataset")
```
* standard dataset dicts
<img width="584" height="196" alt="image" src="https://github.com/user-attachments/assets/e6bbd265-f5b4-4ffd-b499-d7c1ec8343ec" />

* detailed keys: https://detectron2.readthedocs.io/en/latest/tutorials/datasets.html#

# 2. MetadataCatalog is used to record info related to specific dataset
