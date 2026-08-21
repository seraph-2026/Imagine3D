
world
    New()
        ..()
        global_map = new/Map()
        global_map.update()

    proc
        informClientsOfMapUpdate()
            spawn(10) // Just for the beginning
                for(var/mob/nextMob in world)
                    if(nextMob.client)
                        var/client/nextClient = nextMob.client
                        nextClient.drawLatestMap()
