sub Logger(section, action)
    SECTION_WIDTH = 10

    length = Len(section)
    additional_pad = SECTION_WIDTH - length
    left_pad = Int(additional_pad/2)
    right_pad = Int(additional_pad/2)

    print "[" + string(left_pad, " ") + section + string(right_pad, " ") + "] " + action
endsub

function GetDeltatime()
    return m.dt
endfunction

' Event Bus
sub EventBus_Subscribe(event_name, function_name)
    m.event_bus = {}
endsub


' Plugin Manager
sub PluginManager_AddPlugin(plugin_id, init_func, loop_func, layout_info)
    if m.plugins = invalid
        m.plugins = {}
    endif

    m.plugins[plugin_id] = {
        init: init_func,
        loop: loop_func,
        state: {},
        initalized: false
    }
    LayoutManager_Allocate(plugin_id, layout_info)
endsub

sub PluginManager_InitAll(app_ctx)
    for each plugin_id in m.plugins
        try
            m.plugins[plugin_id].init(app_ctx, m.plugins[plugin_id].state)
            Logger("PluginInit", "Initalized: '" + plugin_id + "'")
            m.plugins[plugin_id].initalized = true
        catch e
            backtrace = e.backtrace[e.backtrace.Count()-1]
            Logger("PluginInit", "Couldn't initalized: '" + plugin_id + "'" + ". Details: " + backtrace.function + " (line " + backtrace.line_number + ")")
        endtry
    endfor
endsub

sub PluginManager_Loop(app_ctx)
    for each plugin_id in m.plugins
        render_ctx = LayoutManager_Get(plugin_id).actual

        if m.plugins[plugin_id].initalized
            m.plugins[plugin_id].loop(app_ctx, m.plugins[plugin_id].state, render_ctx)
        endif
    endfor
endsub

' sub RunScreenSaver()
sub Main()
    screen = CreateObject("roScreen", true, 1280, 720)
    port = CreateObject("roMessagePort")
    screen.SetMessagePort(port)
    Logger("Startup", "Screen, port had normal startup.")

    font_reg = CreateObject("roFontRegistry")
    font_reg.Register("pkg:/fonts/KodeMono-Medium.ttf")

    app_ctx = { 
        screen: screen, 
        font: font_reg.GetFont("Kode Mono Medium", 13, false, false), 
        l_font: font_reg.GetFont("Kode Mono Medium", 17, false, false), 
        xl_font: font_reg.GetFont("Kode Mono Medium", 21, false, false), 
        xxl_font: font_reg.GetFont("Kode Mono Medium", 25, false, false), 
    }

    ' PluginManager_AddPlugin("term", TerminalEmulator_Init, TerminalEmulator_Loop, { expand: true })

    PluginManager_AddPlugin("system-internals", SystemInternals_Init, SystemInternals_Loop, { expand: false })    
    PluginManager_AddPlugin("chevron-status", ChevronStatus_Init, ChevronStatus_Loop, { expand: false })
    PluginManager_AddPlugin("time", Time_Init, Time_Loop, { expand: true, side: "top" })
    PluginManager_AddPlugin("chevron-symbols", ChevronSymbols_Init, ChevronSymbols_Loop, { expand: true, side: "right" })

    if m.plugins <> invalid
        PluginManager_InitAll(app_ctx)
        LayoutManager_Update() 
        m.slot_phase = 0 ' For LayoutManager Breathe
    endif

    timer = CreateObject("roTimespan")
    old_time = timer.TotalMilliseconds()

    while true
        now = timer.TotalMilliseconds()
        m.dt = (now - old_time) / 1000.0
        old_time = now

        screen.Clear(&h000000FF)

        if m.plugins <> invalid
            PluginManager_Loop(app_ctx)
            LayoutManager_Update()
            ' LayoutManager_Breathe()
        endif

        screen.SwapBuffers()

        msg = port.GetMessage()

        if msg <> invalid then
            Logger("Shutdown", "Good bye my friend.")
            exitwhile
        endif
    endwhile
endsub