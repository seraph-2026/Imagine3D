/**
    Displays html + js in a browser

    Sets JS state
**/

/**
 * 
 */
BrowserView
    var
        id              // Uniquely registers this with the view manager (automatically)
        mob/owner       // The mob of the client who made this BrowserView
        isReady = FALSE // If the javascript has successfully run in the Browser, this turns to true
        list/state      // Contains the JSON decoded state of the window.view.state (automatically)

        windowName      // The window of the browser control
        controlId       // The browser control containing this view
        skinParams      // Controls the skin parameters of the browser control
        refocusControl  // The name of a control in [window].[control] format that cursor focus should move to any time this control is clicked

        htmlFile        // The html file to render
        cssFiles        // A list of css files to insert
        baseScriptFiles // A  list of script files to insert AT the ROOT level, they run before everything else except initial scripts
        scriptFiles     // A list of script files loaded into the rsc, for reference in htl

        rawHTML = ""    // The HTML that got delivered to the BrowserView, the last time it rendered
        rawInitialScript = "" // These load after required scripts
        rawRequiredScripts =  "" // These load after the intial script, before custom

        initialSetupScript = 'Code/BrowserView/js/InitialSetup.js' // Must be run for component to work

        // Required to get the most out of the BrowserView, including state and error management
        list/requiredScriptFiles

    New(
        windowName as text,
        controlId as text,
        skinParams as text
    )
        src.owner = usr.client.mob
        src.windowName = windowName
        src.controlId = controlId

        // Skin params is optional
        if(skinParams)
            src.skinParams = skinParams

        // Cancel creation if required variables don't exist
        try
            enforceRequiredVariables()

        catch(var/exception/variableException)
            throw variableException
            return

        // Register and get an id back
        id = owner.viewManager.registerBrowserView(src)

        loadHTML()
        loadCSS()

        // Scripts might fail to load if the files don't exist
        insertInitialSetupScript()
        loadrawRequiredScripts()
        loadCustomScripts()

        try
            // A browser might exist with the name already
            createBrowser()

        catch(var/exception/browserException)
            throw browserException
            return

        setBrowserSkinParams()
        render()

    proc
        // Without these the component can't exist
        enforceRequiredVariables()
            var/list/required = list()

            required["windowName"] = windowName
            required["controlId"] = controlId
            required["htmlFile"] = htmlFile

            for(var/variable in required)
                if(isnull(required[variable]) || required[variable] == "")
                    throw EXCEPTION("Unable to create BrowserView. Missing [variable]")

        // Load the raw html from the chosen file
        loadHTML()
            if(!fexists(htmlFile))
                throw EXCEPTION("Unable to create BrowserView. HTML file specified does not exist [htmlFile]")

            rawHTML = file2text(htmlFile)

        // Load custom css files
        loadCSS()
            for(var/cssFile in cssFiles)
                owner << browse_rsc(cssFile)

        // Load the very first scripts that need to be run before anything else
        insertInitialSetupScript()
            rawInitialScript += file2text(initialSetupScript)
            rawInitialScript = replacetext(rawInitialScript, "// <INSERT_BROWSER_VIEW_ID>", "view.state.browserViewId = [id];")
            rawInitialScript = replacetext(rawInitialScript, "// <INSERT_WINDOW_NAME>", "view.state.windowName = \"[windowName]\";")
            rawInitialScript = replacetext(rawInitialScript, "// <INSERT_CONTROL_ID>", "view.state.controlId = \"[controlId]\";")
            if(refocusControl)
                rawInitialScript = replacetext(rawInitialScript, "// <INSERT_REFOCUS_CONTROL>", "view.state.refocusControl = \"[refocusControl]\";")
            
            rawInitialScript = "<script>" + rawInitialScript + "</script>"

        // Load scripts that come with the library
        loadrawRequiredScripts()
            for(var/scriptFile in requiredScriptFiles)
                owner << browse_rsc(scriptFile)
                var/list/items = splittext("[scriptFile]", "/")
                var/name = items[items.len]
                rawRequiredScripts += "<script src=\"[name]\"></script>\n"

        // Load any custom scripts to the client's resources so it can referenced in HTML
        loadCustomScripts()
            for(var/scriptFile in scriptFiles)
                owner << browse_rsc(scriptFile)


        // Create a new browser control in the interface
        createBrowser()
            // If a browser doesn't already exist create one
            if(!winexists(owner, "[windowName].[controlId]"))
                winset(owner, "[windowName].[controlId]", "parent=[windowName];type=browser;focus=false")

            if(!winexists(owner, "[windowName].[controlId]"))
                throw EXCEPTION("Unable to create or hook into existing control by id: [windowName].[controlId] (windowName:controlId)")
            // If a browser does exist, there's no task to do here.

        // Set the standard BYOND skin params of the associated browser component
        setBrowserSkinParams()
            // Put it in a transparent window
            winset(owner, "[windowName].[controlId]", skinParams + ";inner-background-color=transparent")

        // Output the complete document to the browser component
        render()
            var/finalPage = rawHTML
            finalPage = replacetext(finalPage, "<body>", "<body>[rawRequiredScripts]")
            finalPage = replacetext(finalPage, "</body>", "[rawInitialScript]</body>")

            owner << output(finalPage, "[windowName].[controlId]")

        setIsReady()
            src.isReady = TRUE

        // You can set a JS variable
        setState(variableName, value)
            // Run in separate thread & wait until it's ready
            spawn()
                while(!src.isReady) // Instant if it's ready
                    sleep(world.tick_lag)

                // Set state.variableName = value in JS
                owner << output(list2params(list(variableName, json_encode(value))), "[windowName].[controlId]:view.setState")


        // Called when a state variable changes in JS and reflects in DM
        reflectState(stateAsList)
            state = stateAsList

        // If the component fails creation, it needs to be removed from the manager
        cancelCreation()
            owner.viewManager.deleteBrowserView()


