
mob
    Login()
        ..()
        winset(src, "window.pane-container", "left=3d-map-pane") // Show the 3d map by default

    verb
        map3dOnly()
            winset(src, "window.pane-container", "left=3d-map-pane") // Show the 3d map by default
            winset(src, "window.pane-container", "right=") // Show the 3d map by default

        map3dAndOutput()
            winset(src, "window.pane-container", "left=3d-map-pane") // Show the 3d map by default
            winset(src, "window.pane-container", "right=output-pane") // Show the 3d map by default

        fullscreen()
            winset(src, "window", "titlebar=false;is-maximized=true")
            winset(src, "window.pane-container", "left=3d-map-pane") // Show the 3d map by default

