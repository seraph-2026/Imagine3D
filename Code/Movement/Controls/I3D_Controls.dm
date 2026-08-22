
#define I3D_FORWARD_UP 1
#define I3D_BACKWARD_UP 2
#define I3D_STRAFE_LEFT_UP 3
#define I3D_STRAFE_RIGHT_UP 4

#define I3D_FORWARD_DOWN 5
#define I3D_BACKWARD_DOWN 6
#define I3D_STRAFE_LEFT_DOWN 7
#define I3D_STRAFE_RIGHT_DOWN 8

I3D_Controls
    var
        forward = FALSE
        backward = FALSE
        leftStrafe = FALSE
        rightStrafe = FALSE

atom/movable
    var/I3D_Controls/i3d_controls = new() // Give every mob a set of controls