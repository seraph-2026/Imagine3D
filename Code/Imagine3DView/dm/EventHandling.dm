

        // /**
        //     Key Handling

        //     We'll need to forward all key events to the browserview
        // **/
        // captureKeyDown(id, eventAsList)
        //     var/Imagine3DView/browserView = registeredBrowserViews[id]
        //     var/keyCode = eventAsList["keyCode"]
        //     call(browserView, "keyDown")(keyCode)

        // captureKeyUp(id, eventAsList)
        //     var/Imagine3DView/browserView = registeredBrowserViews[id]
        //     var/keyCode = eventAsList["keyCode"]
        //     call(browserView, "keyUp")(keyCode)

/**
    Some events like reflectState contain too much text
    and can't be sent with BYOND.command.

    Topic is the way to send large volumes of text like
    the JSON state.
**/

client/Topic(href, href_list[])
    . = ..()
    if(href_list.len == 2)
        if(href_list["viewEvent"] == "reflectState")
            src.mob.captureEvent(href_list["value"])