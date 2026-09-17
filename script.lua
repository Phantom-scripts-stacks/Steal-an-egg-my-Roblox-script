task.wait(0.5)

local function killAll(conns, threads)
    for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
    for _, t in ipairs(threads) do pcall(function() task.cancel(t) end) end
end

if CB and MF and TW and SG then
    CB.Text = "X"
    CB.MouseButton1Click:Connect(function()
        local cg = Instance.new("ScreenGui", PG)
        cg.Name = "LatinaConfirm_" .. tostring(math.random(1000, 9999))
        cg.ResetOnSpawn = false
        cg.IgnoreGuiInset = true
        cg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        local bd = Instance.new("Frame", cg)
        bd.Size = UDim2.new(1, 0, 1, 0)
        bd.BackgroundColor3 = Color3.new(0, 0, 0)
        bd.BackgroundTransparency = 0.5
        bd.BorderSizePixel = 0
        bd.ZIndex = 1000

        local dlg = Instance.new("Frame", cg)
        dlg.Size = UDim2.new(0, 280, 0, 160)
        dlg.Position = UDim2.new(0.5, -140, 0.5, -80)
        dlg.BackgroundColor3 = Themes[Config.Theme].MainBg
        dlg.BorderSizePixel = 0
        dlg.ZIndex = 1001
        cor(dlg, 12)
        str(dlg, Themes[Config.Theme].Border, 1.5, 0.3)

        local ttl = Instance.new("TextLabel", dlg)
        ttl.Size = UDim2.new(1, 0, 0, 36)
        ttl.BackgroundColor3 = Themes[Config.Theme].TopBar
        ttl.Text = "  Confirm Close"
        ttl.TextColor3 = Themes[Config.Theme].Text
        ttl.TextSize = 13
        ttl.Font = Enum.Font.GothamBold
        ttl.TextXAlignment = Enum.TextXAlignment.Left
        ttl.ZIndex = 1002
        cor(ttl, 12)

        local msgl = Instance.new("TextLabel", dlg)
        msgl.Size = UDim2.new(1, -20, 0, 55)
        msgl.Position = UDim2.new(0, 10, 0, 44)
        msgl.BackgroundTransparency = 1
        msgl.Text = "Are you sure you want to close this window?"
        msgl.TextColor3 = Themes[Config.Theme].Text
        msgl.TextSize = 12
        msgl.Font = Enum.Font.GothamMedium
        msgl.TextWrapped = true
        msgl.TextXAlignment = Enum.TextXAlignment.Center
        msgl.ZIndex = 1002

        local yb = Instance.new("TextButton", dlg)
        yb.Size = UDim2.new(0.45, -10, 0, 36)
        yb.Position = UDim2.new(0, 10, 1, -46)
        yb.BackgroundColor3 = ACR
        yb.Text = "YES"
        yb.TextColor3 = Color3.fromRGB(255, 255, 255)
        yb.TextSize = 13
        yb.Font = Enum.Font.GothamBold
        yb.ZIndex = 1002
        cor(yb, 8)

        local nb = Instance.new("TextButton", dlg)
        nb.Size = UDim2.new(0.45, -10, 0, 36)
        nb.Position = UDim2.new(0.55, 0, 1, -46)
        nb.BackgroundColor3 = Themes[Config.Theme].Element
        nb.Text = "NO"
        nb.TextColor3 = Themes[Config.Theme].Text
        nb.TextSize = 13
        nb.Font = Enum.Font.GothamBold
        nb.ZIndex = 1002
        cor(nb, 8)

        yb.MouseButton1Click:Connect(function()
            cg:Destroy()
            SG:Destroy()
            if BL then BL:Destroy() end
        end)
        nb.MouseButton1Click:Connect(function() cg:Destroy() end)
    end)
end

if TBAR and MF then
    DRG = false
    local dragging = false
    local dragStart, startPos
    TBAR.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
           or input.UserInputType == Enum.UserInputType.Touch then
            local t = input.Target
            if t and (t:IsA("TextButton") or t:IsA("ImageButton") or t:IsA("TextBox")) then return end
            dragging = true
            dragStart = input.Position
            startPos = MF.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
           or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            MF.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
           or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

if ML then
    ML.Position = UDim2.new(1, -180, 0, 4)
    ML.Size = UDim2.new(0, 130, 0, 12)
    ML.ZIndex = 200
end

if DH then DH.ZIndex = 200 end

