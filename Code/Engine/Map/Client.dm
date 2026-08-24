client
    proc
        drawLatestMap()
            if(global_map) // Only proceed with update if a map exists
                /**
                    In the case the map doesn't exist, the world will notify the client when it does
                    That notification process will call this method again
                **/
                // Ensure we have the latest icon information
                loadIconsToBrowser()


        // Convert icons & states into pngs, load into client rsc file
        // RSC resources will be accessible in the browser
        loadIconsToBrowser()
            var/list/resourceList = global_map.j_resourceMap.j_resources // The map contains all the resources required
            
            for(var/I3D_Resource/nextResource in resourceList)
                var/icon/iconToStore = new(nextResource.icon, nextResource.icon_state)
                src.mob << browse_rsc(iconToStore, nextResource.j_png) 
                

