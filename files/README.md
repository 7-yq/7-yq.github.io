# Binary files

Before the UM web account expires, run:

```bash
./scripts/fetch-umich-assets.sh
```

This downloads the current `photo.jpg` and `cv2.pdf` from the UM site into this directory and changes the homepage to use the local copies.

Until you run that script, the prepared `index.html` intentionally uses the existing UM-hosted photo and CV so the preview still works.
