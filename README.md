# README

## Images

* Original images are in `working-images`.
* `working-images` is included in git but excluded from Docker.

## Curved `div` Edges

ChatGPT gave this, but it wasn't needed, because the concave versions by themselves give the effect I needed.

```css
.convex-down {
  height: 200px;
  aspect-ratio: 3/2;
  clip-path: ellipse(75% 100% at 50% 0%);
}

.convex-up {
  height: 200px;
  aspect-ratio: 3/2;
  clip-path: ellipse(75% 100% at 50% 100%);
}
```

### Font

Aloja -- I got it from here: https://www.dafontfree.io/aloja-handwritten-font-free-download/#google_vignette.
