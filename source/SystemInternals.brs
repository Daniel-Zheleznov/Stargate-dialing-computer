sub SystemInternals_Init(app_ctx, state)
    state.timer = CreateObject("roTimespan")
    state.last_time = state.timer.TotalSeconds()

    state.text = {}
    SystemInternalsP_RefreshContent(state)
endsub

sub SystemInternals_Loop(app_ctx, state, render_ctx) 
    now = state.timer.TotalSeconds()

    if now - state.last_time >= 10
        SystemInternalsP_RefreshContent(state)
        state.last_time = now
    endif

    ' Lil border box
    app_ctx.screen.DrawRect(render_ctx.x, render_ctx.y, render_ctx.width, render_ctx.height, &h011926FF)
    app_ctx.screen.DrawRect(render_ctx.x + 2, render_ctx.y + 2, render_ctx.width - 4, render_ctx.height - 4, &h000000FF)
    
    y = 0    
    app_ctx.screen.DrawText(state.text["network-name"], render_ctx.x + 5, render_ctx.y + 5, &hE0CA3CFF, app_ctx.l_font)

    y += app_ctx.l_font.GetOneLineHeight()
    app_ctx.screen.DrawText("Model: " + state.text["model"], render_ctx.x + 5, render_ctx.y + 5 + y, &hE0CA3CFF, app_ctx.font)

    if state.text["active"] = "True"
        y += app_ctx.font.GetOneLineHeight()
        app_ctx.screen.DrawText("IPv4: " + state.text["ipv4-address"], render_ctx.x + 5, render_ctx.y + 5 + y, &hE0CA3CFF, app_ctx.font)
    endif
    
    y += app_ctx.font.GetOneLineHeight()
    app_ctx.screen.DrawText("Memory level: " + state.text["memory"], render_ctx.x + 5, render_ctx.y + 5 + y, &hE0CA3CFF, app_ctx.font)

    y += app_ctx.font.GetOneLineHeight() * 2
    LayoutManager_Get("system-internals").actual.height = y
endsub

sub SystemInternalsP_RefreshContent(state)
    device = CreateObject("roDeviceInfo")

    general_memory = device.GetGeneralMemoryLevel()
    memory_usage = UCase(Left(general_memory, 1)) + Mid(general_memory, 2, Len(general_memory) + 1)
    
    ' Get model name
    state.text["model"] = device.GetModel()
    
    ' Get is active
    if device.GetLinkStatus()
        state.text["active"] = "True"
    else
        state.text["active"] = "False"
    endif

    ' Get network name
    state.text["network-name"] = device.GetFriendlyName()
    
    ' Get IP Addr
    state.text["ipv4-address"] = device.GetConnectionInfo()["ip"]

    ' Get memory usage
    state.text["memory"] = memory_usage
endsub