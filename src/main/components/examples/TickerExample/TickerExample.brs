' Initialization method for the TickerExample component.
sub init()
    m.video = m.top.findNode("video")
    videoContent = createObject("roSGNode", "ContentNode")
    videoContent.url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
    m.video.content = videoContent
    m.video.control = "play"
    m.ticker = m.top.findNode("ticker")
    m.timer = createObject("roSGNode", "Timer")
    m.timer.duration = 20
    m.timer.observeField("fire", "addText")
    m.timer.control = "start"
end sub

' A method to change the text showing in the ticker.
sub addText()
    params = createObject("roAssociativeArray")
    params["text"] = "BREAKING NEWS: THIS TEXT WAS ADDED AS THE RESULT OF A TIMER."
    m.ticker.callFunc("setText", params)
end sub