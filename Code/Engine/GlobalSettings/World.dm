
mob
    proc
        i3d_updateGlobalSettings()
            src.i3d_view.setState("settings", JsonLib.serializeDm(global_settings))
            
world
    New()
        ..()
        global_settings = new()

        for(var/client/nextClient)
            nextClient.mob.i3d_updateGlobalSettings()