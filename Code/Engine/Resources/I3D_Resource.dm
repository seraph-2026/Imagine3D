

var/globalNextResourceId = 0

I3D_Resource
    var
        j_id
        j_png // Auto generated png name, accessible in the browser
        j_usage // Designates where this resource will be applied. Wall floor, ceiling, what application?
    
        icon
        icon_state
    
    New(icon, icon_state, usage)
        getId()
        src.icon = icon
        src.icon_state = icon_state
        j_png = "[icon].[icon_state].png"
        j_usage = usage
    
    proc
        getId()
            if(isnull(j_id))
                j_id = globalNextResourceId++

            return j_id