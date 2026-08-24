

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

                if(player.i3d_view.clientState.j_browser.j_isReady)
                    var/I3D_StateComponent/I3D_Player/playerState = player.i3d_view.gameState.j_player
                    var/I3D_PixelLoc/newPixelLoc = new(player.pixloc.x, player.pixloc.y, player.pixloc.z)

                    if(newPixelLoc.j_x != player.pixloc.x || newPixelLoc.j_y != player.pixloc.y || newPixelLoc.j_z != player.pixloc.z)
                        world << "Coordinates changed"
                        playerState.j_pixelLoc = newPixelLoc
                        playerState.hasChanged = 1
                    
                    if(playerState.j_rotation.j_angle != player.angle)
                        world << "Angle changed"
                        playerState.j_rotation.j_angle = player.angle
                        playerState.hasChanged = 1


