// Send map to I3D_View

mob
    proc
        initImagine3D(windowId, browserControlId)
            i3d_view = new/I3D_View(windowId, browserControlId)
            src.client.drawLatestMap()