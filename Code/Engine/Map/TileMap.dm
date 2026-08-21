
TileMap
    var/list/j_tiles = list()

    proc
        addTile(turf/tile)
            // Do we have this tile already loaded?
            for(var/Tile/existingTile in j_tiles)
                // We have the same tile already
                if(existingTile.j_type == "[tile.type]")

                    // In future this needs to support tiles that don't share all the same
                    // variables but that have the same type.
                    // Not going to do this in the first iteration

                    // Return this tile's id
                    return existingTile.j_id
            
            // Unable to find existing tile, make one
            var/Tile/newTile = new(tile)
            j_tiles += newTile
            return newTile.j_id
