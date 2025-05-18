sub init()
    Screen = CreateObject("roScreen", false, 1280, 720)

    ' Resolution = m.Top.CurrentDesignResolution
    
    ' lb = m.Top.CreateChild("Label")
    ' lb.Text = "CurrentDesignResolution Width: " + str(Resolution.Width) + "; Height: " + str(Resolution.Height)
    ' lb.Translation = [0, 0]
    ' lb.Height = 30
    ' lb.Color = "0xF5F5F5FF"

    ' lb1 = m.Top.CreateChild("Label")
    ' lb1.Text = "CurrentDesignResolution Resolution: " + Resolution.Resolution
    ' lb1.Translation = [0, lb.Height + 5]
    ' lb1.Height = 30
    ' lb1.Color = "0xF5F5F5FF"
    

    ' Device = CreateObject("roDeviceInfo")
    ' lb2 = m.Top.CreateChild("Label")
    ' lb2.Text = "Device ScreenSize: INVALID"
    ' lb2.Translation = [0, lb1.Translation[1] + lb1.Height + 20]
    ' lb2.Height = 30
    ' lb2.Color = "0xF5F5F5FF"

    ' lb3 = m.Top.CreateChild("Label")
    ' lb3.Text = "Device DisplayType: " + Device.GetDisplayType()
    ' lb3.Translation = [0, lb2.Translation[1] + lb2.Height + 5]
    ' lb3.Height = 30
    ' lb3.Color = "0xF5F5F5FF"

    ' lb4 = m.Top.CreateChild("Label")
    ' lb4.Text = "Device DisplayMode: " + Device.GetDisplayType()
    ' lb4.Translation = [0, lb3.Translation[1] + lb3.Height + 5]
    ' lb4.Height = 30
    ' lb4.Color = "0xF5F5F5FF"
    
    ' lb5 = m.Top.CreateChild("Label")
    ' lb5.Text = "Device DisplayAspectRatio: " + Device.GetDisplayAspectRatio()
    ' lb5.Translation = [0, lb4.Translation[1] + lb4.Height + 5]
    ' lb5.Height = 30
    ' lb5.Color = "0xF5F5F5FF"
    
    ' lb6 = m.Top.CreateChild("Label")
    ' lb6.Text = "Device DisplaySize Width: " + str(Device.GetDisplaySize().W) + "; Height: " + str(Device.GetDisplaySize().H)
    ' lb6.Translation = [0, lb5.Translation[1] + lb5.Height + 5]
    ' lb6.Height = 30
    ' lb6.Color = "0xF5F5F5FF"
    
    ' lb7 = m.Top.CreateChild("Label")
    ' lb7.Text = "Device VideoMode: " + Device.GetVideoMode()
    ' lb7.Translation = [0, lb6.Translation[1] + lb6.Height + 5]
    ' lb7.Height = 30
    ' lb7.Color = "0xF5F5F5FF"

    ' lb8 = m.Top.CreateChild("Label")
    ' lb8.Text = "Device UIResolution Width: " + str(Device.GetUIResolution().Width) + "; Hight: " + str(Device.GetUIResolution().Height) + "; Name: " + Device.GetUIResolution().Name
    ' lb8.Translation = [0, lb7.Translation[1] + lb7.Height + 5]
    ' lb8.Height = 30
    ' lb8.Color = "0xF5F5F5FF"

endsub