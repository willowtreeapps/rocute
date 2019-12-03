' initialization method for the Ticker node. 
sub init()
    m.label = m.top.findNode("label")
    m.animation = m.top.findNode("animation")
    m.interpolator = m.top.findNode("interpolator")
    m.width = m.top.width
    clippingRect = createObject("roAssociativeArray")
    setWidth()
end sub

' method to append text to the currently scrolling labels
'
' @param params an associative array where the key "text" is the additional text to append to our ticker.
sub addText(params as object)
    m.fullText = m.label.text + params.text

    if m.animation.repeat = true and m.label.translation[0] > getEndPoint() + m.width then ' length of current text is known already and is on repeat and text is offscreen on right, new text can be appended right away
        m.label.text = m.fullText
        m.label.observeField("renderTracking", "restartAnimation")
        m.animation.observeField("state", "continueAnimation")
        m.animation.repeat = false
        return
    end if

    ' wait until next time around and then add text
    params.text = m.fullText
    setText(params)
end sub

' method to replace currently scrolling text. 
' 
' @param params an associative array where the key "text" is the new text for our ticker.
sub setText(params as object)
    m.fullText = params.text
    m.animation.repeat = false
    m.label.unobserveField("renderTracking")
    m.label.observeField("renderTracking", "setInitialValues")
end sub

' Sets values when text is initialized.
'
' @param event a roSGNodeEvent
sub setInitialValues(event as object)
    if event.getField() = "text" then
        m.fullText = event.getData()
    else if event.getField() = "renderTracking" and event.getData() <> "none" then
        return
    else if event.getField() = "renderTracking" then
        setWidth()
        m.label.unobserveField("renderTracking")
    end if
    m.label.text = m.fullText
    m.label.observeField("renderTracking", "restartAnimation")
    m.animation.observeField("state", "continueAnimation")
    m.animation.control = "start"
end sub

' An internal method to restart the animation after it completes. It then sets the animation to repeat forever or until the text or width changes.
'
' @param event an roSGNodeEvent
sub restartAnimation(event as object)
    if event.getData() = "none" then
        setScrollEndpoints(m.width, m.label.translation[0])
        setSpeed()
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
        distance = getStartPoint() - getEndPoint()
        setScrollEndpoints(m.label.translation[0], m.label.translation[0] - distance)
        m.animation.control = "start"
    end if
end sub

' A method called when the scrollSpeed has changed.
sub setSpeed()
    speed = m.top.scrollSpeed
    if speed = 0 or speed = invalid then return ' avoid dividing by 0 or invalid.
    distance = getStartPoint() - getEndPoint()
    duration = distance / speed
    m.animation.duration = duration
end sub

' A method called when the width has changed.
sub setWidth()
    m.width = m.top.width
    if m.width <> m.top.clippingRect.width then
        clippingRect = createObject("roAssociativeArray")
        clippingRect["x"] = 0
        clippingRect["y"] = 0
        clippingRect["height"] = 1080
        clippingRect["width"] = m.width
        m.top.clippingRect = clippingRect
    end if
    if m.label.renderTracking = "none" then
        setScrollEndpoints(m.width, -m.width)
        setSpeed()
    else
        ' TODO: how to handle width changes while animation plays?
    end if
end sub

' a method to set the x coordinates of the animation
'
' @param startPoint the starting x coordinate
' @param endPoint the ending x coordinate
sub setScrollEndpoints(startPoint as double, endPoint as double)
    dim startPos[1]
    startPos[0] = startPoint
    startPos[1] = 0
    m.label.translation = startPos
    m.interpolator.keyValue[0] = startPos
    dim endPos[1]
    endPos[0] = endPoint
    endPos[1] = 0
    dim values[1]
    values[0] = startPos
    values[1] = endPos
    m.interpolator.keyValue = values
end sub

' a helper function to get the x coordinate of the start point of the animation
'
' @return the x coordinate of the start point of the animation 
function getStartPoint() as double
    return m.interpolator.keyValue[0][0]
end function

' a helper function to get the x coordinate of the end point of the animation 
'
' @return the x coordinate of the end point of the animation 
function getEndPoint() as double
    return m.interpolator.keyValue[1][0]
end function