if MF then
    local rh = Instance.new("TextButton", MF)
    rh.Size = UDim2.new(0, 22, 0, 22)
    rh.Position = UDim2.new(1, -24, 1, -24)
    rh.BackgroundColor3 = Themes[Config.Theme].Element
    rh.BackgroundTransparency = 0.3
    rh.Text = "◢"
    rh.TextColor3 = ACC
    rh.TextSize = 14
    rh.Font = Enum.Font.GothamBold
    rh.AutoButtonColor = false
    rh.ZIndex = 999
    cor(rh, 4)
    str(rh, ACC, 1, 0.5)
    local resizing = false
    local startPos, startSize
    rh.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
           or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            startPos = input.Position
            startSize = MF.Size
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if not resizing then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
           or input.UserInputType == Enum.UserInputType.Touch then
            local d = input.Position - startPos
            MF.Size = UDim2.new(0, math.max(280, startSize.X.Offset + d.X),
                                0, math.max(220, startSize.Y.Offset + d.Y))
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
           or input.UserInputType == Enum.UserInputType.Touch then
            resizing = false
        end
    end)
end
if ATB and AP then
    local MainPage2
    for i, v in ipairs(ATB) do
        if v.TextLabel and v.TextLabel.Text == "Main" then
            MainPage2 = AP[i]
            break
        end
    end
    if MainPage2 then
        addSection(MainPage2, "User Info")
        local card = Instance.new("Frame", MainPage2)
        card.Size = UDim2.new(1, -8, 0, 90)
        card.BackgroundColor3 = Themes[Config.Theme].Element
        card.BackgroundTransparency = 0.15
        card.ZIndex = 104
        cor(card, 8)
        str(card, Themes[Config.Theme].Border, 1, 0.4)
        local av = Instance.new("ImageLabel", card)
        av.Size = UDim2.new(0, 60, 0, 60)
        av.Position = UDim2.new(0, 12, 0, 15)
        av.BackgroundColor3 = Themes[Config.Theme].TopBar
        av.BackgroundTransparency = 0.3
        av.ZIndex = 105
        cor(av, 8)
        local nameLbl = Instance.new("TextLabel", card)
        nameLbl.Size = UDim2.new(1, -90, 0, 22)
        nameLbl.Position = UDim2.new(0, 82, 0, 15)
        nameLbl.BackgroundTransparency = 1
        nameLbl.Text = LP.DisplayName or LP.Name
        nameLbl.TextColor3 = Themes[Config.Theme].Text
        nameLbl.TextSize = 15
        nameLbl.Font = Enum.Font.GothamBold
        nameLbl.TextXAlignment = Enum.TextXAlignment.Left
        nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
        nameLbl.ZIndex = 105
        local userLbl = Instance.new("TextLabel", card)
        userLbl.Size = UDim2.new(1, -90, 0, 18)
        userLbl.Position = UDim2.new(0, 82, 0, 40)
        userLbl.BackgroundTransparency = 1
        userLbl.Text = "@" .. LP.Name
        userLbl.TextColor3 = ACC
        userLbl.TextSize = 13
        userLbl.Font = Enum.Font.GothamBold
        userLbl.TextXAlignment = Enum.TextXAlignment.Left
        userLbl.TextTruncate = Enum.TextTruncate.AtEnd
        userLbl.ZIndex = 105
        local idLbl = Instance.new("TextLabel", card)
        idLbl.Size = UDim2.new(1, -90, 0, 16)
        idLbl.Position = UDim2.new(0, 82, 0, 60)
        idLbl.BackgroundTransparency = 1
        idLbl.Text = "ID: " .. tostring(LP.UserId)
        idLbl.TextColor3 = Themes[Config.Theme].TextDim
        idLbl.TextSize = 10
        idLbl.Font = Enum.Font.Gotham
        idLbl.TextXAlignment = Enum.TextXAlignment.Left
        idLbl.ZIndex = 105
        task.spawn(function()
            pcall(function()
                local thumb = game:GetService("Players"):GetUserThumbnailAsync(
                    LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
                if thumb and av then av.Image = thumb end
            end)
        end)
        addSection(MainPage2, "Live Stats")
        local statCard = Instance.new("Frame", MainPage2)
        statCard.Size = UDim2.new(1, -8, 0, 60)
        statCard.BackgroundColor3 = Themes[Config.Theme].Element
        statCard.BackgroundTransparency = 0.15
        statCard.ZIndex = 104
        cor(statCard, 8)
        str(statCard, Themes[Config.Theme].Border, 1, 0.4)
        local fpsM = Instance.new("TextLabel", statCard)
        fpsM.Size = UDim2.new(0.5, -12, 0, 20)
        fpsM.Position = UDim2.new(0, 12, 0, 10)
        fpsM.BackgroundTransparency = 1
        fpsM.Text = "FPS: --"
        fpsM.TextSize = 12
        fpsM.Font = Enum.Font.GothamBold
        fpsM.TextXAlignment = Enum.TextXAlignment.Left
        fpsM.ZIndex = 105
        local pingM = Instance.new("TextLabel", statCard)
        pingM.Size = UDim2.new(0.5, -12, 0, 20)
        pingM.Position = UDim2.new(0.5, 0, 0, 10)
        pingM.BackgroundTransparency = 1
        pingM.Text = "PING: --"
        pingM.TextSize = 12
        pingM.Font = Enum.Font.GothamBold
        pingM.TextXAlignment = Enum.TextXAlignment.Right
        pingM.ZIndex = 105
        local timeM = Instance.new("TextLabel", statCard)
        timeM.Size = UDim2.new(1, -24, 0, 20)
        timeM.Position = UDim2.new(0, 12, 0, 34)
        timeM.BackgroundTransparency = 1
        timeM.Text = "Session: 00:00:00"
        timeM.TextSize = 11
        timeM.Font = Enum.Font.GothamBold
        timeM.TextXAlignment = Enum.TextXAlignment.Left
        timeM.ZIndex = 105
        local sStart = tick()
        local fc = 0
        local fl = tick()
        task.spawn(function()
            while statCard and statCard.Parent do
                fc = fc + 1
                if tick() - fl >= 1 then
                    fpsM.Text = "FPS: " .. fc
                    fc = 0
                    fl = tick()
                    local p = 0
                    pcall(function() p = math.floor(ST.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
                    pingM.Text = "PING: " .. p .. "ms"
                    local hue = (tick() * 0.3) % 1
                    local rc = Color3.fromHSV(hue, 1, 1)
                    fpsM.TextColor3 = rc
                    pingM.TextColor3 = rc
                    timeM.TextColor3 = rc
                    local el = math.floor(tick() - sStart)
                    timeM.Text = string.format("Session: %02d:%02d:%02d",
                        math.floor(el / 3600), math.floor((el % 3600) / 60), el % 60)
                end
                task.wait(0.1)
            end
        end)
    end
end

if ATB and AP then
    local PlayerPage2
    for i, v in ipairs(ATB) do
        if v.TextLabel and v.TextLabel.Text == "Player" then
            PlayerPage2 = AP[i]
            break
        end
    end
    if PlayerPage2 then
        addSection(PlayerPage2, "Speed Control (1-1000)")
        local speedFrame = Instance.new("Frame", PlayerPage2)
        speedFrame.Size = UDim2.new(1, -8, 0, 80)
        speedFrame.BackgroundColor3 = Themes[Config.Theme].Element
        speedFrame.BackgroundTransparency = 0.15
        speedFrame.ZIndex = 104
        cor(speedFrame, 8)
        str(speedFrame, Themes[Config.Theme].Border, 1, 0.4)
        local speedLbl = Instance.new("TextLabel", speedFrame)
        speedLbl.Size = UDim2.new(1, -16, 0, 20)
        speedLbl.Position = UDim2.new(0, 8, 0, 4)
        speedLbl.BackgroundTransparency = 1
        speedLbl.Text = "Speed: 32"
        speedLbl.TextColor3 = Themes[Config.Theme].Text
        speedLbl.TextSize = 12
        speedLbl.Font = Enum.Font.GothamBold
        speedLbl.TextXAlignment = Enum.TextXAlignment.Left
        speedLbl.ZIndex = 105
        local speedBar = Instance.new("TextButton", speedFrame)
        speedBar.Size = UDim2.new(1, -16, 0, 24)
        speedBar.Position = UDim2.new(0, 8, 0, 30)
        speedBar.BackgroundColor3 = Themes[Config.Theme].TopBar
        speedBar.Text = ""
        speedBar.AutoButtonColor = false
        speedBar.ZIndex = 105
        cor(speedBar, 4)
        local speedFill = Instance.new("Frame", speedBar)
        speedFill.Size = UDim2.new(0.031, 0, 1, 0)
        speedFill.BackgroundColor3 = ACC
        speedFill.BorderSizePixel = 0
        speedFill.ZIndex = 106
        cor(speedFill, 4)
        local speedHint = Instance.new("TextLabel", speedFrame)
        speedHint.Size = UDim2.new(1, -16, 0, 12)
        speedHint.Position = UDim2.new(0, 8, 0, 58)
        speedHint.BackgroundTransparency = 1
        speedHint.Text = "Drag: min 1 / max 1000"
        speedHint.TextColor3 = Themes[Config.Theme].TextDim
        speedHint.TextSize = 8
        speedHint.Font = Enum.Font.Gotham
        speedHint.TextXAlignment = Enum.TextXAlignment.Left
        speedHint.ZIndex = 105
        local MegaSpeedVal = 32
        local speedDragging = false
        local function updateSpeed(input)
            local rel = input.Position.X - speedBar.AbsolutePosition.X
            local pct = math.clamp(rel / math.max(speedBar.AbsoluteSize.X, 1), 0, 1)
            MegaSpeedVal = math.floor(1 + pct * 999)
            speedFill.Size = UDim2.new(pct, 0, 1, 0)
            speedLbl.Text = "Speed: " .. MegaSpeedVal
        end
        speedBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
               or input.UserInputType == Enum.UserInputType.Touch then
                speedDragging = true
                updateSpeed(input)
            end
        end)
        UIS.InputChanged:Connect(function(input)
            if speedDragging and (input.UserInputType == Enum.UserInputType.MouseMovement
               or input.UserInputType == Enum.UserInputType.Touch) then
                updateSpeed(input)
            end
        end)
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
               or input.UserInputType == Enum.UserInputType.Touch then
                speedDragging = false
            end
        end)
        local speedThread
        AddButtonToPage(PlayerPage2, "Custom Speed Slider", function(s)
            if s then
                if speedThread then task.cancel(speedThread) end
                speedThread = task.spawn(function()
                    while true do
                        task.wait(0.1)
                        local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                        if h and h.WalkSpeed ~= MegaSpeedVal then h.WalkSpeed = MegaSpeedVal end
                    end
                end)
                showN("Speed ON: " .. MegaSpeedVal, "success")
            else
                if speedThread then task.cancel(speedThread) speedThread = nil end
                local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                if h then h.WalkSpeed = 16 end
                showN("Speed OFF", "info")
            end
        end, {toggle = true, key = "megaSpeed", icon = "⚡"})
        addSection(PlayerPage2, "Jump Power (1-500)")
        local jpFrame = Instance.new("Frame", PlayerPage2)
        jpFrame.Size = UDim2.new(1, -8, 0, 60)
        jpFrame.BackgroundColor3 = Themes[Config.Theme].Element
        jpFrame.BackgroundTransparency = 0.15
        jpFrame.ZIndex = 104
        cor(jpFrame, 8)
        str(jpFrame, Themes[Config.Theme].Border, 1, 0.4)
        local jpLbl = Instance.new("TextLabel", jpFrame)
        jpLbl.Size = UDim2.new(1, -16, 0, 20)
        jpLbl.Position = UDim2.new(0, 8, 0, 4)
        jpLbl.BackgroundTransparency = 1
        jpLbl.Text = "Jump: 50"
        jpLbl.TextColor3 = Themes[Config.Theme].Text
        jpLbl.TextSize = 12
        jpLbl.Font = Enum.Font.GothamBold
        jpLbl.TextXAlignment = Enum.TextXAlignment.Left
        jpLbl.ZIndex = 105
        local jpBar = Instance.new("TextButton", jpFrame)
        jpBar.Size = UDim2.new(1, -16, 0, 24)
        jpBar.Position = UDim2.new(0, 8, 0, 30)
        jpBar.BackgroundColor3 = Themes[Config.Theme].TopBar
        jpBar.Text = ""
        jpBar.AutoButtonColor = false
        jpBar.ZIndex = 105
        cor(jpBar, 4)
        local jpFill = Instance.new("Frame", jpBar)
        jpFill.Size = UDim2.new(0.1, 0, 1, 0)
        jpFill.BackgroundColor3 = ACC
        jpFill.BorderSizePixel = 0
        jpFill.ZIndex = 106
        cor(jpFill, 4)
        local MegaJumpVal = 50
        local jpDragging = false
        local function updateJP(input)
            local rel = input.Position.X - jpBar.AbsolutePosition.X
            local pct = math.clamp(rel / math.max(jpBar.AbsoluteSize.X, 1), 0, 1)
            MegaJumpVal = math.floor(1 + pct * 499)
            jpFill.Size = UDim2.new(pct, 0, 1, 0)
            jpLbl.Text = "Jump: " .. MegaJumpVal
        end
        jpBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
               or input.UserInputType == Enum.UserInputType.Touch then
                jpDragging = true
                updateJP(input)
            end
        end)
        UIS.InputChanged:Connect(function(input)
            if jpDragging and (input.UserInputType == Enum.UserInputType.MouseMovement
               or input.UserInputType == Enum.UserInputType.Touch) then
                updateJP(input)
            end
        end)
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
               or input.UserInputType == Enum.UserInputType.Touch then
                jpDragging = false
            end
        end)
        local jpThread
        AddButtonToPage(PlayerPage2, "Custom Jump Power", function(s)
            if s then
                if jpThread then task.cancel(jpThread) end
                jpThread = task.spawn(function()
                    while true do
                        task.wait(0.1)
                        local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                        if h then
                            h.UseJumpPower = true
                            h.JumpPower = MegaJumpVal
                        end
                    end
                end)
                showN("Jump ON: " .. MegaJumpVal, "success")
            else
                if jpThread then task.cancel(jpThread) jpThread = nil end
                local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                if h then h.JumpPower = 50 end
                showN("Jump OFF", "info")
            end
        end, {toggle = true, key = "megaJP", icon = "🦘"})
    end
