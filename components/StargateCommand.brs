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
    m.CenterGroup = m.top.FindNode("CenterGroup")
    m.RightGorup = m.top.FindNode("RightGroup")
    m.FavoriteAddresses = m.top.FindNode("FavoriteAddresses")

    RenderFavoriteAddresses(Resolution, m.FavoriteAddresses)
    RenderSGCLogo(Resolution, m.CenterGroup)
    RenderRight(Resolution, m.RightGorup)

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

sub ChangeSGCLogo()
    Symbols = [        
        "pkg:/images/SGC-Logo/logo00001.png",
        "pkg:/images/SGC-Logo/logo00002.png",
        "pkg:/images/SGC-Logo/logo00003.png",
        "pkg:/images/SGC-Logo/logo00004.png",
        "pkg:/images/SGC-Logo/logo00005.png",
        "pkg:/images/SGC-Logo/logo00006.png",
        "pkg:/images/SGC-Logo/logo00007.png",
        "pkg:/images/SGC-Logo/logo00008.png",
        "pkg:/images/SGC-Logo/logo00009.png",
        "pkg:/images/SGC-Logo/logo00010.png",
        "pkg:/images/SGC-Logo/logo00011.png",
        "pkg:/images/SGC-Logo/logo00012.png",
        "pkg:/images/SGC-Logo/logo00013.png",
        "pkg:/images/SGC-Logo/logo00014.png",
        "pkg:/images/SGC-Logo/logo00015.png",
        "pkg:/images/SGC-Logo/logo00016.png",
        "pkg:/images/SGC-Logo/logo00017.png",
        "pkg:/images/SGC-Logo/logo00018.png",
        "pkg:/images/SGC-Logo/logo00019.png",
        "pkg:/images/SGC-Logo/logo00020.png",
        "pkg:/images/SGC-Logo/logo00021.png",
        "pkg:/images/SGC-Logo/logo00022.png",
        "pkg:/images/SGC-Logo/logo00023.png",
        "pkg:/images/SGC-Logo/logo00024.png",
        "pkg:/images/SGC-Logo/logo00025.png",
        "pkg:/images/SGC-Logo/logo00026.png",
        "pkg:/images/SGC-Logo/logo00027.png",
        "pkg:/images/SGC-Logo/logo00028.png",
        "pkg:/images/SGC-Logo/logo00029.png",
        "pkg:/images/SGC-Logo/logo00030.png",
        "pkg:/images/SGC-Logo/logo00031.png",
        "pkg:/images/SGC-Logo/logo00032.png",
        "pkg:/images/SGC-Logo/logo00033.png",
        "pkg:/images/SGC-Logo/logo00034.png",
        "pkg:/images/SGC-Logo/logo00035.png",
        "pkg:/images/SGC-Logo/logo00036.png",
        "pkg:/images/SGC-Logo/logo00037.png",
        "pkg:/images/SGC-Logo/logo00038.png",
        "pkg:/images/SGC-Logo/logo00039.png",
        "pkg:/images/SGC-Logo/logo00040.png",
        "pkg:/images/SGC-Logo/logo00041.png",
        "pkg:/images/SGC-Logo/logo00042.png",
        "pkg:/images/SGC-Logo/logo00043.png",
        "pkg:/images/SGC-Logo/logo00044.png",
        "pkg:/images/SGC-Logo/logo00045.png",
        "pkg:/images/SGC-Logo/logo00046.png",
        "pkg:/images/SGC-Logo/logo00047.png",
        "pkg:/images/SGC-Logo/logo00048.png",
        "pkg:/images/SGC-Logo/logo00049.png",
        "pkg:/images/SGC-Logo/logo00050.png",
        "pkg:/images/SGC-Logo/logo00051.png",
        "pkg:/images/SGC-Logo/logo00052.png",
        "pkg:/images/SGC-Logo/logo00053.png",
        "pkg:/images/SGC-Logo/logo00054.png",
        "pkg:/images/SGC-Logo/logo00055.png",
        "pkg:/images/SGC-Logo/logo00056.png",
        "pkg:/images/SGC-Logo/logo00057.png",
        "pkg:/images/SGC-Logo/logo00058.png",
        "pkg:/images/SGC-Logo/logo00059.png",
        "pkg:/images/SGC-Logo/logo00060.png"
    ]

    m.SGCLogoPosterIndex += 1
    m.SGCLogoPosterIndex = m.SGCLogoPosterIndex mod Symbols.Count()
    
    if m.SGCPosterMode = 1 then
        m.SGCLogoPoster1.visible = false
        m.SGCLogoPoster2.uri = Symbols[m.SGCLogoPosterIndex]
        m.SGCLogoPoster1.uri = Symbols[(m.SGCLogoPosterIndex+1) mod Symbols.Count()]
        m.SGCLogoPoster2.visible = true
        m.SGCPosterMode = 2
    else
        m.SGCLogoPoster2.visible = false
        m.SGCLogoPoster1.uri = Symbols[m.SGCLogoPosterIndex]
        m.SGCLogoPoster2.uri = Symbols[(m.SGCLogoPosterIndex+1) mod Symbols.Count()]
        m.SGCLogoPoster1.visible = true
        m.SGCPosterMode = 1       
    end if
    
    print m.SGCLogoPoster1.visible; " 2: "; m.SGCLogoPoster2.visible
