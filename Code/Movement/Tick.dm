

Imagine3D
    registerTicks()
        ..()
        src.registerTickProc("movementTick", null, src)
    
    proc
        movementTick()
            if(src.movementEnabled)
                for(var/atom/movable/someAtom) // Loop all atoms
                    someAtom.i3d_Move()

