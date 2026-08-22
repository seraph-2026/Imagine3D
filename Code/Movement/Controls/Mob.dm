
mob
    proc
        updateMouseAngle()
            if(src.imagine3DView) // The view might not exist yet
                if(src.imagine3DView.state["angle"])
                    var/JsonAngle/jsonAngle = JsonLib.deserializeJson(src.imagine3DView.state["angle"])
                    angle = jsonAngle.j_angle
