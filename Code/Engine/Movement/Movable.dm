atom/movable
	var
		angle = 0
		moveSpeed = 2
		turnSpeed = 2.5
		rotateIcon = FALSE

		// For icon rotation only
		i3d_originalTransform

	proc
		i3d_Move() // Called from tick
			if(src.i3d_controls.forward && !src.i3d_controls.backward)
				i3d_moveForward()
			else if(src.i3d_controls.backward)
				i3d_moveBackward()

			// TODO: Change to strafe
			if(src.i3d_controls.leftStrafe && !src.i3d_controls.rightStrafe)
				i3d_rotateLeft()
			else if(src.i3d_controls.rightStrafe)
				i3d_rotateRight()

		i3d_wrapAngle(angle)
			angle %= 360
			if(angle < 0)
				angle += 360
			return angle

		i3d_moveForward()
			var/x = sin(angle) * moveSpeed
			var/y = cos(angle) * moveSpeed
			step(src, new/vector(x, y))

		i3d_moveBackward()
			var/x = sin(angle) * moveSpeed
			var/y = cos(angle) * moveSpeed
			step(src, new/vector(-x, -y))

		i3d_rotateLeft()
			angle = i3d_wrapAngle(angle - turnSpeed)
			i3d_rotateIcon()

		i3d_rotateRight()
			angle = i3d_wrapAngle(angle + turnSpeed)
			i3d_rotateIcon()

		i3d_rotateIcon() // Match the icon's angle of rotation to the players angle.
			if(rotateIcon)
				src.transform = turn(i3d_originalTransform, i3d_wrapAngle(angle))
