
// Ensure all mobs have access to the possibility of a ViewManager
// We don't know what mob might be used by a player
mob
    var
        ViewManager/viewManager
    
    // If we've logged into a mob, that's going to be used for our ViewManager
    Login() 
        ..()
        viewManager = new/ViewManager()
    
    // Remove view managers we don't need anymore
    Logout()
        ..()
        viewManager = null

    verb
        // Tell ViewManager to tell BrowserView[id] to set it's ready state  
        setBrowserViewIsReady(id as text)
            set hidden = 1
            viewManager.setViewIsReady(text2num(id))

        // Tell ViewManager to tell BrowserView[id] to reflect the state given in window.view.state
        reflectState(jsonStringState as text)
            set hidden = 1

            world << "jsonStringState [url_decode(jsonStringState)]"
            var/decodedState = json_decode(url_decode(jsonStringState))
            viewManager.reflectState(decodedState["browserViewId"], decodedState)
        
        // Redirect JS errors to world.log, converting it into a DM style error
        logJSError(error as text)
            set hidden = 1
            world.log << error

        // Redirect JS logs to the user, converting it into a dm style log
        logJS(message as text)
            set hidden = 1
            src << message

        // Tell ViewManager to tell the BrowserView to run a proc by the name [eventName]
        captureEvent(jsonStringEvent as text)
            set hidden = 1
            set instant = 1

            var/decodedEvent = json_decode(jsonStringEvent)
            viewManager.captureEvent(decodedEvent["browserViewId"], decodedEvent)

        /**
            Key Handling

            We'll need to forward all key events to the browserview
        **/
        captureKeyDown(jsonStringEvent as text)
            set hidden = 1
            set instant = 1

            var/decodedEvent = json_decode(jsonStringEvent)
            viewManager.captureKeyDown(decodedEvent["browserViewId"], decodedEvent)

        captureKeyUp(jsonStringEvent as text)
            set hidden = 1
            set instant = 1

            var/decodedEvent = json_decode(jsonStringEvent)
            viewManager.captureKeyUp(decodedEvent["browserViewId"], decodedEvent)