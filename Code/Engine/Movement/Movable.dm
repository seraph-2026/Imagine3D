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
			var/x = 0
			var/y = 0

			// Forward/backward
			if(src.i3d_controls.forward)
				x += sin(angle)
				y += cos(angle)

			if(src.i3d_controls.backward)
				x -= sin(angle)
				y -= cos(angle)

			// Turning takes priority over strafing.
			// If we're turning, don't strafe.
			if(src.i3d_controls.turnLeft && !src.i3d_controls.turnRight)
				i3d_rotateLeft()

			else if(src.i3d_controls.turnRight && !src.i3d_controls.turnLeft)
				i3d_rotateRight()

			// Otherwise, allow strafing.
			else
				if(src.i3d_controls.leftStrafe)
					x -= cos(angle)
					y += sin(angle)

				if(src.i3d_controls.rightStrafe)
					x += cos(angle)
					y -= sin(angle)

			// Normalize and apply speed
			var/length = sqrt(x * x + y * y)

			if(length > 0)
				x /= length
				y /= length

				x *= moveSpeed
				y *= moveSpeed

				step(src, new/vector(x, y))

		i3d_rotateLeft()
			angle = i3d_wrapAngle(angle - turnSpeed)
			i3d_rotateIcon()

		i3d_rotateRight()
			angle = i3d_wrapAngle(angle + turnSpeed)
			i3d_rotateIcon()

		i3d_rotateIcon() // Match the icon's angle of rotation to the players angle.
			if(rotateIcon)
				src.transform = turn(i3d_originalTransform, i3d_wrapAngle(angle))