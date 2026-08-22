
Imagine3D
    var
        preTickProcs = list()
        tickProcs = list()
        postTickProcs = list()

    proc
        registerPreTickProc(procName, procArgs, datum/parentDatum)
            preTickProcs += new/I3D_TickProc(procName, procArgs, parentDatum)

        registerTickProc(procName, procArgs, datum/parentDatum)
            tickProcs += new/I3D_TickProc(procName, procArgs, parentDatum)
  
        registerPostTickProcLast(procName, procArgs, datum/parentDatum)
            postTickProcs += new/I3D_TickProc(procName, procArgs, parentDatum)

world/Tick()
    ..()
    for(var/I3D_TickProc/nextTickProc in (Imagine3D.preTickProcs | Imagine3D.tickProcs | Imagine3D.postTickProcs))
        nextTickProc.runProc()