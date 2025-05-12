sub init()
    Device = CreateObject("roDeviceInfo")

    VideoModeLookup = {
        "480i":         { width: 720, height: 480 },
        "480p":         { width: 720, height: 480 },
        
        "576i25":       { width: 720, height: 576 },
        "576p50":       { width: 720, height: 576 },
        "576p60":       { width: 720, height: 576 },
        
        "720p50":       { width: 1280, height: 720 },
        "720p":         { width: 1280, height: 720 },
        
        "1080i50":      { width: 1920, height: 1080 },
        "1080i":        { width: 1920, height: 1080 },
        "1080p24":      { width: 1920, height: 1080 },
        "1080p25":      { width: 1920, height: 1080 },
        "1080p30":      { width: 1920, height: 1080 },
        "1080p50":      { width: 1920, height: 1080 },
        "1080p60b10":   { width: 1920, height: 1080 },
        "1080p60Dv":    { width: 1920, height: 1080 },
        "1080p":        { width: 1920, height: 1080 },
        
        "2160p24":      { width: 3840, height: 2160 },
        "2160p25":      { width: 3840, height: 2160 },
        "2160p30":      { width: 3840, height: 2160 },
        "2160p30Dv":    { width: 3840, height: 2160 },
        "2160p50":      { width: 3840, height: 2160 },
        "2160p60":      { width: 3840, height: 2160 },
        "2160p60Dv":    { width: 3840, height: 2160 },
        "2160p24b10":   { width: 3840, height: 2160 },
        "2160p25b10":   { width: 3840, height: 2160 },
        "2160p30b10":   { width: 3840, height: 2160 },
        "2160p50b10":   { width: 3840, height: 2160 },
        "2160p60b10":   { width: 3840, height: 2160 },

        "4320p60":      { width: 7680, height: 4320 },
        "4320p60b10":   { width: 7680, height: 4320 },
    }
    VideoMode = Device.GetVideoMode()
    Resolution = VideoModeLookup[VideoMode]
    print "[StargateCommand] Video mode: "; VideoMode; "; Optimal resolution: "; VideoModeLookup[VideoMode].width; " x "; VideoModeLookup[VideoMode].height

    m.top.BackgroundColor = "0x000000FF"
    m.top.BackgroundURI = ""
    
    m.LeftGroup = m.top.FindNode("LeftGroup")
    m.FavoriteAddresses = m.top.FindNode("FavoriteAddresses")

    RenderFavoriteAddresses(Resolution, m.FavoriteAddresses)

end sub

sub OnPosterLoaded(event as Object)
    node = event.getRoSGNode()

    if node.loadStatus = "ready"
        print "[StargateCommand|ASYNC] poster size: "; node.bitmapWidth; " x "; node.bitmapHeight; "; poster position: "; node.translation[0]; " x "; node.translation[1]; "; poster uri: "; node.uri
    end if
end sub

