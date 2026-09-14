local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "its_me-bj Hub",
    Icon = "shield",
    Author = "UNKNOWN",
    Folder = "MAMAAAAHub",
    Size = UDim2.fromOffset(500, 350),
    Theme = "Dark",
    Acrylic = false
})

local MainTab = Window:Tab({
    Title = "Main Scripts",
    Icon = "home"
})

-- MIRANDA
MainTab:Button({
    Title = "MIRANDA",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/miirandahub/loader/main/stealaeggs"))()
        end)
    end
})

-- LENNON
MainTab:Button({
    Title = "LENNON",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/lennonxscripts/lennonhubv2/refs/heads/main/stealaneggv2"))()
        end)
    end
})

-- RENE BATERBONIA
MainTab:Button({
    Title = "RENE BATERBONIA",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/sabscrip-arch/srver/refs/heads/main/Stealanegg"))()
        end)
    end
})

-- [ BUTTON 4 ]
MainTab:Button({
    Title = "Script Slot 4",
    Callback = function()
        pcall(function()
            -- I-paste ang link diri puhon
        end)
    end
})

-- [ BUTTON 5 ]
MainTab:Button({
    Title = "Script Slot 5",
    Callback = function()
        pcall(function()
            -- I-paste ang link diri puhon
        end)
    end
})

-- [ BUTTON 6 ]
MainTab:Button({
    Title = "Script Slot 6",
    Callback = function()
        pcall(function()
            -- I-paste ang link diri puhon
        end)
    end
})

-- [ BUTTON 7 ]
MainTab:Button({
    Title = "Script Slot 7",
    Callback = function()
        pcall(function()
            -- I-paste ang link diri puhon
        end)
    end
})

-- [ BUTTON 8 ]
MainTab:Button({
    Title = "Script Slot 8",
    Callback = function()
        pcall(function()
            -- I-paste ang link diri puhon
        end)
    end
})

-- [ BUTTON 9 ]
MainTab:Button({
    Title = "Script Slot 9",
    Callback = function()
        pcall(function()
            -- I-paste ang link diri puhon
        end)
    end
})

-- [ BUTTON 10 ]
MainTab:Button({
    Title = "Script Slot 10",
    Callback = function()
        pcall(function()
            -- I-paste ang link diri puhon
        end)
    end
})

WindUI:Notify({
    Title = "MAMAAAA Hub",
    Content = "Na-load successfully ang 10 Slots!",
    Duration = 3
})
