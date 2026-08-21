// Contains a list of resources
ResourceMap
    var/list/j_resources = list()
    
    proc
        /**
            Promises to add a new resource if we don't already
            have it. In any case, returns j_id of resource.
        **/
        addNewResource(icon, icon_state)

            // No icon data provided?
            if(isnull(icon) || isnull(icon_state))
                return null
            
            // We already have the resource, return it
            for(var/Resource/resource in j_resources)
                if(resource.j_png == "[icon].[icon_state]")
                    return resource.j_id

            // Make a new resource because we don't have this yet
            var/Resource/newResource = new(icon, icon_state)
            j_resources += newResource
            return newResource.j_id