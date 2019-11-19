sub init()
    m.poster = m.top.findNode("logo")
    
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
    if m.video = invalid or m.top.logoUri = invalid then return
    videoTranslation = m.video.translation
    videoWidth = m.video.width
    videoHeight = m.video.height
    dim logoPosition[1]
    if m.fixedPosition = true and m.logoTranslation <> invalid then
        logoPosition[0] = videoTranslation[0] + m.logoTranslation[0]
        logoPosition[1] = videoTranslation[1] + m.logoTranslation[1]
    else if m.position = "topLeft" then
        logoPosition[0] = videoTranslation[0] + m.margin
        logoPosition[1] = videoTranslation[1] + m.margin
    else if m.position = "topRight" then
        logoPosition[0] = videoTranslation[0] + videoWidth - m.margin - m.logoSize[0]
        logoPosition[1] = videoTranslation[1] + m.margin
    else if m.position = "bottomLeft" then
        logoPosition[0] = videoTranslation[0] + m.margin
        logoPosition[1] = videoTranslation[1] + videoHeight - m.margin - m.logoSize[1]
    else ' use the default of "bottomRight"
        logoPosition[0] = videoTranslation[0] + videoWidth - m.margin - logoSize[0]
        logoPosition[1] = videoTranslation[1] + videoHeight - m.margin - logoSize[1]
    end if
    m.logo.translation = logoPosition
    m.logo.loadWidth = m.logoSize[0]
    m.logo.loadHeight = m.logoSize[1]
    m.logo.uri = m.logoUri
end sub

sub videoChanged(event as object)
    videoId = event.getData()
    videoNode = m.top.findNode(videoId)
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
    m.logo.opacity = m.top.logoOpacity
    if state = "playing" then
        m.timer.control = start
    end if
end sub

sub fadeLogo(event as object)
    m.animation.control = start
end sub