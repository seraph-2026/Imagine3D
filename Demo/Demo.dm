world
	fps = 60
	view = "15x15"
	mob = /mob/Player
	icon_size = 64

	New()
		..()
		Imagine3D.enableMovement()
		Imagine3D.enableMouseLook()

mob/Player
	icon = 'Icons.dmi'
	icon_state = "Player"
	rotateIcon = TRUE

	Login()
		..()
		//Move(locate(30,30,1))
		Move(locate(30,30,1))

		// Run Imagine 3D
		i3d_init("window","imagine-3d-browser")
		i3d_enableWebDevTools()
		
