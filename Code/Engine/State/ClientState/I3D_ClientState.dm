I3D_ClientState
    var
        I3D_StateComponent/I3D_BrowserState/j_browser
        mob/owner

    New(windowId, controlId, mob/owner)
        src.j_browser = new(windowId, controlId)
        src.owner = owner

    proc
        initializeClientState()
            var/stateToSend = json_encode(JsonLib.serializeDm(src))
            src.owner << output(list2params(list("clientState", stateToSend)), "[src.j_browser.j_windowId].[src.j_browser.j_controlId]:i3d.stateManager.initializeClientState")
    
        pollUntilReady()
            spawn(1)
                while(!src.j_browser.j_isReady)
                    sleep(1)
                    initializeClientState()
                
                // Give the user global settings in their game state
                global_settings.send(src.owner)

                // Intialize the player's coordinates
                var/I3D_PixelLoc/newPixelLoc = new(src.owner.pixloc.x, src.owner.pixloc.y, src.owner.pixloc.z)
                src.owner.i3d_view.gameState.j_player.j_pixelLoc = newPixelLoc
                src.owner.i3d_view.gameState.j_player.hasChanged = 1


client/Topic(href, list/href_list)
    ..()
    var/event = href_list["view-event"] // get the association of the element, "value"
    var/value = href_list["value"] // get the association of the element, "value"
    switch(event)
        if("setClientState")
            setClientState(value)

client
    proc
        setClientState(message)
            set instant = 1
            var/I3D_ClientState/incomingClientState = JsonLib.deserializeJson(url_decode(message))
            src.mob.i3d_view.clientState.j_browser = incomingClientState.j_browser
