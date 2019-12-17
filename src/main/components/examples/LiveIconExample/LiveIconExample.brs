sub init()
    m.video = m.top.findNode("video")
    videoContent = createObject("roSGNode", "ContentNode")
    videoContent.url = "https://s20.us-east-1.skyvdn.com:443/rtplive/10034/playlist.m3u8"
    videoContent.live = true
    videoContent.streamFormat = "hls"
    m.video.content = videoContent
    m.video.control = "play"
    m.video.setFocus(true)
    m.top.observeField("focusedChild", "giveVideoFocus")
end sub

sub giveVideoFocus(event as object)
    if m.top.isInFocusChain() then
        m.video.setFocus(true)
    end if
end sub