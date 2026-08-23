I3D_ClientState
    var
        I3D_StateComponent/I3D_BrowserState/j_browser
        mob/owner
        j_tickLag
        j_hasChanged

    New(windowId, controlId, mob/owner)
        src.j_browser = new(windowId, controlId)
        src.owner = owner
        j_tickLag = world.tick_lag
        j_hasChanged = 0

    proc
        initializeClientState()
            var/stateToSend = json_encode(JsonLib.serializeDm(src))
            owner << output(list2params(list("clientState", stateToSend)), "[src.j_browser.j_windowId].[src.j_browser.j_controlId]:i3d.browserView.initializeClientState")
    
        pollUntilReady()
            spawn()
                while(!src.j_browser.j_isReady)
                    initializeClientState()
                    sleep(10)

client
    verb
        setClientState(message as text)
            set hidden = 1
            set instant = 1
            world << "Recieved client state"
            var/I3D_ClientState/incomingClientState = JsonLib.deserializeJson(url_decode(message))
            incomingClientState.owner = src.mob
            src.mob.imagine3DView.clientState = incomingClientState



