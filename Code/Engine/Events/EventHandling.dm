
/**
    Some events like reflectState contain too much text
    and can't be sent with BYOND.command.

    Topic is the way to send large volumes of text like
    the JSON state.
**/

// client/Topic(href, href_list[])
//     . = ..()
//     if(href_list.len == 2)
//         if(href_list["viewEvent"] == "reflectState")
//             src.mob.captureEvent(href_list["value"])

client
    verb
        keyDown(htmlKeyCode as text)
            if(Imagine3D.captureImpulses)
                src.mob.imagine3DView.keyImpulses += htmlKeyCode

        keyUp(htmlKeyCode as text)
            if(Imagine3D.captureImpulses)
                src.mob.imagine3DView.keyImpulses += htmlKeyCode + "+UP" // +UP is a DM standard

