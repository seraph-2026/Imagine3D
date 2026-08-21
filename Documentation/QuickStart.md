
# Imagine 3D Documentation

Congratulations, you just installed Imagine3D. Great news for you, this is simple to use.

## Quickstart

To start your 3D adventure as quickly as possible, this is all you need.

```
mob.Login()
    i3d_init(src, "window","imagine-3d-browser")

turf
    Wall
        icon = "Icons.dmi"
        icon_sate = "Wall"

        i3d_wall_icon = 'Icons.dmi'
        i3d_wall_icon_state = "Wall"

    Room
        icon = "Icons.dmi"
        icon_sate = "Wall"
        
        i3d_floor_icon = 'Icons.dmi'
        i3d_floor_icon_state = "Floor"

        i3d_ceiling_icon = 'Icons.dmi'
        i3d_ceiling_icon_state = "Floor"
```

## The pattern

The whole library follows the same standardized pattern.

Library settings and procs are handled with a globally available object called Imagine3D
```
Imagine3D
```

Datums(DM Objects(mobs/obj etc)) get new procs beginning with i3d. 

Such as
```
mob.i3d_init(), 
mob.i3d_enableWebDevTools()
... (lots more)
```

Also there are a range of new variables available on datums. That start with i3d_
```
mob.i3d_controls.forward
turf.i3d_wall_icon
turf.i3d_wall_icon_state
... (lots more)
```