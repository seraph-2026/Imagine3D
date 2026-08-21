
Imagine3D
    var
        preTickProcs = list()
        tickProcs = list()
        postTickProcs = list()

    proc
        registerPreTickProc(procName, procArgs, datum/parentDatum)
            preTickProcs += new/TickProc(procName, procArgs, parentDatum)

        registerTickProc(procName, procArgs, datum/parentDatum)
            tickProcs += new/TickProc(procName, procArgs, parentDatum)
  
        registerPostTickProcLast(procName, procArgs, datum/parentDatum)
            postTickProcs += new/TickProc(procName, procArgs, parentDatum)

world/Tick()
    ..()
    for(var/TickProc/nextTickProc in (Imagine3D.preTickProcs | Imagine3D.tickProcs | Imagine3D.postTickProcs))
        nextTickProc.runProc()