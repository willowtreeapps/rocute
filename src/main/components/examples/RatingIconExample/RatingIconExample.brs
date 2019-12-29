' Initialization method for the RatingIconExample component
sub init()
    m.video = m.top.findNode("video")
    videoContent = createObject("roSGNode", "ContentNode")
    videoContent.url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
    videoContent.contentType = "movie"
    videoContent.rating = "UR"
    m.video.content = videoContent
    m.video.control = "play"
    m.video.setFocus(true)
    m.top.observeField("focusedChild", "giveVideoFocus")
end sub

' A method to give the video focus when the RatingIconExample component has focus.
'
' @param event a roSGNodeEvent
sub giveVideoFocus(event as object)
    if m.top.isInFocusChain() then
        m.video.setFocus(true)
    end if
end sub