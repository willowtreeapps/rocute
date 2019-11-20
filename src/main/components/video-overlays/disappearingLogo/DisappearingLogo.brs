sub init()
    m.logo = m.top.findNode("logo")
    
    m.animation = m.top.findNode("fadeAnimation")

    ' setup timer to fade the logo
    m.timer = createObject("roSGNode", "Timer")
    m.timer.duration = m.top.displayTime
    m.timer.observeField("fire", "fadeLogo")
    
    ' update logo when fields change
    m.top.observeField("logoUri", "logoChanged")
    m.top.observeField("logoSize", "logoChanged")
    m.top.observeField("logoOpacity", "logoChanged")
    m.top.observeField("position", "logoChanged")
    m.top.observeField("margin", "logoChanged")
    m.top.observeField("fixedPosition", "logoChanged")
    m.top.observeField("logoTranslation", "logoChanged")
    
    ' update timer and animation when fields change
    m.top.observeField("displayTime", "timerChanged")
    m.top.observeField("fadeTime", "animationChanged")
    
    ' update video when video changes
    m.top.observeField("videoId", "videoChanged")
end sub

sub logoChanged(event as object)
    if fieldsAreNotSet() = true then return
    videoTranslation = m.video.translation
    videoWidth = m.video.width
    videoHeight = m.video.height
    dim logoPosition[1]
    if m.top.fixedPosition = true and m.top.logoTranslation <> invalid then
        logoPosition[0] = videoTranslation[0] + m.top.logoTranslation[0]
        logoPosition[1] = videoTranslation[1] + m.top.logoTranslation[1]
    else if m.position = "topLeft" then
        logoPosition[0] = videoTranslation[0] + m.top.margin
        logoPosition[1] = videoTranslation[1] + m.top.margin
    else if m.position = "topRight" then
        logoPosition[0] = videoTranslation[0] + videoWidth - m.top.margin - m.top.logoSize[0]
        logoPosition[1] = videoTranslation[1] + m.top.margin
    else if m.position = "bottomLeft" then
        logoPosition[0] = videoTranslation[0] + m.top.margin
        logoPosition[1] = videoTranslation[1] + videoHeight - m.top.margin - m.top.logoSize[1]
    else ' use the default of "bottomRight"
        logoPosition[0] = videoTranslation[0] + videoWidth - m.top.margin - m.top.logoSize[0]
        logoPosition[1] = videoTranslation[1] + videoHeight - m.top.margin - m.top.logoSize[1]
    end if

    m.logo.translation = logoPosition
    m.logo.loadWidth = m.top.logoSize[0]
    m.logo.width = m.top.logoSize[0]
    m.logo.loadHeight = m.top.logoSize[1]
    m.logo.height = m.top.logoSize[1]
    m.logo.uri = m.top.logoUri
end sub

sub videoChanged(event as object)
    videoId = event.getData()
    videoNode = m.top.getParent().findNode(videoId)
    if videoNode <> invalid then
        m.video = videoNode
        logoChanged(invalid)
        m.video.observeField("state", "showLogo")
    end if
end sub

sub timerChanged(event as object)
    m.timer.duration = event.getData()
end sub

sub animationChanged(event as object)
    m.animation.duration = event.getData()
end sub

sub showLogo(event as object)
    state = event.getData()
    if state = "none" or state = "buffering" or state = "finished" or state = "error" then return
    m.animation.control = "stop"
    print state
    'print m.animation.control
    'state = m.video.state
    m.logo.opacity = m.top.logoOpacity
    if state = "playing" then
        m.timer.control = "start"
    end if
end sub

sub fadeLogo(event as object)
    m.animation.control = "start"
end sub

sub fieldsAreNotSet() as boolean
    return m.video = invalid or m.top.logoUri = invalid or m.top.margin = invalid or m.top.logoSize = invalid
end sub