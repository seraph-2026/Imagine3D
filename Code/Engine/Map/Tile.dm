
var/globalNextTileId = 0

Tile
    var
        j_id
        j_type
        j_floorResourceId
        j_ceilingResourceId
        j_wallResourceId

    New(turf/someTile)
        j_id = getId()
        j_type = "[someTile.type]"

        var/selectedFloorIcon
        var/selectedWallIcon
        var/selectedCeilingIcon

        // Floor icon
        if(someTile.i3d_floor_icon) 
            selectedFloorIcon = someTile.i3d_floor_icon
        else
            selectedFloorIcon = someTile.icon

        // Ceiling icon
        if(someTile.i3d_ceiling_icon)
            selectedCeilingIcon = someTile.i3d_ceiling_icon
        else
            selectedCeilingIcon = someTile.icon

        // Wall icon
        if(someTile.i3d_wall_icon) 
            selectedWallIcon = someTile.i3d_wall_icon
        else
            selectedWallIcon = someTile.icon

        j_floorResourceId = global_map.j_resourceMap.addNewResource(selectedFloorIcon, someTile.i3d_floor_icon_state, "floor")
        j_ceilingResourceId = global_map.j_resourceMap.addNewResource(selectedWallIcon, someTile.i3d_ceiling_icon_state, "ceiling")
        j_wallResourceId = global_map.j_resourceMap.addNewResource(selectedCeilingIcon, someTile.i3d_wall_icon_state, "wall")

    proc
        getId()
            if(isnull(j_id))
                j_id = globalNextTileId++

            return j_id