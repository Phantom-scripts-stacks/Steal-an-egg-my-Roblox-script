local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

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

-- [ MAIN TAB: SCRIPTS & UTILITIES ]
local MainTab = Window:Tab({
    Title = "Scripts steal an egg",
    Icon = "home"
})

-- [ BUTTON 1 ] (you can change this)
MainTab:Button({
    Title = "Steal an Egg Script 1",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/miirandahub/loader/main/stealaeggs"))()
        end)
    end
})

-- [ BUTTON 2 ] (you can change this)
MainTab:Button({
    Title = "Steal an Egg Script 2",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/lennonscripts/lennonstubs2/refs/heads/main/stealeggs"))()
        end)
    end
})

-- [ BUTTON 3 ] (you can change this)
MainTab:Button({
    Title = "Script 3",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/55bf341d087ba3acd5190a5d6d4d9824.lua"))()
        end)
    end
})

-- [ BUTTON 4 ] (you can change this)
MainTab:Button({
    Title = "Script Slot 4",
    Callback = function()
        pcall(function()
            -- (you can change this link)
            loadstring(game:HttpGet("PUT_LINK_HERE"))()
        end)
    end
})

-- [ BUTTON 5 ] (you can change this)
MainTab:Button({
    Title = "Script Slot 5",
    Callback = function()
        pcall(function()
            -- (you can change this link)
            loadstring(game:HttpGet("PUT_LINK_HERE"))()
        end)
    end
})

-- [ BUTTON 6 ] (you can change this)
MainTab:Button({
    Title = "Script Slot 6",
    Callback = function()
        pcall(function()
            -- (you can change this link)
            loadstring(game:HttpGet("PUT_LINK_HERE"))()
        end)
    end
})

-- [ BUTTON 7 ] (you can change this)
MainTab:Button({
    Title = "Script Slot 7",
    Callback = function()
        pcall(function()
            -- (you can change this link)
            loadstring(game:HttpGet("PUT_LINK_HERE"))()
        end)
    end
})

-- [ BUTTON 8 ] (you can change this)
MainTab:Button({
    Title = "Script Slot 8",
    Callback = function()
        pcall(function()
            -- (you can change this link)
            loadstring(game:HttpGet("PUT_LINK_HERE"))()
        end)
    end
})

-- [ BUTTON 9 ] (you can change this)
MainTab:Button({
    Title = "Script Slot 9",
    Callback = function()
        pcall(function()
            -- (you can change this link)
            loadstring(game:HttpGet("PUT_LINK_HERE"))()
        end)
    end
})

-- [ BUTTON 10 ] (you can change this)
MainTab:Button({
    Title = "Script Slot 10",
    Callback = function()
        pcall(function()
            -- (you can change this link)
            loadstring(game:HttpGet("PUT_LINK_HERE"))()
        end)
    end
})

-- [ UTILITIES TAB: SERVER HOP & ANTI AFK ]
local UtilsTab = Window:Tab({
    Title = "Utilities",
    Icon = "wrench"
})

UtilsTab:Button({
    Title = "Server Hop",
    Callback = function()
        pcall(function()
            local TeleportService = game:GetService("TeleportService")
            local Players = game:GetService("Players")
            local req = http and http.request or syn and syn.request or request
            if req then
                local servers = {}
                local cursor = ""
                repeat
                    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100" .. (cursor ~= "" and "&cursor=" .. cursor or "")
                    local body = game:GetService("HttpService"):JSONDecode(req({Url = url}).Body)
                    cursor = body.nextPageCursor
                    for _, v in ipairs(body.data) do
                        if v.playing < v.maxPlayers and v.id ~= game.JobId then
                            table.insert(servers, v.id)
                        end
                    end
                until cursor == nil or #servers > 0
                if #servers > 0 then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], Players.LocalPlayer)
                else
                    WindUI:Notify({ Title = "Server Hop", Content = "No other servers found!", Duration = 3 })
                end
            else
                TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
            end
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

-- [ OWNER TAB: CREDITS ]
local OwnerTab = Window:Tab({
    Title = "Owner",
    Icon = "user"
})

OwnerTab:Paragraph({
    Title = "Hub Information",
    Content = "Hub Name: MAMAAAA Hub\nOwner / Creator: UNKNOWN\nStatus: Active & Working"
})

WindUI:Notify({
    Title = "MAMAAAA Hub",
    Content = "Hub loaded successfully with Utilities & Owner tab!",
    Duration = 3
})
