
TickProc
    var
        procName
        procType
        procArgs
        parentObject
    
    New(procNameOrType, procArgs, parentObject)

        // If this is for an object, we need a string
        if(istext(procNameOrType))
            src.procName = procNameOrType
        
        // Otherwise it should be a /proc/type/ format
        else
            src.procType = procNameOrType

        src.procArgs = procArgs // Args might be null
        src.parentObject = parentObject // Parent datum might be nul

        if(!procName && !procType)
            throw EXCEPTION("Missing proc name or proc type. In Imagine3D tick definition")
            return null
    
    proc
        runProc()
            if(src.parentObject)

                call(parentObject, procName)(procArgs)
            else

                call(procType)(procArgs)
                    