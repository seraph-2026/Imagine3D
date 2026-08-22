# Icon state in 3D

## Floor

Specifies the icon to draw on the 1 bottom side of the cube tile in 3d.

i3d_floor_icon
i3d_floor_icon_state

## Wall

Specifies the icon to draw on the 4 sides of the cube tile in 3d.

i3d_wall_icon
i3d_wall_icon_state

## Ceiling

Specifies the icon to draw on the 1 top side of the cube tile in 3d.

i3d_ceiling_icon
i3d_ceiling_icon_state

# Flickering effect

If you're getting a flickering effect on any of these, it's like you're giving the same location 2 different icons

This could happen if you have a block above with a floor, a block below with just a ceiling. The engine won't know
if it needs to render the floor icon or the ceiling icon. This causes the flicker effect (aka z fighting). Ensure at
any location in the cube map that there is only one icon.
