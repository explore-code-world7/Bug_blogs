> transforms is a class to tranform images

* both T.AugmentationList() and T.Augmentation() can be applied as function for image tranfrom;

```python
# case to use T.AugmentationList()
from detectron2.data import transforms as T
# Define a sequence of augmentations:
augs = T.AugmentationList([
    T.RandomBrightness(0.9, 1.1),
    T.RandomFlip(prob=0.5),
    T.RandomCrop("absolute", (640, 640))
])  # type: T.Augmentation

# Define the augmentation input ("image" required, others optional):
input = T.AugInput(image, boxes=boxes, sem_seg=sem_seg)
# Apply the augmentation:
transform = augs(input)  # type: T.Transform
image_transformed = input.image  # new image
sem_seg_transformed = input.sem_seg  # new semantic segmentation

# For any extra data that needs to be augmented together, use transform, e.g.:
image2_transformed = transform.apply_image(image2)
polygons_transformed = transform.apply_polygons(polygons)
```
* extra data not in T.AugInput can be augmented using the returned transform, as shown in the above example

```python
# case to use T.Augmentation
class MyColorAugmentation(T.Augmentation):
    def get_transform(self, image):
        r = np.random.rand(2)
        return T.ColorTransform(lambda x: x * r[0] + r[1] * 10)

class MyCustomResize(T.Augmentation):
    def get_transform(self, image):
        old_h, old_w = image.shape[:2]
        new_h, new_w = int(old_h * np.random.rand()), int(old_w * 1.5)
        return T.ResizeTransform(old_h, old_w, new_h, new_w)

augs = MyCustomResize()
transform = augs(input)
```

## test flip
```python
# augs, input are defined as in previous examples
transform = augs(input)  # type: T.Transform
keypoints_xy = transform.apply_coords(keypoints_xy)   # transform the coordinates

# get a list of all transforms that were applied
transforms = T.TransformList([transform]).transforms
# check if it is flipped for odd number of times
do_hflip = sum(isinstance(t, T.HFlipTransform) for t in transforms) % 2 == 1
if do_hflip:
    keypoints_xy = keypoints_xy[flip_indices_mapping]
```

## test visibility

```python
transform = augs(input)  # type: T.TransformList
assert isinstance(transform, T.TransformList)
for t in transform.transforms:
    keypoints_xy = t.apply_coords(keypoints_xy)
    visibility &= (keypoints_xy >= [0, 0] & keypoints_xy <= [W, H]).all(axis=1)

# btw, detectron2's `transform_keypoint_annotations` function chooses to label such keypoints "visible":
# keypoints_xy = transform.apply_coords(keypoints_xy)
# visibility &= (keypoints_xy >= [0, 0] & keypoints_xy <= [W, H]).all(axis=1)
```

* `.all(axis=i)` means 取交按某个轴

