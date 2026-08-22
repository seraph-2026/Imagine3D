

Imagine3D
    registerTicks()
        ..()
        src.registerPreTickProc("controlsTick", null, src)
    
    proc
        controlsTick()
            if(global_settings.j_mouseLookEnabled)
                for(var/client/someClient) //loop over all currently connected clients
                    someClient.mob.updateMouseAngle()

