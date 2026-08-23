// Useful for turning any angle into 0-<360
// So 370 degrees becomes 10 degrees
proc
    i3d_wrapAngle(angle)
        angle %= 360
        if(angle < 0)
            angle += 360
        return angle