end
if ATB and AP then
    local PlayerPage3
    for i, v in ipairs(ATB) do
        if v.TextLabel and v.TextLabel.Text == "Player" then
            PlayerPage3 = AP[i]
            break
        end
    end
    if PlayerPage3 then
        addSection(PlayerPage3, "Protection")
        local antiRagConn, antiKbConn, antiTrapConn, godConn
        AddButtonToPage(PlayerPage3, "Anti-Ragdoll / Anti-Stun", function(s)
            if s then
                if antiRagConn then antiRagConn:Disconnect() end
                antiRagConn = RS.Heartbeat:Connect(function()
                    local ch = LP.Character
                    if not ch then return end
                    local h = ch:FindFirstChildOfClass("Humanoid")
                    if not h then return end
                    if h.PlatformStand then h.PlatformStand = false end
                    if h.Sit then h.Sit = false end
                    local st = h:GetState()
                    if st == Enum.HumanoidStateType.Ragdoll
                       or st == Enum.HumanoidStateType.FallingDown
                       or st == Enum.HumanoidStateType.Physics then
                        h:ChangeState(Enum.HumanoidStateType.Running)
                    end
                    local root = ch:FindFirstChild("HumanoidRootPart")
                    if root then
                        for _, v in ipairs(root:GetChildren()) do
                            if v:IsA("BallSocketConstraint") or v:IsA("RagdollConstraint") then
                                v:Destroy()
                            end
                        end
                    end
                end)
                showN("Anti-Ragdoll ON", "success")
            else
                if antiRagConn then antiRagConn:Disconnect() antiRagConn = nil end
                showN("Anti-Ragdoll OFF", "info")
            end
        end, {toggle = true, key = "megaAntiRag", icon = "🛡"})
        AddButtonToPage(PlayerPage3, "Anti-Knockback", function(s)
            if s then
                if antiKbConn then antiKbConn:Disconnect() end
                antiKbConn = RS.Heartbeat:Connect(function()
                    local ch = LP.Character
                    if not ch then return end
                    local hrp = ch:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    local hum = ch:FindFirstChildOfClass("Humanoid")
                    local moveDir = hum and hum.MoveDirection or Vector3.zero
                    local vel = hrp.AssemblyLinearVelocity
                    if moveDir.Magnitude < 0.05 then
                        hrp.AssemblyLinearVelocity = Vector3.new(0, vel.Y, 0)
                    end
                    hrp.AssemblyAngularVelocity = Vector3.zero
                    for _, v in ipairs(hrp:GetChildren()) do
                        if v:IsA("BodyVelocity") or v:IsA("BodyThrust") then
                            v:Destroy()
                        end
                    end
                end)
                showN("Anti-Knockback ON", "success")
            else
                if antiKbConn then antiKbConn:Disconnect() antiKbConn = nil end
                showN("Anti-Knockback OFF", "info")
            end
        end, {toggle = true, key = "megaAntiKB", icon = "🚫"})
        AddButtonToPage(PlayerPage3, "Anti-Trap", function(s)
            if s then
                if antiTrapConn then antiTrapConn:Disconnect() end
                antiTrapConn = RS.Heartbeat:Connect(function()
                    local ch = LP.Character
                    if not ch then return end
                    local hrp = ch:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    for _, o in ipairs(workspace:GetDescendants()) do
                        if o:IsA("BasePart") and not o:IsDescendantOf(ch) then
                            local d = (o.Position - hrp.Position).Magnitude
                            if d < 6 and o.Anchored and o.CanCollide then
                                local sz = o.Size
                                if sz.X < 20 and sz.Y < 20 and sz.Z < 20 then
                                    o.CanCollide = false
                                end
                            end
                        end
                    end
                    for _, cc in ipairs(hrp:GetChildren()) do
                        if cc:IsA("WeldConstraint") then
                            if (cc.Part0 and not cc.Part0:IsDescendantOf(ch))
                               or (cc.Part1 and not cc.Part1:IsDescendantOf(ch)) then
                                cc:Destroy()
                            end
                        end
                    end
                end)
                showN("Anti-Trap ON", "success")
            else
                if antiTrapConn then antiTrapConn:Disconnect() antiTrapConn = nil end
                showN("Anti-Trap OFF", "info")
            end
        end, {toggle = true, key = "megaAntiTrap", icon = "🕸"})
        AddButtonToPage(PlayerPage3, "God Mode (client)", function(s)
            if s then
                if godConn then godConn:Disconnect() end
                godConn = RS.Heartbeat:Connect(function()
                    local ch = LP.Character
                    if not ch then return end
                    local h = ch:FindFirstChildOfClass("Humanoid")
                    if not h then return end
                    if h.Health < h.MaxHealth then h.Health = h.MaxHealth end
                    h.BreakJointsOnDeath = false
                    if not ch:FindFirstChildOfClass("ForceField") then
                        local ff = Instance.new("ForceField", ch)
                        ff.Visible = false
                    end
                end)
                showN("God Mode ON", "success")
            else
                if godConn then godConn:Disconnect() godConn = nil end
                showN("God Mode OFF", "info")
            end
        end, {toggle = true, key = "megaGod", icon = "👼"})
        addSection(PlayerPage3, "Gravity (0-1000)")
        local gvFrame = Instance.new("Frame", PlayerPage3)
        gvFrame.Size = UDim2.new(1, -8, 0, 60)
        gvFrame.BackgroundColor3 = Themes[Config.Theme].Element
        gvFrame.BackgroundTransparency = 0.15
        gvFrame.ZIndex = 104
        cor(gvFrame, 8)
        str(gvFrame, Themes[Config.Theme].Border, 1, 0.4)
        local gvLbl = Instance.new("TextLabel", gvFrame)
        gvLbl.Size = UDim2.new(1, -16, 0, 20)
        gvLbl.Position = UDim2.new(0, 8, 0, 4)
        gvLbl.BackgroundTransparency = 1
        gvLbl.Text = "Gravity: 196"
        gvLbl.TextColor3 = Themes[Config.Theme].Text
        gvLbl.TextSize = 12
        gvLbl.Font = Enum.Font.GothamBold
        gvLbl.TextXAlignment = Enum.TextXAlignment.Left
        gvLbl.ZIndex = 105
        local gvBar = Instance.new("TextButton", gvFrame)
        gvBar.Size = UDim2.new(1, -16, 0, 24)
        gvBar.Position = UDim2.new(0, 8, 0, 30)
        gvBar.BackgroundColor3 = Themes[Config.Theme].TopBar
        gvBar.Text = ""
        gvBar.AutoButtonColor = false
        gvBar.ZIndex = 105
        cor(gvBar, 4)
        local gvFill = Instance.new("Frame", gvBar)
        gvFill.Size = UDim2.new(0.196, 0, 1, 0)
        gvFill.BackgroundColor3 = ACC
        gvFill.BorderSizePixel = 0
        gvFill.ZIndex = 106
        cor(gvFill, 4)
        local MegaGravVal = 196
        local savedGrav = workspace.Gravity
        local gvDragging = false
        local function updateGV(input)
            local rel = input.Position.X - gvBar.AbsolutePosition.X
            local pct = math.clamp(rel / math.max(gvBar.AbsoluteSize.X, 1), 0, 1)
            MegaGravVal = math.floor(pct * 1000)
            gvFill.Size = UDim2.new(pct, 0, 1, 0)
            gvLbl.Text = "Gravity: " .. MegaGravVal
        end
        gvBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
               or input.UserInputType == Enum.UserInputType.Touch then
                gvDragging = true
                updateGV(input)
            end
        end)
        UIS.InputChanged:Connect(function(input)
            if gvDragging and (input.UserInputType == Enum.UserInputType.MouseMovement
               or input.UserInputType == Enum.UserInputType.Touch) then
                updateGV(input)
            end
        end)
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
               or input.UserInputType == Enum.UserInputType.Touch then
                gvDragging = false
            end
        end)
        local gravConn
        AddButtonToPage(PlayerPage3, "Custom Gravity", function(s)
            if s then
                savedGrav = workspace.Gravity
                if gravConn then gravConn:Disconnect() end
                gravConn = RS.Heartbeat:Connect(function()
                    workspace.Gravity = MegaGravVal
                end)
                showN("Gravity ON: " .. MegaGravVal, "success")
            else
                workspace.Gravity = savedGrav
                if gravConn then gravConn:Disconnect() gravConn = nil end
                showN("Gravity OFF", "info")
            end
        end, {toggle = true, key = "megaGravity", icon = "🌍"})
    end
