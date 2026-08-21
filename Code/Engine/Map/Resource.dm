

var/globalNextResourceId = 0

Resource
    var
        j_id
        j_png
        icon
        icon_state
    
    New(icon, icon_state)
        getId()
        src.icon = icon
        src.icon_state = icon_state
        j_png = "[icon].[icon_state].png"
    
    proc
        getId()
            if(isnull(j_id))
                j_id = globalNextResourceId++

            return j_id