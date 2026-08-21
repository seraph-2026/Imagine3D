
/**
    Keeps track of any existing BrowserView elements
**/

ViewManager
    var
        mob/owner   // The mob connected to the client at the time this component was created
        list/registeredBrowserViews = list() // All the BrowserViews that exist.
    
    New()
        owner = usr.client.mob

    proc
        // Add the browseriew to list of stored views and return an id
        registerBrowserView(BrowserView/browserView)
            registeredBrowserViews += browserView
            return registeredBrowserViews.len

        // Get any BrowserView returned by providing a valid id
        getBrowserViewById(id as num)
            return registeredBrowserViews[id]

        // Sets the isReady variable inside of a BrowserView based on a specific id
        setViewIsReady(id as num)
            var/BrowserView/browserView = registeredBrowserViews[id]
            browserView.setIsReady()
        
        // The json decoded state of the window.view.state will be stored in the BrowserView
        // I called this reflecting the state because it reflects the state back into DM
        reflectState(id, stateAsList)
            var/BrowserView/browserView = registeredBrowserViews[id]
            browserView.reflectState(stateAsList)
        
        // Removes any reference to the BrowserView from the manager
        deleteBrowserView(id as num)
            registeredBrowserViews[id] = null // Keeps the ordering of ids the same
        
        // This will call a proc, in the BrowserView by the name [eventName]
        captureEvent(id, eventAsList)
            var/BrowserView/browserView = registeredBrowserViews[id]
            var/eventName = eventAsList["name"]

            call(browserView, eventName)()

        /**
            Key Handling

            We'll need to forward all key events to the browserview
        **/
        captureKeyDown(id, eventAsList)
            var/BrowserView/browserView = registeredBrowserViews[id]
            var/keyCode = eventAsList["keyCode"]
            call(browserView, "keyDown")(keyCode)

        captureKeyUp(id, eventAsList)
            var/BrowserView/browserView = registeredBrowserViews[id]
            var/keyCode = eventAsList["keyCode"]
            call(browserView, "keyUp")(keyCode)