end
if ATB and AP then
    local ExtrasPage4
    for i, v in ipairs(ATB) do
        if v.TextLabel and v.TextLabel.Text == "Extras" then
            ExtrasPage4 = AP[i]
            break
        end
    end
    if ExtrasPage4 then
        addSection(ExtrasPage4, "Mega Fun")
        local trailConn
        AddButtonToPage(ExtrasPage4, "Rainbow Trail", function(s)
            if s then
                if trailConn then trailConn:Disconnect() end
                trailConn = RS.Heartbeat:Connect(function()
                    local ch = LP.Character
                    if not ch then return end
                    local hrp = ch:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    local trail = hrp:FindFirstChild("MegaTrail")
                    if not trail then
                        trail = Instance.new("Trail", hrp)
                        trail.Name = "MegaTrail"
                        trail.Lifetime = 1
                        trail.Transparency = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 0),
                            NumberSequenceKeypoint.new(1, 1),
                        })
                        trail.WidthScale = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 1),
                            NumberSequenceKeypoint.new(1, 0),
                        })
                        local a0 = Instance.new("Attachment", hrp)
                        a0.Name = "MegaTrail0"
                        a0.Position = Vector3.new(0, -1.5, 0)
                        local a1 = Instance.new("Attachment", hrp)
                        a1.Name = "MegaTrail1"
                        a1.Position = Vector3.new(0, 1.5, 0)
                        trail.Attachment0 = a0
                        trail.Attachment1 = a1
                    end
                    local hue = (tick() * 0.5) % 1
                    trail.Color = ColorSequence.new(Color3.fromHSV(hue, 1, 1))
                end)
                showN("Rainbow Trail ON", "success")
            else
                if trailConn then trailConn:Disconnect() trailConn = nil end
                local ch = LP.Character
                if ch then
                    local hrp = ch:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local t = hrp:FindFirstChild("MegaTrail")
                        if t then t:Destroy() end
                        for _, a in ipairs(hrp:GetChildren()) do
                            if a.Name:find("MegaTrail") then a:Destroy() end
                        end
                    end
                end
                showN("Rainbow Trail OFF", "info")
            end
        end, {toggle = true, key = "megaTrail", icon = "🌈"})
        local auraThread
        AddButtonToPage(ExtrasPage4, "Particle Aura", function(s)
            if s then
                if auraThread then task.cancel(auraThread) end
                auraThread = task.spawn(function()
                    while true do
                        task.wait(0.5)
                        local ch = LP.Character
                        if ch then
                            local hrp = ch:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                local emitter = hrp:FindFirstChild("MegaAura")
                                if not emitter then
                                    emitter = Instance.new("ParticleEmitter", hrp)
                                    emitter.Name = "MegaAura"
                                    emitter.Rate = 30
                                    emitter.Lifetime = NumberRange.new(1, 2)
                                    emitter.Speed = NumberRange.new(2, 5)
                                    emitter.SpreadAngle = Vector2.new(180, 180)
                                    emitter.Size = NumberSequence.new({
                                        NumberSequenceKeypoint.new(0, 0.5),
                                        NumberSequenceKeypoint.new(1, 0),
                                    })
                                    emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
                                    emitter.LightEmission = 1
                                end
                                local hue = (tick() * 0.7) % 1
                                emitter.Color = ColorSequence.new(Color3.fromHSV(hue, 1, 1))
                            end
                        end
                    end
                end)
                showN("Particle Aura ON", "success")
            else
                if auraThread then task.cancel(auraThread) auraThread = nil end
                local ch = LP.Character
                if ch then
                    local hrp = ch:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local e = hrp:FindFirstChild("MegaAura")
                        if e then e:Destroy() end
                    end
                end
                showN("Particle Aura OFF", "info")
            end
        end, {toggle = true, key = "megaAura", icon = "✨"})
        local rainbowConn
        AddButtonToPage(ExtrasPage4, "Rainbow Character", function(s)
            if s then
                if rainbowConn then rainbowConn:Disconnect() end
                rainbowConn = RS.Heartbeat:Connect(function()
                    local ch = LP.Character
                    if not ch then return end
                    local hue = (tick() * 0.3) % 1
                    for _, p in ipairs(ch:GetDescendants()) do
                        if p:IsA("BasePart") then
                            pcall(function() p.Color = Color3.fromHSV(hue, 0.8, 1) end)
                        end
                    end
                end)
                showN("Rainbow ON", "success")
            else
                if rainbowConn then rainbowConn:Disconnect() rainbowConn = nil end
                showN("Rainbow OFF", "info")
            end
        end, {toggle = true, key = "megaRainbow", icon = "🌈"})
    end
