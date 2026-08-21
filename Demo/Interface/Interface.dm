mob
    Login()
        ..()

    var
        showFullScreen = FALSE
        show2DMap = FALSE
        showOutput = FALSE

    verb
        show3dMap()
            winset(src, "window.output", "is-visible=false")
            winset(src, "map-window", "is-visible=false")
            show2DMap = FALSE

        show2dMap()
            if(!show2DMap)
                winset(src, "map-window", "is-visible=true")
                show2DMap = TRUE
            else
                winset(src, "map-window", "is-visible=false")
                show2DMap = FALSE

        showOutput()
            if(!showOutput)
                showOutput = TRUE
                winset(src, "window.output", "is-visible=true")
            else
                showOutput = FALSE
                winset(src, "window.output", "is-visible=false")

        showFullScreen()
            if(showFullScreen)
                winset(src, "window", "is-fullscreen=false")
                showFullScreen = FALSE
            else
                winset(src, "window",  "is-fullscreen=true")
                showFullScreen = TRUE
