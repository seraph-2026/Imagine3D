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
            owner << output(list2params(list("clientState", stateToSend)), "[src.j_browser.j_windowId].[src.j_browser.j_controlId]:i3d.browserView.initializeClientState")
    
        pollUntilReady()
            spawn()
                while(!src.j_browser.j_isReady)
                    initializeClientState()
                    world << src.toJsonString()
                    sleep(100)

client
    verb
        setClientState(message as text)
            set hidden = 1
            set instant = 1

            var/I3D_ClientState/incomingClientState = JsonLib.deserializeJson(url_decode(message))
            src.mob.imagine3DView.clientState.j_browser = incomingClientState.j_browser

            world << "\nFinal client state [src.mob.imagine3DView.clientState.toJsonString()]"
