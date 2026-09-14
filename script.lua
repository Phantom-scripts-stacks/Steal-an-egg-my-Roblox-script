-- ==========================================
-- [ ANTI-DETECT & PROTECTION ]
-- ==========================================
pcall(function()
    if getgenv then
        getgenv().MAMAAAA_PROTECTION = true
        
        for _, v in pairs({"hookfunction", "setreadonly", "make_writeable"}) do
            if not rawget(getgenv(), v) then
                local success = pcall(function() return _G[v] end)
            end
        end
    end
    
    local mt = getrawmetatable(game)
    if mt and setreadonly then
        setreadonly(mt, false)
        local oldIndex = mt.__namecall
        setreadonly(mt, true)
    end
end)

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- [ EXECUTION SOUND EFFECT ]
pcall(function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://4590657391" -- You can change this to your preferred Sound ID
    sound.Volume = 1
    sound.Parent = game:GetService("CoreGui")
    sound:Play()
end)

local Window = WindUI:CreateWindow({
    Title = "MAMAAAA Hub",
    Icon = "shield",
    Author = "UNKNOWN",
    Folder = "MAMAAAAHub",
    Size = UDim2.fromOffset(500, 350),
    Theme = "Dark",
    Acrylic = false
})

Window:ToggleTransparency(false)

-- ==========================================
-- [ MAIN TAB: STEAL AN EGG SCRIPTS ]
-- ==========================================
local MainTab = WindUI:Tab({
    Title = "Steal an Egg",
    Icon = "home"
})

MainTab:Button({
    Title = "Steal an Egg Script 1",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/eiltrunduhub/loader/main/stealeggs"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 2",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/lennonscripts/lennonstubs2/refs/heads/main/stealeggs"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 3",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/55bf341d087ba3acd5190a5d6d4d9824.lua"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 4",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 5",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 6",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 7",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 8",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 9",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

MainTab:Button({
    Title = "Steal an Egg Script 10",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("(put your script here)"))()
        end)
    end
})

-- ==========================================
-- [ UTILITIES TAB: SERVER FINDER & ANTI AFK ]
-- ==========================================
local UtilsTab = WindUI:Tab({
    Title = "Utilities",
    Icon = "wrench"
})

UtilsTab:Button({
    Title = "Server Finder",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Low-Server-Finder-GUI-30660"))()
        end)
    end
})

UtilsTab:Button({
    Title = "Anti AFK",
    Callback = function()
        pcall(function()
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
            WindUI:Notify({ Title = "Anti AFK", Content = "Anti AFK is now Active!", Duration = 3 })
        end)
    end
})

-- ==========================================
-- [ OWNER TAB: CREDITS ]
-- ==========================================
local OwnerTab = WindUI:Tab({
    Title = "Owner",
    Icon = "user"
})

OwnerTab:Paragraph({
    Title = "Hub Information",
    Content = "Hub Name: MAMAAAA Hub\nOwner / Creator: UNKNOWN\nStatus: Active & Protected"
})

WindUI:Notify({
    Title = "MAMAAAA Hub",
    Content = "MAMAA HUB SUCCESSFULLY LOADED,
    Duration = 3
})
