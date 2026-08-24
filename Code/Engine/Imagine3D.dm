var/Imagine3D/Imagine3D = new()

Imagine3D
    var
        icon_size_z

    proc
        setZIconSize(number)
            icon_size_z = number
        
        registerTicks() // Overriden by tick definitions

mob
    proc
        i3d_init(windowId, browserControlId)
            // Build them a browser
            src.i3d_view = new/I3D_View(windowId, browserControlId, src)

            // Draw 3D map in the browser
            src.client.drawLatestMap()
            
            /**
                Start running ticks which are used by the components of this library
                First one at the time of this comment was movement tick
            **/
            Imagine3D.registerTicks()
        
        i3d_enableWebDevTools()
            winset(src.client, null, "browser-options=devtools")

        i3d_disableWebDevTools()
            winset(src.client, null, "browser-options=")
