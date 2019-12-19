sub RunUserInterface(params as object)
  ' set up your screen
  screen = CreateObject("roSGScreen")
  m.port = CreateObject("roMessagePort")
  screen.setMessagePort(m.port)
  scene = screen.CreateScene("AppScene")
  screen.show()

  while(true)
    msg = wait(0, m.port)
    msgType = type(msg)
    if msgType = "roSGScreenEvent"
      if msg.isScreenClosed() then return
    end if
  end while

  'check for test parameter
  if params.RunTests = "true"
    runner = TestRunner()
    if params.host <> invalid
      runner.logger.SetServer(params.host, params.port, params.protocol)
    else
      runner.logger.SetServerURL(param.url)
    end if
    ' other setup if needed

    runner.run()
  end if

  ' start event loop

end sub