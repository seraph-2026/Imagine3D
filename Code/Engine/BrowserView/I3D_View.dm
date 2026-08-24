mob
    var/I3D_View/i3d_view

I3D_View
    var
        htmlFile = 'Code/I3D_View/html/I3D_View.html'
        cssFiles = list('Code/I3D_View/css/I3D_View.css')
        jsFiles = list(
            'Code/I3D_View/build/imagine3d.bundle.js'
        )
        I3D_ClientState/clientState
        I3D_GameState/gameState
        mob/owner

        windowId
        controlId
        
        list/keyImpulses = list() // Queue of all the keys by their html key code

    New(windowId, controlId, mob/owner)
        src.owner = owner
        src.windowId = windowId
        src.controlId = controlId

        if(!windowId || !controlId)
            throw EXCEPTION("Failed to create I3D_View. Both window and control id are required to run I3D_View. Recieved: [windowId].[controlId] (window.controlId)")
            return

        src.clientState = new(windowId, controlId, src.owner)
        src.gameState = new(src.owner)
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

