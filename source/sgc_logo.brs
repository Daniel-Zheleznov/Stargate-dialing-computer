sub Initalize_SGCLogo(Settings as object)
    for i = 1 to 59
        padded = Right("00" + i.ToStr(), 2)
        Bitmap = CreateObject("roBitmap", "pkg:/images/SGC-Logo/logo" + padded + ".png")
        Settings.SGCLogo_Pics[i-1] = Bitmap
    endfor

endsub

sub Draw_SGCLogo(Screen as object, Settings as object)
    OutsidePadding = Settings.Padding
    TotalPadding = Settings.Padding + Settings.InnerPadding

    pic = Settings.SGCLogo_Pics[Settings.SGCLogo_Pic]

    if pic <> invalid then
        X  = Screen.GetWidth()/2 - pic.GetWidth()/2
        Y  = Screen.GetHeight()/2 - pic.GetHeight()/2

        Screen.DrawObject(X, Y, pic)

    endif

    Settings.SGCLogo_Pic = (Settings.SGCLogo_Pic + 1) mod Settings.SGCLogo_Pics.Count()

endsub