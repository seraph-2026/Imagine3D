
mob
    proc
        updateMouseAngle()
            if(src.imagine3DView) // The view might not exist yet
                if(src.imagine3DView.state["angle"])
                    var/I3D_Angle/angle = JsonLib.deserializeJson(src.imagine3DView.state["angle"])
                    angle = angle.j_angle
