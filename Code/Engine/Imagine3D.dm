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
            src.imagine3DView = new/BrowserView/Imagine3DView(windowId, browserControlId)

            world << " src.imagine3DView [src.imagine3DView]"

            // Inform browser of player
            i3d_updatePlayerLocAndAngle()
            i3d_updateSettings()

            // Draw 3D map in the browser
            src.client.drawLatestMap()

            // Start running ticks which are used by the components of this library
            // First one at the time of this comment was movement tick
            Imagine3D.registerTicks()

        i3d_updatePlayerLocAndAngle()
            // Adding half icon_size means we're sending the center point of the icon
            //var/vector/worldIconSizeVector = i3d_splitX(world.icon_size)
            var/JsonMapPixel/jsonMapPixel = new/JsonMapPixel(src.pixloc.x, src.pixloc.y, src.pixloc.z, src.angle)
            src.imagine3DView.setState("playerPixelLocAndAngle", JsonLib.serializeDm(jsonMapPixel))

        i3d_updateSettings()
            src.imagine3DView.setState("settings", global_settings)
        
        i3d_enableWebDevTools()
            winset(src.client, null, "browser-options=devtools")

        i3d_disableWebDevTools()
            winset(src.client, null, "browser-options=")
