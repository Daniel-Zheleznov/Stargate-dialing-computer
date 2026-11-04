function TerminalEmulatorP_SystemInternals()
    device = CreateObject("roDeviceInfo")

    general_memory = device.GetGeneralMemoryLevel()
    memory_usage = UCase(Left(general_memory, 1)) + Mid(general_memory, 2, Len(general_memory) + 1)

    output = []
    
    output.Push("")
    output.Push("Device")
    output.Push("------")
    output.Push("Model: " + device.GetModelDisplayName())

    output.Push("")
    output.Push("Network")
    output.Push("-------")
    if device.GetLinkStatus()
        output.Push("Is active: " + "True")
    else
        output.Push("Is active: " + "False")
    endif
    output.Push("Network name: " + device.GetFriendlyName())
    output.Push("IPv4 address: " + device.GetConnectionInfo()["ip"])

    output.Push("")
    output.Push("Memory" )
    output.Push("------")
    output.Push("Memory usage: " + memory_usage)

    return output
endfunction

sub TerminalEmulator_Init(app_ctx, state)
    state.timer = CreateObject("roTimespan")
    state.old_time = state.timer.TotalSeconds()

    state.command_offsety = 5

    state.command_line = {
        line: "",
        index: 0,
        active: false,
        last_time: 0
    }

    state.command_output = {
        output: [],
        index: 0,
        active: false,
        last_time: 0
    }

    state.history = []
    state.commands = {}

    state.commands["system-internals"] = TerminalEmulatorP_SystemInternals
endsub

sub TerminalEmulator_Loop(app_ctx, state, render_ctx)
    ' Execute command
    if (state.timer.TotalSeconds() - state.old_time) >= 15
        command_index = Rnd(state.commands.Keys().Count()) - 1
        command_key = state.commands.Keys()[command_index]
        command_output = state.commands[command_key]()

        state.command_line.line = command_key
        state.command_line.index = 0
        state.command_line.active = true

        state.command_output.output = command_output
        state.command_output.index = 0
        state.command_output.active = false

        state.old_time = state.timer.TotalSeconds()
    endif

    ' Type command words
    if state.command_line.active
        if Len(state.command_line.line) > state.command_line.index
            if (state.timer.TotalMilliseconds() - state.command_line.last_time) >= 100
                state.command_line.index = state.command_line.index + 1
                state.command_line.last_time = state.timer.TotalMilliseconds()
            endif
        else
            state.command_line.active = false
            state.command_output.active = true

            state.command_line.index = 0

            state.history.Push("SGT Harris> " + state.command_line.line) 
        endif
    endif

    ' Type command output
    if state.command_output.active
        if state.command_output.output.Count() - 1 > state.command_output.index
            if (state.timer.TotalMilliseconds() - state.command_output.last_time) >= 100
                state.command_output.index = state.command_output.index + 1
                state.command_output.last_time = state.timer.TotalMilliseconds()

                state.history.Push(state.command_output.output[state.command_output.index])
            endif            
        else
            state.command_line.active = false
            state.command_output.active = false
        endif
    endif

    ' Render
    y = state.command_offsety
    for each line in state.history
        app_ctx.screen.DrawText(line, render_ctx.x + 5, render_ctx.y + y, &hFFFFFFFF, app_ctx.font)
        y += app_ctx.font.GetOneLineHeight()
    endfor
    
    if y > (render_ctx.height - app_ctx.font.GetOneLineHeight())
        state.history.Delete(0)
    endif

    command_words = "SGT Harris> " + Mid(state.command_line.line, 0, state.command_line.index)
    app_ctx.screen.DrawText(command_words, render_ctx.x + 5, render_ctx.height - app_ctx.font.GetOneLineHeight(), &hFFFFFFFF, app_ctx.font)
endsub