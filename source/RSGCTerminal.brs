function clear()
    m.state.Terminal_Command = ""
    m.state.Terminal_Command_Count = 0
    m.state.Terminal_Command_Done = false
    m.state.Terminal_Counter = 0
    m.state.Terminal_Done = false
    m.state.Terminal_Log = []
    m.state.Terminal_Log_Line = 0
    m.state.Terminal_Shown = []
end function

function about()
    clear()

    m.state.Terminal_Command = "about()"
    m.state.Terminal_Log = [
        "SGC Screensaver",
        "Built for Roku devices",
        "",
        "Developer: Unbandit",
        "Art: Wikipedia, JT Creative Designs",
        ""
    ]
end function

function SelectRandom()
    CurrentSecond = m.state.clock.TotalSeconds()
    if m.state.clock.TotalSeconds() mod m.state.console.interval = 0 and CurrentSecond <> m.state.Terminal_LastTriggerSecond then
        m.state.Terminal_LastTriggerSecond = CurrentSecond
        about()
    endif
end function

sub RSGCTerminal_Init()
    m.state.Terminal_Command = ""
    m.state.Terminal_Log = []
    m.state.Terminal_Command_Count = 0
    m.state.Terminal_Shown = []
    m.state.Terminal_Done = false
    m.state.Terminal_Log_Line = 0
    m.state.Terminal_Counter = 0
    m.state.Terminal_Output_Speed = 3
    m.state.Terminal_Timer = 0
    m.state.Terminal_LastTriggerSecond = 0
end sub


sub RSGCTerminal_Draw()
    Fonts = CreateObject("roFontRegistry")
    UsableFont = Fonts.GetDefaultFont(15, false, false)

    OutsidePadding = m.state.general.opad
    TotalPadding = m.state.general.opad + m.state.general.ipad

    Width  = (m.state.screen.GetWidth() - OutsidePadding - OutsidePadding - OutsidePadding - OutsidePadding)/5
    Height = (m.state.screen.GetHeight() - OutsidePadding - OutsidePadding - OutsidePadding)/2

    m.state.screen.DrawRect(OutsidePadding, m.state.screen.GetHeight() - TotalPadding - Height, Width, Height, &h5DC6CDFF)

    Width  -= m.state.general.ipad * 2
    Height -= m.state.general.ipad * 2
    m.state.screen.DrawRect(TotalPadding, m.state.screen.GetHeight() - Height - TotalPadding - m.state.general.ipad, Width, Height, &h000000FF)

    TextInputX = TotalPadding + m.state.general.ipad
    TextInputY = m.state.screen.GetHeight() - TotalPadding - m.state.general.ipad - UsableFont.GetOneLineHeight()

    if m.state.Terminal_Command <> "" or m.state.Terminal_Log.Count() <> 0 then     
        if m.state.Terminal_Command_Count < m.state.Terminal_Output_Speed * m.state.Terminal_Command.Len() then
            m.state.Terminal_Command_Count++
        else
            m.state.general.Terminal_Command_Done = true
        endif

        EndPos = m.state.Terminal_Command_Count\m.state.Terminal_Output_Speed
        m.state.screen.DrawText("> " + m.state.Terminal_Command.Mid(0, EndPos), TextInputX, TextInputY, &hFFFFFFFF, UsableFont)
        
        m.state.screen.DrawRect(OutsidePadding, TextInputY - m.state.general.ipad, Width + (m.state.general.ipad * 2), m.state.general.ipad, &h5DC6CDFF)

        '' Terminal log
        if m.state.Terminal_Command_Done then
            if m.state.Terminal_Counter < m.state.Terminal_Output_Speed * m.state.Terminal_Log[m.state.Terminal_Log_Line].Len() then
                m.state.Terminal_Counter++
            else
                if m.state.Terminal_Log_Line + 1 <= m.state.Terminal_Log.Count()-1 then
                    m.state.Terminal_Counter = 0
                    m.state.Terminal_Shown.Push(m.state.Terminal_Log[m.state.Terminal_Log_Line])
                    m.state.Terminal_Log_Line++
                else
                    m.state.Terminal_Done = true
                endif
            endif

            LogX = TotalPadding + m.state.general.ipad
            LogY = m.state.screen.GetHeight() - Height - TotalPadding

            if m.state.Terminal_Shown.Count() >= 1 then
                for i=0 to m.state.Terminal_Shown.Count()-1
                    m.state.screen.DrawText(m.state.Terminal_Shown[i], LogX, LogY, &hFFFFFFFF, UsableFont)
                    LogY = LogY + UsableFont.GetOneLineHeight()
                endfor
            endif
            
            EndPos = m.state.Terminal_Counter\m.state.Terminal_Output_Speed
            m.state.screen.DrawText(m.state.Terminal_Log[m.state.Terminal_Log_Line].Mid(0, EndPos), LogX, LogY, &hFFFFFFFF, UsableFont)

            SelectRandom()
        endif
    
    else
        m.state.screen.DrawText("> ", TextInputX, TextInputY, &hFFFFFFFF, UsableFont)
        m.state.screen.DrawRect(OutsidePadding, TextInputY - m.state.general.ipad, Width + (m.state.general.ipad * 2), m.state.general.ipad, &h5DC6CDFF)
    
        SelectRandom()
    end if

end sub