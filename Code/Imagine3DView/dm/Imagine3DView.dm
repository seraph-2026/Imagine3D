Imagine3DView
    var
        htmlFile = 'Code/Imagine3DView/html/Imagine3DView.html'
        cssFiles = list('Code/Imagine3DView/css/Imagine3DView.css')
        jsFiles = list(
            'Code/Imagine3DView/build/imagine3d.bundle.js'
        )
        I3D_ClientState/clientState
        I3D_ClientState/gameState
        mob/owner

        windowId
        controlId
        
        list/keyImpulses = list() // Queue of all the keys by their html key code

    New(windowId, controlId, mob/owner)
        src.owner = owner
        src.windowId = windowId
        src.controlId = controlId

        if(!windowId || !controlId)
            throw EXCEPTION("Failed to create Imagine3DView. Both window and control id are required to run Imagine3DView. Recieved: [windowId].[controlId] (window.controlId)")
            return

        src.clientState = new(windowId, controlId, src.owner)
        createBrowser()
        loadFiles()
        render()
        
        src.clientState.pollUntilReady()

    proc
        // Create a new browser control in the interface
        createBrowser()
            // If a browser doesn't already exist create one
            if(!winexists(owner, "[windowId].[controlId]"))
                winset(owner, "[windowId].[controlId]", "parent=[windowId];type=browser;focus=false")

            if(!winexists(owner, "[windowId].[controlId]"))
                throw EXCEPTION("Unable to create or hook into existing control by id: [windowId].[controlId] (windowId:controlId)")
            // If a browser does exist, there's no task to do here.

        loadFiles()
            owner << browse_rsc(htmlFile) // HTML
            
            for(var/cssFile in cssFiles) // CSS
                owner << browse_rsc(cssFile)

            for(var/jsFile in jsFiles) // JavaScript
                owner << browse_rsc(jsFile)

        // Output the complete document to the browser component
        render()
            var/rawHtml = file2text(htmlFile)
            owner << output(rawHtml, "[windowId].[controlId]")

        setState()
            //world << "setState is stubbed"

        keyDown(htmlKeyCode)
            if(Imagine3D.captureImpulses)
                keyImpulses += htmlKeyCode

        keyUp(htmlKeyCode)
            if(Imagine3D.captureImpulses)
                keyImpulses += htmlKeyCode + "+UP" // +UP is a DM standard
