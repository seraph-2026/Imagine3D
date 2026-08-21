

// Movement
mob
	step_size = 2

	New()
		..()
		if(src.rotateIcon)
			src.i3d_originalTransform = transform // Used for the icon animation
			src.angle = 180
			src.i3d_rotateIcon()
	
	/**
		If a client is connected, it's a player. Send their new location to the
		browser
	**/
	i3d_Move()
		..()
		if(src.client && imagine3DView)
			i3d_updatePlayerPosition()