sub RenderFavoriteAddresses(Resolution as Object, Node as Object)
    Symbols = [        
        "pkg:/images/glyph01.png",
        "pkg:/images/glyph02.png",
        "pkg:/images/glyph03.png",
        "pkg:/images/glyph04.png",
        "pkg:/images/glyph05.png",
        "pkg:/images/glyph06.png",
        "pkg:/images/glyph07.png",
        "pkg:/images/glyph08.png",
        "pkg:/images/glyph09.png",
        "pkg:/images/glyph10.png",
        "pkg:/images/glyph11.png",
        "pkg:/images/glyph12.png",
        "pkg:/images/glyph13.png",
        "pkg:/images/glyph14.png",
        "pkg:/images/glyph15.png",
        "pkg:/images/glyph16.png",
        "pkg:/images/glyph17.png",
        "pkg:/images/glyph18.png",
        "pkg:/images/glyph19.png",
        "pkg:/images/glyph20.png",
        "pkg:/images/glyph21.png",
        "pkg:/images/glyph22.png",
        "pkg:/images/glyph23.png",
        "pkg:/images/glyph24.png",
        "pkg:/images/glyph25.png",
        "pkg:/images/glyph26.png",
        "pkg:/images/glyph27.png",
        "pkg:/images/glyph28.png",
        "pkg:/images/glyph29.png",
        "pkg:/images/glyph30.png",
        "pkg:/images/glyph31.png",
        "pkg:/images/glyph32.png",
        "pkg:/images/glyph33.png",
        "pkg:/images/glyph34.png",
        "pkg:/images/glyph35.png",
        "pkg:/images/glyph36.png",
        "pkg:/images/glyph37.png",
        "pkg:/images/glyph38.png",
        "pkg:/images/glyph39.png"
    ]

    FavoriteAddressesWidth = (Resolution.width-12)/5
    FavoriteAddressesHeight = (Resolution.height-15)/2

    BackgroundRect = Node.CreateChild("Rectangle")
    BackgroundRect.width = FavoriteAddressesWidth
    BackgroundRect.height = FavoriteAddressesHeight
    BackgroundRect.color = "0x5DC6CDFF" ' "0xFF58CAFF"
    BackgroundRect.translation = [6, 6]

    BabyBackground = Node.CreateChild("Rectangle")
    BabyBackground.width = FavoriteAddressesWidth - 6
    BabyBackground.height = FavoriteAddressesHeight - 6
    BabyBackground.color = "0x000000FF"
    BabyBackground.translation = [9, 9]

    ' TODO {Daniel Zheleznov} {05/11/2025} Custom locations
    ' STUPID AHH LANGUAGE https://developer.roku.com/docs/references/brightscript/language/program-statements.md FOREACH
    LocationsNames = [
        "Abydos",
        "P3X-562",
        "P3X-797",
        "P2X-555",
        "P3X-774",
        "PX8-987",
        "P3X-989",
        "P4X-639"
    ]

    LocationsAddrs = [
        [26, 6, 14, 31, 11, 29],
        [2, 27, 8, 34, 23, 14],
        [25, 1, 32, 37, 9, 31], ' IDK maybe need a checkup
        [27, 7, 15, 32, 12, 30],
        [8, 18, 25, 18, 21, 4],
        [20, 12, 25, 16, 5, 36],
        [28, 7, 17, 21, 3, 24],
        [3, 8, 27, 11, 21, 15]
    ]

    LocationsActive = [
        false,
        true,
        true,
        true,
        false,
        true,
        false,
        true
    ]

    print "[StargateCommand] Rendering FavoriteAddresses"

    FavoriteAddress = Node.CreateChild("Label")
    FavoriteAddress.text = "Favorite addresses"
    FavoriteAddress.font = "font:MediumBoldSystemFont"
    FavoriteAddress.visible = true
    FavoriteAddress.horizAlign = "center"
    FavoriteAddress.vertAlign = "center"
    FavoriteAddress.translation = [12, 12]
    FavoriteAddress.width = FavoriteAddressesWidth - 24
    FavoriteAddress.height = FavoriteAddress.BoundingRect().height + 12
    FavoriteAddress.color = "0xF5F5F5FF"

    count = 0
    PreviousHeight = 0
    for each location in LocationsNames
        lb = Node.CreateChild("Label")
        lb.text = location
        lb.width = FavoriteAddressesWidth - 24
        lb.height = lb.BoundingRect().height + 12
        lb.font = "font:SmallestSystemFont"
        lb.visible = true
        if LocationsActive[count] = true then
            lb.color = "0x00FF00FF"
        else
            lb.color = "0xFF0000FF"
        end if        
        lb.translation = [12, 12 + FavoriteAddress.height + (PreviousHeight)]
        lb.horizAlign = "left"
        lb.vertAlign = "center"

        print "[StargateCommand] "; location
        print "[StargateCommand] ----------------------"
        print "[StargateCommand] lb size: "; lb.width; " x "; lb.height
        print "[StargateCommand] lb pos: "; lb.translation[0]; " x "; lb.translation[1]

        glyph_count = 0
        LabelY = lb.translation[1]
        for each glyph_address in LocationsAddrs[count]
            poster = Node.CreateChild("Poster")
            poster.uri = Symbols[glyph_address]
            poster.height = lb.height - 12
            poster.width = poster.height
            poster.translation = [
                FavoriteAddressesWidth - ((6-glyph_count)*(poster.height+6)),
                LabelY + 6
            ]
                
            poster.ObserveField("loadStatus", "OnPosterLoaded")

            glyph_count += 1
        end for

        PreviousHeight += lb.height + 6
        count += 1

        print
    end for

    print "End of FavoriteAddresses"

    ' MAYBE {Daniel Zheleznov} {05/12/2025} Multipage faviorite worlds

end sub