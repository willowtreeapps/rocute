sub RunScreenSaver(params as object) as object
    print "BouncingLogoScreensaverMain.RunScreenSaver"
    showBChannelSGScreen()
end sub
sub showBChannelSGScreen()
    print "BouncingLogoScreensaverMain.showBChannelSGScreen"
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("BouncingLogoScreensaver")
    screen.show()

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