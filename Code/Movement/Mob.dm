

// Movement
mob
	step_size = 2.5

	New()
		..()
		if(src.rotateIcon)
			src.i3d_originalTransform = transform // Used for the icon animation
			src.angle = 180
			src.i3d_rotateIcon()
			i3d_updateAngle()
	
	/**
		If a client is connected, it's a player. Send their new location to the
		browser
	**/
	i3d_Move()
		..()
		if(src.client && imagine3DView)
			i3d_updatePixelLoc()
			i3d_updateAngle()

	proc
		i3d_updatePixelLoc()
			// Adding half icon_size means we're sending the center point of the icon
			//var/vector/worldIconSizeVector = i3d_splitX(world.icon_size)
			var/I3D_PixelLoc/pixelLoc = new(src.pixloc.x, src.pixloc.y, src.pixloc.z)
			src.imagine3DView.setState("pixelLoc", JsonLib.serializeDm(pixelLoc))

		i3d_updateAngle()
			var/I3D_Angle/angle = new/I3D_Angle(src.angle)
			src.imagine3DView.setState("angle", JsonLib.serializeDm(angle))

