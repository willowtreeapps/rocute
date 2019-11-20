sub init()
    m.video = m.top.findNode("video")
    videoContent = createObject("roSGNode", "ContentNode")
    videoContent.url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
    m.video.content = videoContent
    m.video.control = "play"
    m.video.setFocus(true)
end sub