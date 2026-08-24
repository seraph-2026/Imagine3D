
#define F1_MENU 100
#define F2_MENU 101
#define F3_MENU 102
#define F4_MENU 103

/**
    Customize keys using html key codes
**/
var/keyMap = alist(
    "KeyW"= I3D_FORWARD_DOWN,
    "KeyA"= I3D_STRAFE_LEFT_DOWN,
    "KeyS"= I3D_BACKWARD_DOWN,
    "KeyD"= I3D_STRAFE_RIGHT_DOWN,

    "KeyW+UP"= I3D_FORWARD_UP,
    "KeyA+UP"= I3D_STRAFE_LEFT_UP,
    "KeyS+UP"= I3D_BACKWARD_UP,
    "KeyD+UP"= I3D_STRAFE_RIGHT_UP,

    "F1"=F1_MENU,
    "F2"=F2_MENU,
    "F3"=F3_MENU,
    "F4"=F4_MENU
)

mob
    proc
        /**
            Scans impulses looking for recognized key events.
            Sets controls appropriately.

            Movement is automatic based off controls if you
            have run Imagine3D.enableMovement()
        **/
        handleKeyInput()
            set waitfor = 0
            var/list/keyImpulses = Imagine3D.getKeyImpulses(src)

            for(var/key in keyImpulses)
                world << "[key]"

                switch(keyMap[key])
                    if(I3D_FORWARD_UP) src.i3d_controls.forward = FALSE
                    if(I3D_BACKWARD_UP) src.i3d_controls.backward = FALSE
                    if(I3D_STRAFE_LEFT_UP) src.i3d_controls.leftStrafe = FALSE
                    if(I3D_STRAFE_RIGHT_UP) src.i3d_controls.rightStrafe = FALSE

                    if(I3D_FORWARD_DOWN) src.i3d_controls.forward = TRUE
                    if(I3D_BACKWARD_DOWN) src.i3d_controls.backward = TRUE
                    if(I3D_STRAFE_LEFT_DOWN) src.i3d_controls.leftStrafe = TRUE
                    if(I3D_STRAFE_RIGHT_DOWN) src.i3d_controls.rightStrafe = TRUE

                    if(F1_MENU) show3dMap()
                    if(F2_MENU) show2dMap()
                    if(F3_MENU) showOutput()
                    if(F4_MENU) showFullScreen()

            Imagine3D.clearKeyImpulses(src)

    Login()
        ..()
        /**
            Run our input handler every tick, for each client.

            Controls must be set before movement runs. Hence this uses
            'PreTick', whereas built-in movement runs in 'Tick'
        **/
        Imagine3D.registerPreTickProc(/proc/handleInputForAllPlayers, null)

proc
    handleInputForAllPlayers()
        for(var/client/nextClient)
            var/mob/connectedMob = nextClient.mob
            connectedMob.handleKeyInput()

