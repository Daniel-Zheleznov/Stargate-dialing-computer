sub Initalize_FavoriteAddr(Settings as object)
    for z=1 to 39
        pic = CreateObject("roBitmap", "pkg:/images/Glyphs/glyph"+z.ToStr()+".png")
        Settings.FavoriteAddr_Glyphs[z] = pic
    endfor
endsub

sub Draw_FavoriteAddr(Screen as object, Settings as object)
    Fonts = CreateObject("roFontRegistry")
    UsableFont = Fonts.GetDefaultFont(28, false, false)

    OutsidePadding = Settings.Padding
    TotalPadding = Settings.Padding + Settings.InnerPadding

    Width  = (Screen.GetWidth() - OutsidePadding - OutsidePadding - OutsidePadding - OutsidePadding)/5
    Height = (Screen.GetHeight() - OutsidePadding - OutsidePadding - OutsidePadding)/2

    Screen.DrawRect(OutsidePadding, Settings.Padding, Width, Height, &h5DC6CDFF)

    Width  -= Settings.InnerPadding * 2
    Height -= Settings.InnerPadding * 2
    Screen.DrawRect(TotalPadding, TotalPadding, Width, Height, &h000000FF)

    X = TotalPadding + Settings.InnerPadding
    Y = TotalPadding + Settings.InnerPadding

    Locations = [
        { Name: "Abydos"  , Addr: [26, 6, 14, 31, 11, 29], Active: false },
        { Name: "P3X-562" , Addr: [2, 27, 8, 34, 23, 14],  Active: true  },
        { Name: "P3X-797" , Addr: [25, 1, 32, 37, 9, 31],  Active: true  }, ' IDK maybe need checkup
        { Name: "P2X-555" , Addr: [27, 7, 15, 32, 12, 30], Active: true  },
        { Name: "P3X-774" , Addr: [8, 18, 25, 18, 21, 4],  Active: false },
        { Name: "PX8-987" , Addr: [20, 12, 25, 16, 5, 36], Active: true  },
        { Name: "P3X-989" , Addr: [28, 7, 17, 21, 3, 24],  Active: false },
        { Name: "P4X-639" , Addr: [3, 8, 27, 11, 21, 15],  Active: true  },
    ]

    Height -= Settings.InnerPadding * 2

    for i=0 to Locations.Count()-1
        Color = &hF5F5F5FF
        if Locations[i].Active = true then
            Color = &h00FF00FF
        elseif Locations[i].Active = false then
            Color = &hFF0000FF
        endif

        Screen.DrawText(Locations[i].Name, X, Y, Color, UsableFont)
        
        ' Draw glphys backwards
        for z=0 to Locations[i].Addr.Count()-1
            size = 16

            pic = Settings.FavoriteAddr_Glyphs[Locations[i].Addr[z]]
            scale = size/pic.GetWidth()

            ZX = Width - (((Locations[i].Addr.Count() - 1) - z) * (size + Settings.InnerPadding))
            Screen.DrawScaledObject(ZX, Y + (size/2), scale, scale, pic)
        endfor

        Y += UsableFont.GetOneLineHeight() + Settings.InnerPadding
    endfor


endsub