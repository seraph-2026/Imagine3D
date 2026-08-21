
# Mob

## i3d_init(window as text, browserControl as text)

This is first thing you'll want to do. And is enough own it's own to simply start rendering.

It will be rendering the 3D world into the specified browser control.

If the control doesn't exist, a new browser control will be created with the name.

You can then winset() as normal, on that control to change its settings.

-- Longer version --

Init does a number of things. It gets the latest version of the map, along with a list of any resources it needs.
Then it loads those resources into the rsc as png files. Resources can be anything, but the standard example is
any icon the map uses. That will be automatically added as a resource and sent to the browser.

It also passes the players position. This lets the browser know where to draw the camera.


## i3d_getKeyImpulses()

This will return a list of any key events captured from the browser, for the specific player.

Key events are the html key code and "+UP" suffixed if they are UP events.

Why do you need this?

Because Imagine3D runs in a browser and not a normal control, you won't have access to DM macros while you're
focused[1] on the browser. 

The list of impulses returned will remain empty until you use this for the time. Then it will continiously fill
as you might expect. 

It does not automatically delete anything. For that, use Imagine3D.clearKeyImpulses()


[^1]: Only one control can capture key events at a time. This is your focused control.

## i3d_clearKeyImpulses()

This will empty the keyImpulse list completely, for the specific player. If you're not using Imagine3D.getKeyImpulses(),
you can skip caring about this.

## i3d_enableWebDevTools()

This will enable the web dev tools for the browser control specified in Imagin3D.init(window, control)

To access the web dev tools, right click on the browser after running this proc. You should see a box with "Inpsect" is drawn
under your cursor. Click that. 

## i3d_disableDevConsole()

Makes web dev tools inaccessable to the player. See more information in Imagine3D.enableWebDevTools()


