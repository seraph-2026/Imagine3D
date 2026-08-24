
var/I3D_StateComponent/I3D_GlobalSettings/global_settings
            
world
    New()
        ..()
        global_settings = new("GlobalSettings")

        for(var/client/nextClient)
            global_settings.send(nextClient.mob)

I3D_StateComponent/I3D_GlobalSettings
    var
        j_mouseLookEnabled = FALSE

    New(mouseLookEnabled)
        j_mouseLookEnabled = mouseLookEnabled
    