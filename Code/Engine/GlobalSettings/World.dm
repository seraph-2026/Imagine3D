var/I3D_GlobalSettings/global_settings

world
    New()
        ..()
        global_settings = new()

        for(var/client/nextClient)
            nextClient.mob.i3d_updateGlobalSettings()