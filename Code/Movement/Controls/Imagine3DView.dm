
/**
    Viewmanager sends these events to the browser view,
    calling them directly

    These can be retrieved from mob.imagine3DView
**/
BrowserView/Imagine3DView
    var/list/keyImpulses = list() // Queue of all the keys by their html key code

    proc
        keyDown(htmlKeyCode)
            if(Imagine3D.captureImpulses)
                keyImpulses += htmlKeyCode

        keyUp(htmlKeyCode)
            if(Imagine3D.captureImpulses)
                keyImpulses += htmlKeyCode + "+UP" // +UP is a DM standard
