' Plugin name: Time
' Creation date [yyyy-mm-dd]: 2026-01-21
' Author: Daniel Zheleznov


sub Time_Init(app_ctx, plugin_state)
    plugin_state.datetime = CreateObject("roDateTime")
    plugin_state.offset_y = 0
endsub

sub Time_Loop(app_ctx, plugin_state, render_ctx)
    plugin_state.datetime.Mark()
    plugin_state.datetime.ToLocalTime()
    
    ' Lil border box
    app_ctx.screen.DrawRect(render_ctx.x, render_ctx.y, render_ctx.width, render_ctx.height, &h011926FF)
    app_ctx.screen.DrawRect(render_ctx.x + 2, render_ctx.y + 2, render_ctx.width - 4, render_ctx.height - 4, &h000000FF)

    y = render_ctx.y + plugin_state.offset_y
    height = 0

    text = plugin_state.datetime.asTimeStringLoc("hh:mm a")
    render = app_ctx.xxl_font.GetOneLineWidth(text, render_ctx.width)
    app_ctx.screen.DrawText(text, render_ctx.x + ((render_ctx.width - render)/2), y, &hE0CA3CFF, app_ctx.xxl_font)
    y += app_ctx.xxl_font.GetOneLineHeight()
    height += app_ctx.xxl_font.GetOneLineHeight()

    text = plugin_state.datetime.asDateStringLoc("MMMM dd, y")
    render = app_ctx.l_font.GetOneLineWidth(text, render_ctx.width)
    app_ctx.screen.DrawText(text, render_ctx.x + ((render_ctx.width - render)/2), y, &hE0CA3CFF, app_ctx.l_font)
    y += app_ctx.l_font.GetOneLineHeight()
    height += app_ctx.l_font.GetOneLineHeight()

    text = plugin_state.datetime.asDateStringLoc("EEEE")
    render = app_ctx.font.GetOneLineWidth(text, render_ctx.width)
    app_ctx.screen.DrawText(text, render_ctx.x + ((render_ctx.width - render)/2), y, &hE0CA3CFF, app_ctx.font)
    y += app_ctx.font.GetOneLineHeight()
    height += app_ctx.l_font.GetOneLineHeight()

    new_offset = (render_ctx.height - height) / 2
    if plugin_state.offset_y - new_offset >= 5 or new_offset - plugin_state.offset_y >= 5
        plugin_state.offset_y = new_offset
    endif
endsub