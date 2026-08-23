// Send map to I3D_View

mob
    proc
        initImagine3D(windowId, browserControlId)
            imagine3DView = new/I3D_View(windowId, browserControlId)
            src.client.drawLatestMap()