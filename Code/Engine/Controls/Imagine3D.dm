Imagine3D

    // Won't start capturing keys until someone asks for keys first
    var/captureImpulses = FALSE 
    var/mouseLookEnabled = FALSE

    // Keys are stored in the relevant browser view of the player
    proc
        getKeyImpulses(var/mob/player)
            // Once we start capturing impulses from the browser, don't stop
            captureImpulses = TRUE
            
            // It's possible the browser doesn't exist yet
            if(player.i3d_view)
                return player.i3d_view.keyImpulses
            else
                return list() 

        clearKeyImpulses(var/mob/player)
            
            if(player.i3d_view)
                player.i3d_view.keyImpulses.len = 0
            else
                return list()

        enableMouseLook()
            global_settings.j_mouseLookEnabled = TRUE