mob
    proc
        updateMouseAngle()
            if(i3d_view && i3d_view.clientState.j_browser.j_isReady)
                var/mouseAngle = i3d_view.clientState.j_browser.j_mouseAngle
                if(!isnull(mouseAngle))
                    src.angle = mouseAngle
                    i3d_rotateIcon()