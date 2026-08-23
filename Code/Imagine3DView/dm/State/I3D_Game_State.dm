
I3D_GameState
    var
        I3D_StateComponent/I3D_BrowserState/j_browser
        I3D_StateComponent/I3D_Player/j_player
        I3D_StateComponent/I3D_Map/j_map
        I3D_StateComponent/I3D_GlobalSettings/j_global_settings

        mob/owner

    New(windowId, controlId, mob/owner)

        src.j_browser = new(windowId, controlId)
        src.j_browser.hasChanged = TRUE

        src.j_player = new()
        src.j_map = new()
        src.j_global_settings = new()

        src.owner = owner
    
    proc
        send()
            var/I3D_GameState/newState = new(src.j_browser.j_windowId, src.j_browser.j_controlId, src.owner)
            var/stateHasChanged = FALSE

            if(j_browser.hasChanged)
                newState.j_browser = src.j_browser
                stateHasChanged = TRUE
                src.j_browser.hasChanged = FALSE

            if(j_player.hasChanged)
                newState.j_player = src.j_player
                stateHasChanged = TRUE
                src.j_player.hasChanged = FALSE

            if(j_map.hasChanged)
                newState.j_map = src.j_map
                stateHasChanged = TRUE
                src.j_map.hasChanged = FALSE
            
            if(j_global_settings.hasChanged)
                newState.j_global_settings = src.j_global_settings
                stateHasChanged = TRUE
                src.j_global_settings.hasChanged = FALSE
            
            if(stateHasChanged)
                world << "sending state: [j_browser.j_windowId].[j_browser.j_controlId]:view.setState"
                var/newStateValue = json_encode(JsonLib.serializeDm(newState))
                world << "[newStateValue]"
                owner << output(newStateValue, "[src.j_browser.j_windowId].[src.j_browser.j_controlId]:view.setGameState")
