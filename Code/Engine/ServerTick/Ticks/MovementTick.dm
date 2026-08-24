

Imagine3D
    registerTicks()
        ..()
        src.registerTickProc("movementTick", null, src)
    
    proc
        movementTick()
            if(src.movementEnabled)
                for(var/atom/movable/someAtom) // Loop all atoms
                    someAtom.i3d_Move()
            
            // Update pixel location & angle if it has changed
            for(var/client/nextClient)
                var/mob/player = nextClient.mob
                var/I3D_ClientState/clientState = player.i3d_view.clientState
                var/I3D_GameState/gameState = player.i3d_view.gameState

                if(clientState.j_browser.j_isReady)
                    var/I3D_StateComponent/I3D_Player/playerState = player.i3d_view.gameState.j_player
                    var/I3D_PixelLoc/newPixelLoc = new(player.pixloc.x, player.pixloc.y, player.pixloc.z)
                    var/I3D_PixelLoc/oldPixelLoc = gameState.j_player.j_pixelLoc
                    
                    if(newPixelLoc.j_x != oldPixelLoc.j_x || newPixelLoc.j_y != oldPixelLoc.j_y || newPixelLoc.j_z != oldPixelLoc.j_z)
                        playerState.j_pixelLoc = newPixelLoc
                        playerState.hasChanged = 1
                    
                    if(playerState.j_rotation.j_angle != player.angle)
                        playerState.j_rotation.j_angle = player.angle
                        playerState.hasChanged = 1


