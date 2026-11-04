' Plugin name: ChevronSymbols
' Creation date [yyyy-mm-dd]: 2026-02-08
' Author: Daniel Zheleznov


sub ChevronSymbols_Init(app_ctx, plugin_state)
    ' Your initalization code for the plugin goes here
    
endsub

sub ChevronSymbols_Loop(app_ctx, plugin_state, render_ctx)
    ' Your render loop or update loop for the plugin goes here
    
    ' Lil border box
    ' app_ctx.screen.DrawRect(render_ctx.x, render_ctx.y, render_ctx.width, render_ctx.height, &h011926FF)
    ' app_ctx.screen.DrawRect(render_ctx.x + 2, render_ctx.y + 2, render_ctx.width - 4, render_ctx.height - 4, &h000000FF)

    y = 4
    box_height = ((render_ctx.height - (4 * 8)) / 7)
    for i = 0 to 6
        app_ctx.screen.DrawRect(render_ctx.x + 4 + ((render_ctx.width - 8) / 4), render_ctx.y + y, (render_ctx.width - 8) / 2, box_height, &h011926FF)
        app_ctx.screen.DrawRect(render_ctx.x + 6 + ((render_ctx.width - 8) / 4), render_ctx.y + y + 2, ((render_ctx.width - 8) / 2) - 4, box_height - 4, &h000000FF)

        app_ctx.screen.DrawText(StrI(i + 1), render_ctx.x - (app_ctx.xxl_font.GetOneLineWidth("0", 222) / 2) + ((render_ctx.width - 8) / 4), render_ctx.y + y + 2, &hE0CA3CFF, app_ctx.xxl_font)

        y += box_height + 4
    endfor

endsub