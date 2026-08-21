
var/Map/global_map

Map
    var
        j_icon_size_x
        j_icon_size_y

        ResourceMap/j_resourceMap
        TileMap/j_tileMap
        list/j_tileIdMap[world.maxx][world.maxy][world.maxz]

    proc
        update()
            setIconSize() // Used to make pixel calculations

            // Ensure we have a resource map
            if(isnull(j_resourceMap))
                j_resourceMap = new()

            // Ensure we have a tile map
            if(isnull(j_tileMap))
                j_tileMap = new()

            for(var/x in 1 to world.maxx)
                for(var/y in 1 to world.maxy)
                    for(var/z in 1 to world.maxz)
                        var/turf/tile = locate(x,y,z)
                        var/tileId = j_tileMap.addTile(tile)
                        j_tileIdMap[x][y][z] = tileId
            
            // Inform all the clients that the map has updated
            world.informClientsOfMapUpdate()
        
        setIconSize()
            if(isnum(world.icon_size))
                j_icon_size_x = world.icon_size
                j_icon_size_y = world.icon_size

            else if(istext(world.icon_size))
                var/list/splitIconSize = splittext(world.icon_size, "x")
                j_icon_size_x = splitIconSize[0]
                j_icon_size_y = splitIconSize[1]
            
            