end

if ATB and AP then
    local ConfigPage4
    for i, v in ipairs(ATB) do
        if v.TextLabel and v.TextLabel.Text == "Config" then
            ConfigPage4 = AP[i]
            break
        end
    end
    if ConfigPage4 then
        addSection(ConfigPage4, "Discord Webhook")
        local webhookOn = false
        local webhookURL = ""
        local whFrame = Instance.new("Frame", ConfigPage4)
        whFrame.Size = UDim2.new(1, -8, 0, 60)
        whFrame.BackgroundColor3 = Themes[Config.Theme].Element
        whFrame.BackgroundTransparency = 0.15
        whFrame.ZIndex = 104
        cor(whFrame, 8)
        str(whFrame, Themes[Config.Theme].Border, 1, 0.4)
        local whBox = Instance.new("TextBox", whFrame)
        whBox.Size = UDim2.new(1, -16, 0, 26)
        whBox.Position = UDim2.new(0, 8, 0, 8)
        whBox.BackgroundColor3 = Themes[Config.Theme].TopBar
        whBox.Text = ""
        whBox.PlaceholderText = "Paste Discord webhook URL"
        whBox.PlaceholderColor3 = Themes[Config.Theme].TextDim
        whBox.TextColor3 = Themes[Config.Theme].Text
        whBox.TextSize = 10
        whBox.Font = Enum.Font.Gotham
        whBox.ClearTextOnFocus = false
        whBox.ZIndex = 105
        cor(whBox, 4)
        str(whBox, Themes[Config.Theme].Border, 1, 0.4)
        whBox:GetPropertyChangedSignal("Text"):Connect(function()
            webhookURL = whBox.Text
        end)
        local hint = Instance.new("TextLabel", whFrame)
        hint.Size = UDim2.new(1, -16, 0, 16)
        hint.Position = UDim2.new(0, 8, 0, 38)
        hint.BackgroundTransparency = 1
        hint.Text = "Sends: session start, close"
        hint.TextColor3 = Themes[Config.Theme].TextDim
        hint.TextSize = 9
        hint.Font = Enum.Font.Gotham
        hint.TextXAlignment = Enum.TextXAlignment.Left
        hint.ZIndex = 105
        local function fireWebhook(msg)
            if not webhookOn or webhookURL == "" then return end
            task.spawn(function()
                pcall(function()
                    HS:PostAsync(webhookURL, HS:JSONEncode({
                        content = "Latina Hub | " .. msg,
                        username = "Latina Notifier",
                    }), Enum.HttpContentType.ApplicationJson)
                end)
            end)
        end
        AddButtonToPage(ConfigPage4, "Enable Webhook", function(s)
            webhookOn = s
            if s then
                if webhookURL == "" then
                    showN("Paste URL first", "error")
                    webhookOn = false
                    return
                end
                fireWebhook("Latina Hub connected")
                showN("Webhook ON", "success")
            else
                showN("Webhook OFF", "info")
            end
        end, {toggle = true, key = "megaWebhook", icon = "💬"})
        AddButtonToPage(ConfigPage4, "Test Webhook", function()
            if not webhookOn then showN("Enable first", "error") return end
            fireWebhook("Test message")
            showN("Sent", "success")
        end, {icon = "📤"})
        addSection(ConfigPage4, "UI Settings")
        AddButtonToPage(ConfigPage4, "Reset All Toggles", function()
            local allToggles = {"megaSpeed","megaJP","megaAntiRag","megaAntiKB","megaAntiTrap","megaGod","megaGravity","megaTrail","megaAura","megaRainbow"}
            for _, k in ipairs(allToggles) do
                Config.Toggles[k] = false
            end
            svC(Config)
            local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = 16 h.JumpPower = 50 end
            workspace.Gravity = 196.2
            showN("All toggles reset", "info")
        end, {icon = "🔄"})
    end
end
LP.OnTeleport:Connect(function()
    pcall(function()
        local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 16 h.JumpPower = 50 end
        workspace.Gravity = 196.2
    end)
end)
