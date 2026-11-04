' Plugin name: KnownAddresses
' Creation date [yyyy-mm-dd]: 2026-03-08
' Author: Daniel Zheleznov


sub KnownAddresses_Init(app_ctx, plugin_state)
    ' Your initalization code for the plugin goes here
    
endsub

sub KnownAddresses_Loop(app_ctx, plugin_state, render_ctx)
    ' Your render loop or update loop for the plugin goes here
    
    ' Lil border box
    app_ctx.screen.DrawRect(render_ctx.x, render_ctx.y, render_ctx.width, render_ctx.height, &h011926FF)
    app_ctx.screen.DrawRect(render_ctx.x + 2, render_ctx.y + 2, render_ctx.width - 4, render_ctx.height - 4, &h000000FF)

endsub