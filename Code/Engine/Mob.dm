// Send map to Imagine3DView

/**

**/
mob
    var/BrowserView/Imagine3DView/imagine3DView

    proc
        initImagine3D(windowId, browserControlId)
            imagine3DView = new/BrowserView/Imagine3DView(windowId, browserControlId)
            src.client.drawLatestMap()