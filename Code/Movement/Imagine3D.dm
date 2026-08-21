
/**
    If movementEnabled == TRUE then movement ticks will begin
    immediately to convert controls into steps.
**/
Imagine3D
    var/movementEnabled = FALSE

    proc
        enableMovement()
            movementEnabled = TRUE
        
        disableMovement()
            movementEnabled = FALSE