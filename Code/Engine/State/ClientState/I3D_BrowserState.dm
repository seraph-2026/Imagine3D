I3D_StateComponent/I3D_BrowserState
    var
        j_windowId
        j_controlId
        j_tickLag
        j_hasChanged
        j_isReady = FALSE
    
    New(windowId, controlId)
        src.j_windowId = windowId
        src.j_controlId = controlId
        j_tickLag = world.tick_lag
        j_hasChanged = 0
