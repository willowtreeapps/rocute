sub RunScreenSaver(params as object) as object
    showChannelSGScreen()
end sub
sub showChannelSGScreen()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("Screensaver")
    screen.show()
    scene.animationControl = "start"
    while(true)
        msg = wait(2000, m.port)
        if (msg <> invalid)
            msgType = type(msg)
            if msgType = "roSGScreenEvent"
                if msg.isScreenClosed() then return
            end if
        end if
    end while
end sub