sub Initalize_SGCLogo(Settings as object)
    for i = 1 to 59
        padded = Right("00" + i.ToStr(), 2)
        Bitmap = CreateObject("roBitmap", "pkg:/images/SGC-Logo/logo" + padded + ".png")
        Settings.SGCLogo_Pics[i-1] = Bitmap
    endfor

    Settings.SGCLogo_Velocity = [10, 10]
    Settings.SGCLogo_Position = [0, 0]
endsub

sub Draw_SGCLogo(Screen as object, Settings as object)
    OutsidePadding = Settings.Padding
    TotalPadding = Settings.Padding + Settings.InnerPadding

    pic = Settings.SGCLogo_Pics[Settings.SGCLogo_Pic]

    if pic <> invalid then
        Settings.SGCLogo_Position[0] += Settings.SGCLogo_Velocity[0]
        Settings.SGCLogo_Position[1] += Settings.SGCLogo_Velocity[1]

        if Settings.SGCLogo_Position[0] + pic.GetWidth() >= Screen.GetWidth() or Settings.SGCLogo_Position[0] <= 0 then
            Settings.SGCLogo_Velocity[0] = -Settings.SGCLogo_Velocity[0]
        endif
        
        if Settings.SGCLogo_Position[1] + pic.GetHeight() >= Screen.GetHeight() or Settings.SGCLogo_Position[1] <= 0  then
            Settings.SGCLogo_Velocity[1] = -Settings.SGCLogo_Velocity[1]
        endif

        Screen.DrawObject(Settings.SGCLogo_Position[0], Settings.SGCLogo_Position[1], pic)

    endif

    Settings.SGCLogo_Pic = (Settings.SGCLogo_Pic + 1) mod Settings.SGCLogo_Pics.Count()

endsub