sub RunScreenSaver()
    screen = CreateObject("roSGScreen") 'Creates screen to display screensaver
    port = CreateObject("roMessagePort") 'Port to listen to events on screen
    screen.SetMessagePort(port)

    scene = screen.CreateScene("StargateCommand") 'Creates scene to display on screen. Scene name (AnimatedScreensaver) must match ID of XML Scene Component
    screen.Show()

    while(true) 'Uses message port to listen if channel is closed
        msg = Wait(0, port)
        if (msg <> invalid)
            msgType = type(msg)
            if msgType = "roSGScreenEvent"
                if msg.isScreenClosed() then return
            end if
        end if
    end while
end sub