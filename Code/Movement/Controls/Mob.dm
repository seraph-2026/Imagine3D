mob
    proc
        updateMouseAngle()
            if(src.imagine3DView) // The view might not exist yet
                var/JsonMapPixel/jsonMapPixel = JsonLib.deserializeJson(src.imagine3DView.state)
                angle = jsonMapPixel.j_angle