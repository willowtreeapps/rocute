' initialization method for the Ticker node. 
sub init()
    m.label = m.top.findNode("label")
    m.animation = m.top.findNode("animation")
    m.interpolator = m.top.findNode("interpolator")
end sub

' method to append text to the currently scrolling labels
'
' @param params an associative array where the key "text" is the additional text to append to our ticker.
sub addText(params as object)
    m.fullText = m.label.text + params.text

    if m.animation.repeat = true and m.label.translation[0] > m.interpolator.keyValue[1][0] + m.width then ' length of current text is known already and is on repeat and text is offscreen on right, new text can be appended right away
        m.label.text = m.fullText
        m.label.observeField("renderTracking", "restartAnimation")
        m.animation.observeField("state", "continueAnimation")
        m.animation.repeat = false
        return
    end if

    ' wait until next time around and then add text
    m.animation.repeat = false
    m.label.unobserveField("renderTracking")
    m.label.observeField("renderTracking", "setInitialValues")
end sub

' method to replace currently scrolling text. 
' 
' @param replacementText the string to replace the text with
' @param isInterruption an optional boolean value representing whether to interrupt the currently scrolling string. Defaults to false.
sub replaceText(additionalText as string, isInterruption = false as boolean)

end sub

' Sets values when interface fields are initialized.
'
' @param event a roSGNodeEvent
sub setInitialValues(event as object)
    if event.getField() = "scrollDuration" then
        m.animation.duration = event.getData()
    else if event.getField() = "width" then
        m.width = event.getData()
        clippingRect = createObject("roAssociativeArray")
        clippingRect["x"] = 0
        clippingRect["y"] = 0
        clippingRect["height"] = 1080
        clippingRect["width"] = m.width
        m.top.clippingRect = clippingRect
        dim startPos[1]
        startPos[0] = m.width
        startPos[1] = 0
        m.label.translation = startPos
        m.interpolator.keyValue[0] = startPos
        dim endPos[1]
        endPos[0] = -m.width
        endPos[1] = 0
        dim values[1]
        values[0] = startPos
        values[1] = endPos
        m.interpolator.keyValue = values
    else if event.getField() = "text" or event.getField() = "renderTracking" then
        if event.getField() = "text" then
            m.fullText = event.getData()
        else if event.getField() = "renderTracking" and event.getData() <> "none" then
            return
        else if event.getField() = "renderTracking" then
            m.label.unobserveField("renderTracking")
        end if
        m.label.text = m.fullText
        m.label.observeField("renderTracking", "restartAnimation")
        m.animation.observeField("state", "continueAnimation")
        m.animation.control = "start"
    end if
end sub

' An internal method to restart the animation after it completes. It then sets the animation to repeat forever and should not be called again unless the text changes.
'
' @param event an roSGNodeEvent
sub restartAnimation(event as object)
    if event.getData() = "none" then
        originalDistance = m.interpolator.keyValue[0][0] - m.interpolator.keyValue[1][0]
        dim startPos[1]
        startPos[0] = m.width
        startPos[1] = 0
        dim endPos[1]
        endPos[0] =  m.label.translation[0]
        endPos[1] = 0
        dim values[1]
        values[0] = startPos
        values[1] = endPos
        m.interpolator.keyValue = values
        originalDuration = m.animation.duration
        newDistance = m.width - m.label.translation[0]
        newDuration = originalDuration * newDistance / originalDistance
        m.animation.duration = newDuration
        m.animation.unobserveField("state")
        m.label.unobserveField("renderTracking")
        m.animation.repeat = true
        m.animation.control = "start"
    end if
end sub

' An internal method to continue the animation after it completes but the text is not yet fully outside the boundingRect.
'
' @param event an roSGNodeEvent
sub continueAnimation(event as object)
    if event.getData() = "stopped" then
        distance = m.interpolator.keyValue[0][0] - m.interpolator.keyValue[1][0]
        dim startPos[1]
        startPos[0] = m.label.translation[0]
        startPos[1] = 0
        dim endPos[1]
        endPos[0] =  m.label.translation[0] - distance
        endPos[1] = 0
        dim values[1]
        values[0] = startPos
        values[1] = endPos
        m.interpolator.keyValue = values
        m.animation.control = "start"
    end if
end sub
