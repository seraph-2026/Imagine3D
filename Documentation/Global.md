
## Imagine3D.enableMovement()

By using this it will switch on the movement system that comes with Imagine3D. From then on, if you change the i3d_controls
variable on any atom/movable. They will move in the next tick based on this controls.

For example, setting jim.i3d_controls.forward = TRUE will cause the atom named jim to forward by his i3d_move_speed at his
i3d_angle(degrees) in the next world.Tick(). Setting jim.i3d_controls.forward = FALSE conversely stops jim from moving in
his forward along his angle.

## Imagine3D.disableMovement()

See Imagine3D.enableMovement() for more details. This simply deactivates the built-in movement system. This strongly disables
any related funcitonality. The only internal work happening now is to check that the movement is deactivated, then immediately
return.
