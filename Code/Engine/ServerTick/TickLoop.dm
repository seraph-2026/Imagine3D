

world/Tick()
    ..()
    for(var/I3D_TickProc/nextTickProc in (Imagine3D.preTickProcs | Imagine3D.tickProcs | Imagine3D.postTickProcs))
        nextTickProc.runProc()