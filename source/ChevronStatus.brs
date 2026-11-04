sub ChevronStatus_Init(app_ctx, state)
    state.chevron_status = [
        true,
        true,
        true,
        true,
        true,
        true,
        true,
    ]
endsub

sub ChevronStatus_Loop(app_ctx, state, render_ctx) 
    ' Lil border box
    app_ctx.screen.DrawRect(render_ctx.x, render_ctx.y, render_ctx.width, render_ctx.height, &h011926FF)
    app_ctx.screen.DrawRect(render_ctx.x + 2, render_ctx.y + 2, render_ctx.width - 4, render_ctx.height - 4, &h000000FF)

    width = render_ctx.width - 8
    col_width = (width - ( 3 * 2 )) / 3

    y = render_ctx.y + 6

    for i = 0 to state.chevron_status.Count() - 1
        chevron = state.chevron_status[i]

        app_ctx.screen.DrawRect(render_ctx.x + 6, y, col_width, 20, &h424242FF)
        app_ctx.screen.DrawRect(render_ctx.x + 7, y + 1, col_width - 2, 20 - 2, &h000000FF)

        app_ctx.screen.DrawRect(render_ctx.x + col_width + 8, y, col_width, 20, &h424242FF)
        app_ctx.screen.DrawRect(render_ctx.x + col_width + 9, y + 1, col_width - 2, 20 - 2, &h000000FF)

        app_ctx.screen.DrawText(StrI(i + 1), render_ctx.x + (col_width * 2) + 9, y + 1, &hE0CA3CFF, app_ctx.l_font)

        if chevron
            app_ctx.screen.DrawRect(render_ctx.x + col_width + 9, y + 1, col_width - 2, 20 - 2, &h35833CFF)
            app_ctx.screen.DrawText("OK", render_ctx.x + (col_width * 2) + 9 + 2 + app_ctx.l_font.GetOneLineWidth("00", 17 * 2) + 20, y + 4, &hE0CA3CFF, app_ctx.font)
        else
            app_ctx.screen.DrawRect(render_ctx.x + 7, y + 1, col_width - 2, 20 - 2, &hFF200CFF)
        endif

        y += 20
    endfor

    LayoutManager_Get("chevron-status").preferred.height = (y - render_ctx.y) + app_ctx.l_font.GetOneLineHeight()
endsub