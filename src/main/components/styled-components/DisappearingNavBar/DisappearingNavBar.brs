sub init()
    m.top.unobserveField("focusedChild")
    m.top.observeField("focusedChild", "focusChangedOverride")
    m.top.observeField("height", "setAnimationHeight")
    m.slideInAnimation = m.top.findNode("inAnimation")
    m.inInterpolator = m.top.findNode("inInterpol")
    m.slideOutAnimation = m.top.findNode("outAnimation")
    m.outInterpolator = m.top.findNode("outInterpol")
    m.fadeInAnimation = m.top.findNode("fadeInAnimation")
    m.fadeOutAnimation = m.top.findNode("fadeOutAnimation")
    m.grid.enableRenderTracking = true
end sub

sub focusChangedOverride(event as object)
    if m.top.isInFocusChain() = true then
        if m.grid.renderTracking = "none" then
            m.slideInAnimation.control = "start"
            m.fadeInAnimation.control = "start"
        end if
        m.grid.setFocus(true)
    else if m.grid.visible = true then
        m.slideOutAnimation.control = "start"
        m.fadeOutAnimation.control = "start"
    end if
end sub

sub setAnimationHeight(event as object)
    height = event.getData()
    dim inVector[1]
    dim outVector[1]
    dim showPosition[1]
    dim hidePosition[1]
    showPosition[0] = 0
    showPosition[1] = 0

    hidePosition[0] = 0
    hidePosition[1] = -height
    inVector[0] = hidePosition
    inVector[1] = showPosition
    outVector[0] = showPosition
    outVector[1] = hidePosition
    m.inInterpolator.keyValue = inVector
    m.outInterpolator.keyValue = outVector
end sub