end sub

sub RenderSGCLogo(Resolution as Object, Node as Object)
    Symbols = [        
        "pkg:/images/SGC-Logo/logo00001.png",
        "pkg:/images/SGC-Logo/logo00002.png",
        "pkg:/images/SGC-Logo/logo00003.png",
        "pkg:/images/SGC-Logo/logo00004.png",
        "pkg:/images/SGC-Logo/logo00005.png",
        "pkg:/images/SGC-Logo/logo00006.png",
        "pkg:/images/SGC-Logo/logo00007.png",
        "pkg:/images/SGC-Logo/logo00008.png",
        "pkg:/images/SGC-Logo/logo00009.png",
        "pkg:/images/SGC-Logo/logo00010.png",
        "pkg:/images/SGC-Logo/logo00011.png",
        "pkg:/images/SGC-Logo/logo00012.png",
        "pkg:/images/SGC-Logo/logo00013.png",
        "pkg:/images/SGC-Logo/logo00014.png",
        "pkg:/images/SGC-Logo/logo00015.png",
        "pkg:/images/SGC-Logo/logo00016.png",
        "pkg:/images/SGC-Logo/logo00017.png",
        "pkg:/images/SGC-Logo/logo00018.png",
        "pkg:/images/SGC-Logo/logo00019.png",
        "pkg:/images/SGC-Logo/logo00020.png",
        "pkg:/images/SGC-Logo/logo00021.png",
        "pkg:/images/SGC-Logo/logo00022.png",
        "pkg:/images/SGC-Logo/logo00023.png",
        "pkg:/images/SGC-Logo/logo00024.png",
        "pkg:/images/SGC-Logo/logo00025.png",
        "pkg:/images/SGC-Logo/logo00026.png",
        "pkg:/images/SGC-Logo/logo00027.png",
        "pkg:/images/SGC-Logo/logo00028.png",
        "pkg:/images/SGC-Logo/logo00029.png",
        "pkg:/images/SGC-Logo/logo00030.png",
        "pkg:/images/SGC-Logo/logo00031.png",
        "pkg:/images/SGC-Logo/logo00032.png",
        "pkg:/images/SGC-Logo/logo00033.png",
        "pkg:/images/SGC-Logo/logo00034.png",
        "pkg:/images/SGC-Logo/logo00035.png",
        "pkg:/images/SGC-Logo/logo00036.png",
        "pkg:/images/SGC-Logo/logo00037.png",
        "pkg:/images/SGC-Logo/logo00038.png",
        "pkg:/images/SGC-Logo/logo00039.png",
        "pkg:/images/SGC-Logo/logo00040.png",
        "pkg:/images/SGC-Logo/logo00041.png",
        "pkg:/images/SGC-Logo/logo00042.png",
        "pkg:/images/SGC-Logo/logo00043.png",
        "pkg:/images/SGC-Logo/logo00044.png",
        "pkg:/images/SGC-Logo/logo00045.png",
        "pkg:/images/SGC-Logo/logo00046.png",
        "pkg:/images/SGC-Logo/logo00047.png",
        "pkg:/images/SGC-Logo/logo00048.png",
        "pkg:/images/SGC-Logo/logo00049.png",
        "pkg:/images/SGC-Logo/logo00050.png",
        "pkg:/images/SGC-Logo/logo00051.png",
        "pkg:/images/SGC-Logo/logo00052.png",
        "pkg:/images/SGC-Logo/logo00053.png",
        "pkg:/images/SGC-Logo/logo00054.png",
        "pkg:/images/SGC-Logo/logo00055.png",
        "pkg:/images/SGC-Logo/logo00056.png",
        "pkg:/images/SGC-Logo/logo00057.png",
        "pkg:/images/SGC-Logo/logo00058.png",
        "pkg:/images/SGC-Logo/logo00059.png",
        "pkg:/images/SGC-Logo/logo00060.png"
    ]

    SGCLogoWidth = (Resolution.width-12) * (3/5)
    SGCLogoHeight = (Resolution.height-12) ' TODO {Daniel Zheleznov} [5/14/2025] Fix this to fit the Status

    print "[StargateCommand] Prerendering SGCLogo"
    
    print "[StargateCommand] Rendering SGCLogo"

    timer = m.top.findNode("SGCLogoTimer")
    timer.ObserveField("fire", "ChangeSGCLogo")

    m.SGCPosterMode = 1
    m.SGCLogoPosterIndex = 0

    m.SGCLogoPoster1 = Node.CreateChild("Poster")
    m.SGCLogoPoster1.width = SGCLogoWidth
    m.SGCLogoPoster1.height = SGCLogoHeight
    m.SGCLogoPoster1.uri = Symbols[m.SGCLogoPosterIndex]
    m.SGCLogoPoster1.translation = [
        ((Resolution.width) * (1/5)) + 6,
        6
    ]
    'm.SGCLogoPoster1.ObserveField("loadStatus", "OnPosterLoaded")
    
    m.SGCLogoPoster2 = Node.CreateChild("Poster")
    m.SGCLogoPoster2.visible = false
    m.SGCLogoPoster2.width = SGCLogoWidth
    m.SGCLogoPoster2.height = SGCLogoHeight
    m.SGCLogoPoster2.uri = Symbols[m.SGCLogoPosterIndex + 1]
    m.SGCLogoPoster2.translation = [
        ((Resolution.width) * (1/5)) + 6,
        6
    ]
    'm.SGCLogoPoster2.ObserveField("loadStatus", "OnPosterLoaded")

