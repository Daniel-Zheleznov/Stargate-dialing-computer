sub RunScreenSaver()
    Screen = CreateObject("roScreen", true, 1280, 720)
    Port = CreateObject("roMessagePort")
    Screen.SetMessagePort(Port)

    Settings = {
        Padding: 15,
        InnerPadding: 5,
        Deltatime: 0,

        FavoriteAddr_Glyphs: CreateObject("roArray", 40, false),
        DateTime_Timer: 0,
        SGCLogo_Pics: CreateObject("roArray", 10, true),
        SGCLogo_Pic: -1
    }

    Settings.DateTime_Timer = CreateObject("roTimespan")
    Settings.DateTime_Timer.Mark()

    Initalize_FavoriteAddr(Settings)
    Initalize_SGCLogo(Settings)
    ' Background
    ' Screen.Finish()
    
    Time = CreateObject("roDateTime")
    Time.Mark()

    Running = true
    while(Running)
        
        NewTime = CreateObject("roDateTime")
        NewTime.Mark()

        Settings.Deltatime = NewTime.GetMilliseconds() - Time.GetMilliseconds()
        Time = NewTime

        ' Draw
        Screen.Clear(&h000000FF)
        Draw_FavoriteAddr(Screen, Settings)
        Draw_DateTime(Screen, Settings)
        Draw_SGCLogo(Screen, Settings)

        Screen.SwapBuffers()
        Sleep(17) ' 60fps

        ' Message loop
        Message = Port.GetMessage()
        if (Message <> invalid)
            MessageType = type(Message)
            if MessageType = "roUniversalControlEvent" then
                Running = false
            endif
        endif
    endwhile
endsub