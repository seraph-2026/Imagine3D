
Imagine3D
    registerTicks()
        ..()
        src.registerTickProc("gameStateTick", null, src)
    
    proc
        gameStateTick()
            for(var/client/someClient) //loop over all currently connected clients
                if(someClient.mob.i3d_view.clientState.j_browser.j_isReady) // Only send game state when browser has initialized
                    someClient.mob.i3d_view.gameState.sendIfChanged()

