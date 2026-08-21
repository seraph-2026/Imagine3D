

Imagine3D
    proc
        // Called by the init function in this class
        registerTicks()
            src.registerTickProc("movementTick", null, src)
    
    proc
        movementTick()
            if(src.movementEnabled)
                for(var/atom/movable/someAtom) //loop over all currently connected clients
                    someAtom.i3d_Move()

