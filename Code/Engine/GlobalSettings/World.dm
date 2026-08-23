

world
    New()
        ..()
        global_settings = new()

        for(var/client/nextClient)
            nextClient.mob.i3d_updateGlobalSettings()