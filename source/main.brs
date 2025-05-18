sub RunScreenSaver()
    Screen = CreateObject("roScreen", false, 1280, 720)
    Port = CreateObject("roMessagePort")
    Screen.SetMessagePort(Port)

    Settings = {
        Padding: 15,
        InnerPadding: 5
    }

    ' Background
    ' Screen.Finish()
    
    Running = true
    while(Running)
        
        ' Draw
        Screen.Clear(&h000000FF)
        Draw_FavoriteAddr(Screen, Settings)
        Draw_DateTime(Screen, Settings)
        Screen.Finish()

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