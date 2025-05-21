sub Draw_DateTime(Screen as object, Settings as object)
    DateTime = CreateObject("roDateTime")
    DateTime.ToLocalTime()

    Fonts = CreateObject("roFontRegistry")
    BigUsableFont = Fonts.GetDefaultFont(45, false, false)
    UsableFont = Fonts.GetDefaultFont(28, false, false)

    OutsidePadding = Settings.Padding
    TotalPadding = Settings.Padding + Settings.InnerPadding

    Width  = (Screen.GetWidth() - OutsidePadding - OutsidePadding - OutsidePadding - OutsidePadding)/5
    Height = 0
    
    TimeText = DateTime.AsTimeStringLoc("hh:mm a")
    TimeTextX = Screen.GetWidth() - TotalPadding - Settings.InnerPadding - BigUsableFont.GetOneLineWidth(TimeText, Screen.GetWidth())
    TimeTextY = TotalPadding
    
    MonthText = DateTime.AsDateString("no-weekday")
    MonthTextX = Screen.GetWidth() - TotalPadding - Settings.InnerPadding - UsableFont.GetOneLineWidth(MonthText, Screen.GetWidth())
    MonthTextY = TimeTextY + Settings.InnerPadding + BigUsableFont.GetOneLineHeight()
    
    WeekText = DateTime.GetWeekday()
    WeekTextX = Screen.GetWidth() - TotalPadding - Settings.InnerPadding - UsableFont.GetOneLineWidth(WeekText, Screen.GetWidth())
    WeekTextY = MonthTextY + Settings.InnerPadding + UsableFont.GetOneLineHeight()
    
    IDLEText = "Idle: " + Int(Settings.DateTime_Timer.TotalSeconds() / 60).ToStr() + "(m)"
    IDLETextX = Screen.GetWidth() - TotalPadding - Settings.InnerPadding - UsableFont.GetOneLineWidth(IDLEText, Screen.GetWidth())
    IDLTextY = WeekTextY + Settings.InnerPadding + UsableFont.GetOneLineHeight()

    Height = IDLTextY + UsableFont.GetOneLineHeight()

    OutsideX = Screen.GetWidth() - Width - OutsidePadding
    OutsideY = Settings.Padding
    Screen.DrawRect(OutsideX, OutsideY, Width, Height, &h5DC6CDFF)

    BabyX = (Screen.GetWidth() - Width) - (Settings.InnerPadding * 2)
    BabyY = TotalPadding
    Screen.DrawRect(BabyX, BabyY, Width - (Settings.InnerPadding * 2), Height - (Settings.InnerPadding * 2), &h000000FF)

    Screen.DrawText(TimeText, TimeTextX, TimeTextY, &hF5F5F5FF, BigUsableFont)
    Screen.DrawText(MonthText, MonthTextX, MonthTextY, &hF5F5F5FF, UsableFont)
    Screen.DrawText(WeekText, WeekTextX, WeekTextY, &hF5F5F5FF, UsableFont)
    Screen.DrawText(IDLEText, IDLETextX, IDLTextY, &hF5F5F5FF, UsableFont)
endsub