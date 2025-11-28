sub Initalize_FavoriteAddr()
    m.FavoriteAddr_Glyphs = CreateObject("roArray", 41, false)
    for z=1 to 39
        pic = CreateObject("roBitmap", "pkg:/images/Glyphs/glyph"+z.ToStr()+".png")
        m.FavoriteAddr_Glyphs[z] = pic
    end for
end sub

sub Draw_FavoriteAddr()
    Fonts = CreateObject("roFontRegistry")
    UsableFont = Fonts.GetDefaultFont(28, false, false)

    OutsidePadding = m.state.general.opad
    TotalPadding = m.state.general.opad + m.state.general.ipad

    Width  = (m.state.screen.GetWidth() - OutsidePadding - OutsidePadding - OutsidePadding - OutsidePadding)/5
    Height = (m.state.screen.GetHeight() - OutsidePadding - OutsidePadding - OutsidePadding)/2

    m.state.screen.DrawRect(OutsidePadding, m.state.general.opad, Width, Height, &h5DC6CDFF)

    Width  -= m.state.general.ipad * 2
    Height -= m.state.general.ipad * 2
    m.state.screen.DrawRect(TotalPadding, TotalPadding, Width, Height, &h000000FF)

    X = TotalPadding + m.state.general.ipad
    Y = TotalPadding + m.state.general.ipad

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

    Height -= m.state.general.ipad * 2

    for i=0 to Locations.Count()-1
        Color = &hF5F5F5FF
        if Locations[i].Active = true then
            Color = &h00FF00FF
        elseif Locations[i].Active = false then
            Color = &hFF0000FF
        endif

        m.state.screen.DrawText(Locations[i].Name, X, Y, Color, UsableFont)
        
        ' Draw glphys backwards
        for z=0 to Locations[i].Addr.Count()-1
            size = 16

            pic = m.FavoriteAddr_Glyphs[Locations[i].Addr[z]]
            scale = size/pic.GetWidth()

            ZX = Width - (((Locations[i].Addr.Count() - 1) - z) * (size))
            m.state.screen.DrawScaledObject(ZX, Y + (size/2), scale, scale, pic)
        endfor

        Y += UsableFont.GetOneLineHeight() + m.state.general.ipad
    endfor


endsub