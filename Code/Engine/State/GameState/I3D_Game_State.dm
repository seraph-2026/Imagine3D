
I3D_GameState
    var
        I3D_StateComponent/I3D_Player/j_player
        I3D_StateComponent/I3D_Map/j_map
        I3D_StateComponent/I3D_GlobalSettings/j_global_settings

        mob/owner

        hasChanged = FALSE

    New(mob/owner)
        src.j_player = new("Player")
        src.j_map = global_map
        src.j_global_settings = global_settings

        src.owner = owner
    
    proc
        sendIfChanged()
            if(j_player.hasChanged)
                src.j_player.hasChanged = FALSE
                j_player.send(owner)

            if(j_map.hasChanged)
                world << "Map changed"
                src.j_map.hasChanged = FALSE
                j_map.send(owner)
            
            if(j_global_settings.hasChanged)
                src.j_global_settings.hasChanged = FALSE
                j_global_settings.send(owner)