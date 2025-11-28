sub RunScreenSaver()
    m.state = LoadState()
    LoadPlugins()
    
    m.state.clock = CreateObject("roTimespan")
    m.state.clock.Mark()

    m.state.screen = CreateObject("roScreen", true, m.state.general.render_resolution_width, m.state.general.render_resolution_height)
    Log("Screensaver", "Screen created")
    Log("Screensaver", "State loaded")

    port = CreateObject("roMessagePort")
    Log("Screensaver", "Port created")

    

    running = true
    while(running)
        m.state.screen.Clear(&h000000FF)

        ' Code goes here
        RSGCDatetime_Draw()
        RSGCTerminal_Draw()

        m.state.screen.SwapBuffers()

        message = port.GetMessage()        
        if message <> invalid
            messageType = type(message)
            if messageType = "roUniversalControlEvent" then
                running = false
            endif
        endif    
    endwhile
end sub


sub RunScreenSaverSettings()
    screen = CreateObject("roSGScreen")
    print "[RSGC | ScreensaverSettings] Screen created"
    
    port = CreateObject("roMessagePort")
    print "[RSGC | ScreensaverSettings] Port created"

    screen.SetMessagePort(port)

    scene = screen.CreateScene("SettingsScene")
    print "[RSGC | ScreensaverSettings] Scene created"

    screen.show()

    running = true
    while(running)
        message = port.GetMessage()
        
        if message <> invalid
            messageType = type(message)
            if messageType = "roUniversalControlEvent" then
                running = false
            endif
        endif    
    endwhile
end sub
