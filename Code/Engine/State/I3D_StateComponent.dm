
// Individual parts that together make up the I3D_State
I3D_StateComponent
    var
        name
        hasChanged = FALSE // So we send only state components that have changed

    New(name)
        src.name = name

    proc/send(mob/player)
        var/stateToSend = json_encode(JsonLib.serializeDm(src))
        var/I3D_ClientState/clientState = player.i3d_view.clientState
        var/destination = "[clientState.j_browser.j_windowId].[clientState.j_browser.j_controlId]:i3d.stateManager.update[name]State"
        player << output(list2params(list("[name]State", stateToSend)), destination)

