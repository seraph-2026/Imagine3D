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
  
        registerPostTickProc(procName, procArgs, datum/parentDatum)
            postTickProcs += new/I3D_TickProc(procName, procArgs, parentDatum)