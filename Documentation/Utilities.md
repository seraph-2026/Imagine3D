# Utilities

There are a number of utility functions that are made available but aren't required for you to use the library.

If you'd like to use them, you can. It's optional.

## i3d_SplitX(numOrString)

Accepts values like 32 or "32x32" and returns a vector with x and y.

32 becomes vector.x = 32, vector.y = 32
"32x64" because vector.x = 32, vector.y = 64

There are a number of places this is helpful. For example world.icon_size.