end sub

sub OnClockTick()
    dt = CreateObject("roDateTime")
    dt.ToLocalTime()

    m.DateTimeLB.text = dt.AsDateString("no-weekday")
    m.WeekdayLB.text = dt.GetWeekday()
    m.TimeLB.text = dt.AsTimeStringLoc("hh:mm a")
end sub

sub RenderRight(Resolution as Object, Node as Object)

    DateTime = CreateObject("roDateTime")
    DateTime.ToLocalTime()

    RightSideWidth = Resolution.width * (1/5)

    timer = m.top.findNode("ClockTimer")
    timer.ObserveField("fire", "OnClockTick")

    BackgroundRect = Node.CreateChild("Rectangle")
    BackgroundRect.width = RightSideWidth
    BackgroundRect.translation = [Resolution.width - BackgroundRect.width - 6, 6]
    BackgroundRect.color = "0x5DC6CDFF"

    BabyBackgroundRect = Node.CreateChild("Rectangle")
    BabyBackgroundRect.width = RightSideWidth - 6
    BabyBackgroundRect.translation = [Resolution.width - BabyBackgroundRect.width - 9, 9]
    BabyBackgroundRect.color = "0x000000FF"

    m.DateTimeLB = Node.CreateChild("Label")
    m.DateTimeLB.text = DateTime.AsDateString("no-weekday")
    m.DateTimeLB.font = "font:LargeSystemFont"
    m.DateTimeLB.visible = true
    m.DateTimeLB.horizAlign = "right"
    m.DateTimeLB.vertAlign = "center"
    m.DateTimeLB.width =  m.DateTimeLB.BoundingRect().width + 6
    m.DateTimeLB.translation = [Resolution.width - m.DateTimeLB.width - 12, 9]
    m.DateTimeLB.height = m.DateTimeLB.BoundingRect().height + 6
    m.DateTimeLB.color = "0xF5F5F5FF"

    m.WeekdayLB = Node.CreateChild("Label")
    m.WeekdayLB.text = DateTime.GetWeekday()
    m.WeekdayLB.font = "font:MediumSystemFont"
    m.WeekdayLB.visible = true
    m.WeekdayLB.horizAlign = "right"
    m.WeekdayLB.vertAlign = "center"
    m.WeekdayLB.width = BabyBackgroundRect.width - 6
    m.WeekdayLB.translation = [Resolution.width - m.WeekdayLB.width - 12, m.DateTimeLB.BoundingRect().y + m.DateTimeLB.BoundingRect().height]
    m.WeekdayLB.height = m.WeekdayLB.BoundingRect().height + 3
    m.WeekdayLB.color = "0xF5F5F5FF"

    m.TimeLB = Node.CreateChild("Label")
    m.TimeLB.text = DateTime.AsTimeStringLoc("hh:mm a")
    m.TimeLB.font = "font:MediumSystemFont"
    m.TimeLB.visible = true
    m.TimeLB.horizAlign = "right"
    m.TimeLB.vertAlign = "center"
    m.TimeLB.width =  BabyBackgroundRect.width - 6
    m.TimeLB.translation = [Resolution.width - m.WeekdayLB.width - 12, m.WeekdayLB.BoundingRect().y + m.WeekdayLB.BoundingRect().height]
    m.TimeLB.height = m.TimeLB.BoundingRect().height + 3
    m.TimeLB.color = "0xF5F5F5FF"

    BackgroundRect.height = m.TimeLB.BoundingRect().y + m.TimeLB.BoundingRect().height
    BabyBackgroundRect.height = BackgroundRect.height - 6

    BackgroundRect.width = (m.DateTimeLB.width + 12)
    BackgroundRect.translation = [Resolution.width - BackgroundRect.width - 6, 6]

    BabyBackgroundRect.width = BackgroundRect.width - 6
    BabyBackgroundRect.translation = [Resolution.width - BabyBackgroundRect.width - 9, 9]
end sub