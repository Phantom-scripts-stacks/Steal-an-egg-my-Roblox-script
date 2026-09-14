local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MAMAAAA Hub",
   LoadingTitle = "Loading Master Hub...",
   LoadingSubtitle = "By UNKNOWN",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Main Scripts", 4483362458)

-- [ BUTTON 1 ]
MainTab:CreateButton({
   Name = "Steal an Egg Script 1",
   Callback = function()
       pcall(function()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/eiltrunduhub/loader/main/stealeggs"))()
       end)
   end,
})

-- [ BUTTON 2 ]
MainTab:CreateButton({
   Name = "Steal an Egg Script 2",
   Callback = function()
       pcall(function()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/miirandahub/loader/main/stealaeggs"))()
       end)
   end,
})

-- [ BUTTON 3 ]
MainTab:CreateButton({
   Name = "Script 3",
   Callback = function()
       pcall(function()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/lennonxscripts/lennonhubv2/refs/heads/main/stealaneggv2"))()
       end)
   end,
})
