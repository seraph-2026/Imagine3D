

// Movement
mob
	step_size = 2.5

	New()
		..()
		if(src.rotateIcon)
			src.i3d_originalTransform = transform // Used for the icon animation
			src.angle = 180
			src.i3d_rotateIcon()
	
