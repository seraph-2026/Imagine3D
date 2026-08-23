// Send map to Imagine3DView

mob
    proc
        initImagine3D(windowId, browserControlId)
            imagine3DView = new/Imagine3DView(windowId, browserControlId)
            src.client.drawLatestMap()