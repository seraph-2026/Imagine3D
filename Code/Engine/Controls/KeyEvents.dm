
client
    verb
        keyDown(htmlKeyCode as text)
            if(Imagine3D.captureImpulses)
                src.mob.i3d_view.keyImpulses += htmlKeyCode

        keyUp(htmlKeyCode as text)
            if(Imagine3D.captureImpulses)
                src.mob.i3d_view.keyImpulses += htmlKeyCode + "+UP" // +UP is a DM standard

