sub RSGCDatetime_Draw()
    DateTime = CreateObject("roDateTime")
    DateTime.ToLocalTime()

    Fonts = CreateObject("roFontRegistry")
    BigUsableFont = Fonts.GetDefaultFont(45, false, false)
    UsableFont = Fonts.GetDefaultFont(30, false, false)

    OutsidePadding = m.state.general.opad
    TotalPadding = m.state.general.opad + m.state.general.ipad

    Width  = (m.state.screen.GetWidth() - OutsidePadding - OutsidePadding - OutsidePadding - OutsidePadding)/5
    Height = 0
    
    TimeText = DateTime.AsTimeStringLoc("hh:mm a")
    TimeTextX = m.state.screen.GetWidth() - TotalPadding - m.state.general.ipad - BigUsableFont.GetOneLineWidth(TimeText, m.state.screen.GetWidth())
    TimeTextY = TotalPadding
    
    MonthText = DateTime.AsDateString("short-month-no-weekday")
    MonthTextX = m.state.screen.GetWidth() - TotalPadding - m.state.general.ipad - UsableFont.GetOneLineWidth(MonthText, m.state.screen.GetWidth())
    MonthTextY = TimeTextY + m.state.general.ipad + BigUsableFont.GetOneLineHeight()
    
    WeekText = DateTime.GetWeekday()
    WeekTextX = m.state.screen.GetWidth() - TotalPadding - m.state.general.ipad - UsableFont.GetOneLineWidth(WeekText, m.state.screen.GetWidth())
    WeekTextY = MonthTextY + m.state.general.ipad + UsableFont.GetOneLineHeight()
    
    Mins = Int((m.state.clock.TotalSeconds() / 60) mod 60)
    Hours = Int(((m.state.clock.TotalSeconds() / 60) / 60) mod 60)
    Days = Int((((m.state.clock.TotalSeconds() / 60) / 60) / 24) mod 24)
    IDLEText = "Idle: " + Days.ToStr("%02d") + ":" + Hours.ToStr("%02d") + ":" + Mins.ToStr("%02d")
    IDLETextX = m.state.screen.GetWidth() - TotalPadding - m.state.general.ipad - UsableFont.GetOneLineWidth(IDLEText, m.state.screen.GetWidth())
    IDLTextY = WeekTextY + m.state.general.ipad + UsableFont.GetOneLineHeight()

    Height = IDLTextY + UsableFont.GetOneLineHeight()

    OutsideX = m.state.screen.GetWidth() - Width - OutsidePadding
    OutsideY = m.state.general.opad
    m.state.screen.DrawRect(OutsideX, OutsideY, Width, Height, &h5DC6CDFF)

    BabyX = (m.state.screen.GetWidth() - Width) - (m.state.general.ipad * 2)
    BabyY = TotalPadding
    m.state.screen.DrawRect(BabyX, BabyY, Width - (m.state.general.ipad * 2), Height - (m.state.general.ipad * 2), &h000000FF)

    m.state.screen.DrawText(TimeText, TimeTextX, TimeTextY, &hF5F5F5FF, BigUsableFont)
    m.state.screen.DrawText(MonthText, MonthTextX, MonthTextY, &hF5F5F5FF, UsableFont)
    m.state.screen.DrawText(WeekText, WeekTextX, WeekTextY, &hF5F5F5FF, UsableFont)
    m.state.screen.DrawText(IDLEText, IDLETextX, IDLTextY, &hF5F5F5FF, UsableFont)
endsub
