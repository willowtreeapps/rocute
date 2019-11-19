sub init()
    m.poster = m.top.findNode("logo")
    m.timer = createObject("roSGNode", "Timer")
    m.timer.duration = m.top.displayTime
    ' update logo when fields change
    m.top.observeField("logoUri", "logoChanged")
    m.top.observeField("logoOpacity", "logoChanged")
    m.top.observeField("position", "logoChanged")
    m.top.observeField("fixedPosition", "logoChanged")
    m.top.observeField("logoTranslation", "logoChanged")
    ' update timer when fields change
    m.top.observeField("displayTime", "timerChanged")
    m.top.observeField("fadeTime", "timerChanged")
    ' update video when video changes
    m.top.observeField("videoId", "videoChanged")
end sub

sub videoChanged(event as object)
    videoId = event.getData()
    videoNode = m.top.findNode(videoId)
    if videoNode <> invalid then
        m.video = videoNode
        logoChanged(invalid)
        m.video.observeField("control", "showLogo")
    end if
end sub

sub timerChanged(event as object)

end sub

sub showLogo(event as object)
    m.timer.control = "start"
end sub