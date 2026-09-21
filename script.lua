task.wait(1)
local P=game:GetService("Players")
local LP=P.LocalPlayer
local PG=LP:WaitForChild("PlayerGui")
local TS=game:GetService("TweenService")
local TPS=game:GetService("TeleportService")
local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local HS=game:GetService("HttpService")
local LT=game:GetService("Lighting")
local ST=game:GetService("Stats")
local MPS=game:GetService("MarketplaceService")

for _,n in ipairs({"LatinaHubV6","LatinaTopLabel"}) do
    if PG:FindFirstChild(n) then PG[n]:Destroy() end
end
if LT:FindFirstChild("LatinaBlur") then LT.LatinaBlur:Destroy() end

local CF="latina_hub_config.json"
local function svC(t) pcall(function() if writefile then writefile(CF,HS:JSONEncode(t)) end end) end
local function ldC()
    local ok,d=pcall(function()
        if readfile and isfile and isfile(CF) then return HS:JSONDecode(readfile(CF)) end
    end)
    return (ok and d) or {}
end
local Config=ldC()
Config.Theme=Config.Theme or "Default"
Config.Toggles=Config.Toggles or {}

local ACC=Color3.fromRGB(130,140,255)
local ACG=Color3.fromRGB(110,220,150)
local ACR=Color3.fromRGB(255,95,110)
local ACY=Color3.fromRGB(255,200,100)

local Themes={
Default={MainBg=Color3.fromRGB(18,18,26),MainBg2=Color3.fromRGB(24,24,34),TopBar=Color3.fromRGB(28,28,40),Element=Color3.fromRGB(30,30,44),ElementHover=Color3.fromRGB(42,42,60),Border=Color3.fromRGB(48,48,68),Accent=Color3.fromRGB(130,140,255),Text=Color3.fromRGB(235,235,250),TextDim=Color3.fromRGB(150,150,175)},
Cyberpunk={MainBg=Color3.fromRGB(14,10,22),MainBg2=Color3.fromRGB(22,14,34),TopBar=Color3.fromRGB(26,16,40),Element=Color3.fromRGB(32,20,48),ElementHover=Color3.fromRGB(44,28,64),Border=Color3.fromRGB(60,36,84),Accent=Color3.fromRGB(255,90,200),Text=Color3.fromRGB(240,230,255),TextDim=Color3.fromRGB(180,150,210)},
Emerald={MainBg=Color3.fromRGB(12,20,18),MainBg2=Color3.fromRGB(18,28,24),TopBar=Color3.fromRGB(20,32,28),Element=Color3.fromRGB(26,42,36),ElementHover=Color3.fromRGB(36,56,48),Border=Color3.fromRGB(48,76,64),Accent=Color3.fromRGB(90,220,160),Text=Color3.fromRGB(230,250,240),TextDim=Color3.fromRGB(150,200,175)},
Ruby={MainBg=Color3.fromRGB(24,14,16),MainBg2=Color3.fromRGB(32,18,22),TopBar=Color3.fromRGB(38,22,26),Element=Color3.fromRGB(48,28,34),ElementHover=Color3.fromRGB(64,38,46),Border=Color3.fromRGB(84,50,60),Accent=Color3.fromRGB(255,100,120),Text=Color3.fromRGB(250,230,235),TextDim=Color3.fromRGB(200,160,170)},
Midnight={MainBg=Color3.fromRGB(10,14,22),MainBg2=Color3.fromRGB(16,20,30),TopBar=Color3.fromRGB(20,26,40),Element=Color3.fromRGB(24,32,48),ElementHover=Color3.fromRGB(34,44,64),Border=Color3.fromRGB(48,62,88),Accent=Color3.fromRGB(120,170,255),Text=Color3.fromRGB(230,240,255),TextDim=Color3.fromRGB(150,170,200)},
Sunset={MainBg=Color3.fromRGB(24,18,16),MainBg2=Color3.fromRGB(32,24,20),TopBar=Color3.fromRGB(40,30,26),Element=Color3.fromRGB(50,38,32),ElementHover=Color3.fromRGB(66,50,42),Border=Color3.fromRGB(88,66,56),Accent=Color3.fromRGB(255,160,90),Text=Color3.fromRGB(250,235,225),TextDim=Color3.fromRGB(200,175,160)},
Mono={MainBg=Color3.fromRGB(16,16,16),MainBg2=Color3.fromRGB(22,22,22),TopBar=Color3.fromRGB(28,28,28),Element=Color3.fromRGB(34,34,34),ElementHover=Color3.fromRGB(46,46,46),Border=Color3.fromRGB(60,60,60),Accent=Color3.fromRGB(220,220,220),Text=Color3.fromRGB(240,240,240),TextDim=Color3.fromRGB(150,150,150)}
}

local SG=Instance.new("ScreenGui")
SG.Name="LatinaHubV6"
SG.ResetOnSpawn=false
SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
SG.IgnoreGuiInset=true
SG.Parent=PG

local BL=Instance.new("BlurEffect",LT)
BL.Name="LatinaBlur"
BL.Size=0

local CS=Instance.new("Sound",SG) CS.SoundId="rbxassetid://906107293" CS.Volume=0.4
local ES=Instance.new("Sound",SG) ES.SoundId="rbxassetid://6026984224" ES.Volume=0.5
local SS=Instance.new("Sound",SG) SS.SoundId="rbxassetid://6536419944" SS.Volume=0.4
local IS=Instance.new("Sound",SG) IS.SoundId="rbxassetid://130788815" IS.Volume=0.6

local function pC() pcall(function() CS:Play() end) end
local function pE() pcall(function() ES:Play() end) end
local function pS() pcall(function() SS:Play() end) end

local function cor(p,r)
    local c=Instance.new("UICorner",p)
    c.CornerRadius=UDim.new(0,r or 8)
    return c
end
local function str(p,c,t,tr)
    local s=Instance.new("UIStroke",p)
    s.Color=c or Color3.fromRGB(70,70,90)
    s.Thickness=t or 1
    s.Transparency=tr or 0.5
    s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
    return s
end
local function gr(p,c1,c2,r)
    local g=Instance.new("UIGradient",p)
    g.Rotation=r or 90
    g.Color=ColorSequence.new(c1,c2)
    return g
end

local NQ,NB={},false
local NH={}
local function showN(t,k)
    table.insert(NH,{text=t,kind=k or "info",time=os.time()})
    if #NH>50 then table.remove(NH,1) end
    table.insert(NQ,{text=t,kind=k or "info"})
    if NB then return end
    NB=true
    task.spawn(function()
        while #NQ>0 do
            local e=table.remove(NQ,1)
            pcall(function()
                local bc=ACC
                if e.kind=="success" then bc=ACG
                elseif e.kind=="error" then bc=ACR end
                local F=Instance.new("Frame",SG)
                F.Size=UDim2.new(0,280,0,44)
                F.Position=UDim2.new(0.5,-140,1,20)
                F.BackgroundColor3=Themes[Config.Theme].TopBar
                F.BackgroundTransparency=0.35
                F.ZIndex=99999
                cor(F,10)
                str(F,Themes[Config.Theme].Border,1,0.7)
                gr(F,Themes[Config.Theme].TopBar,Themes[Config.Theme].MainBg)
                local b=Instance.new("Frame",F)
                b.Size=UDim2.new(0,3,1,-14)
                b.Position=UDim2.new(0,8,0,7)
                b.BackgroundColor3=bc
                b.BackgroundTransparency=0.3
                b.BorderSizePixel=0
                b.ZIndex=100001
                cor(b,2)
                local T=Instance.new("TextLabel",F)
                T.Size=UDim2.new(1,-28,1,0)
                T.Position=UDim2.new(0,20,0,0)
                T.BackgroundTransparency=1
                T.Text=e.text
                T.TextColor3=Themes[Config.Theme].Text
                T.TextTransparency=0.1
                T.TextSize=11
                T.Font=Enum.Font.GothamMedium
                T.TextWrapped=true
                T.TextXAlignment=Enum.TextXAlignment.Left
                T.ZIndex=100000
                TS:Create(F,TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-140,1,-60)}):Play()
                task.wait(2.4)
                local out=TS:Create(F,TweenInfo.new(0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Position=UDim2.new(0.5,-140,1,20),BackgroundTransparency=1})
                TS:Create(T,TweenInfo.new(0.3),{TextTransparency=1}):Play()
                out:Play()
                out.Completed:Wait()
                F:Destroy()
            end)
            task.wait(0.12)
        end
        NB=false
    end)
end
local TB=Instance.new("ImageButton",SG)
TB.Name="FloatingToggle"
TB.Size=UDim2.new(0,52,0,52)
TB.Position=UDim2.new(0,18,1,-100)
TB.AnchorPoint=Vector2.new(0,1)
TB.BackgroundColor3=Themes[Config.Theme].TopBar
TB.Image="rbxassetid://100104680190424"
TB.AutoButtonColor=false
TB.Active=true
TB.Draggable=true
TB.ZIndex=99999
cor(TB,999)
local TBS=str(TB,ACC,2,0)

local TG=Instance.new("Frame",TB)
TG.Size=UDim2.new(1,6,1,6)
TG.Position=UDim2.new(0,-3,0,-3)
TG.BackgroundColor3=ACC
TG.BackgroundTransparency=0.88
TG.BorderSizePixel=0
TG.ZIndex=99998
cor(TG,999)

TB.MouseEnter:Connect(function()
    TS:Create(TB,TweenInfo.new(0.18),{Size=UDim2.new(0,56,0,56)}):Play()
    TS:Create(TG,TweenInfo.new(0.18),{BackgroundTransparency=0.7}):Play()
end)
TB.MouseLeave:Connect(function()
    TS:Create(TB,TweenInfo.new(0.18),{Size=UDim2.new(0,52,0,52)}):Play()
    TS:Create(TG,TweenInfo.new(0.18),{BackgroundTransparency=0.88}):Play()
end)

local MF=Instance.new("Frame",SG)
MF.Name="MainWindow"
MF.Size=UDim2.new(0,380,0,310)
MF.Position=UDim2.new(0.5,-190,0,80)
MF.BackgroundColor3=Themes[Config.Theme].MainBg
MF.Active=true
MF.Visible=false
MF.ZIndex=100
cor(MF,14)
local MG=gr(MF,Themes[Config.Theme].MainBg,Themes[Config.Theme].MainBg2,90)
local MS=str(MF,Themes[Config.Theme].Border,1.5,0.3)

local TBAR=Instance.new("Frame",MF)
TBAR.Size=UDim2.new(1,0,0,42)
TBAR.BackgroundColor3=Themes[Config.Theme].TopBar
TBAR.Active=true
TBAR.ZIndex=101
cor(TBAR,14)

local TF=Instance.new("Frame",TBAR)
TF.Size=UDim2.new(1,0,0,14)
TF.Position=UDim2.new(0,0,1,-14)
TF.BackgroundColor3=Themes[Config.Theme].TopBar
TF.BorderSizePixel=0
TF.ZIndex=101

local TG2=gr(TBAR,Themes[Config.Theme].TopBar,Themes[Config.Theme].MainBg,90)

local AL=Instance.new("Frame",TBAR)
AL.Size=UDim2.new(1,0,0,2)
AL.Position=UDim2.new(0,0,1,-1)
AL.BackgroundColor3=ACC
AL.BorderSizePixel=0
AL.ZIndex=102

-- Title
local TITLE=Instance.new("TextLabel",TBAR)
TITLE.Size=UDim2.new(1,-120,1,0)
TITLE.Position=UDim2.new(0,48,0,0)
TITLE.BackgroundTransparency=1
TITLE.Text="LATINA HUB"
TITLE.TextColor3=Themes[Config.Theme].Text
TITLE.TextSize=14
TITLE.Font=Enum.Font.GothamBold
TITLE.TextXAlignment=Enum.TextXAlignment.Left
TITLE.ZIndex=103

-- Close button
local CLOSE=Instance.new("TextButton",TBAR)
CLOSE.Size=UDim2.new(0,28,0,28)
CLOSE.Position=UDim2.new(1,-36,0.5,-14)
CLOSE.BackgroundColor3=Themes[Config.Theme].Element
CLOSE.Text="✕"
CLOSE.TextColor3=Themes[Config.Theme].Text
CLOSE.TextSize=14
CLOSE.Font=Enum.Font.GothamBold
CLOSE.AutoButtonColor=false
CLOSE.ZIndex=103
cor(CLOSE,6)

CLOSE.MouseButton1Click:Connect(function()
    MF.Visible=false
    if BL then TS:Create(BL,TweenInfo.new(0.3),{Size=0}):Play() end
end)

TB.MouseButton1Click:Connect(function()
    MF.Visible=not MF.Visible
    if MF.Visible and BL then
        TS:Create(BL,TweenInfo.new(0.3),{Size=8}):Play()
    elseif BL then
        TS:Create(BL,TweenInfo.new(0.3),{Size=0}):Play()
    end
end)

-- Make draggable
local dragging,dragStart,dragPos
TBAR.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        dragging=true
        dragStart=input.Position
        dragPos=MF.Position
    end
end)
TBAR.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        dragging=false
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
        local delta=input.Position-dragStart
        MF.Position=UDim2.new(dragPos.X.Scale,dragPos.X.Offset+delta.X,dragPos.Y.Scale,dragPos.Y.Offset+delta.Y)
    end
end)

-- Tab container
local TC=Instance.new("Frame",MF)
TC.Size=UDim2.new(0,120,1,-42)
TC.Position=UDim2.new(0,0,0,42)
TC.BackgroundColor3=Themes[Config.Theme].MainBg2
TC.BackgroundTransparency=0.3
TC.BorderSizePixel=0
TC.ZIndex=101

local TL=Instance.new("UIListLayout",TC)
TL.SortOrder=Enum.SortOrder.LayoutOrder
TL.Padding=UDim.new(0,4)

local PC=Instance.new("Frame",MF)
PC.Size=UDim2.new(1,-126,1,-48)
PC.Position=UDim2.new(0,124,0,44)
PC.BackgroundTransparency=1
PC.ZIndex=101

local CE={}
local ATB={}
local AP={}

local function CreateTab(name,icon)
    local B=Instance.new("TextButton",TC)
    B.Size=UDim2.new(1,-8,0,34)
    B.BackgroundColor3=Themes[Config.Theme].Element
    B.BackgroundTransparency=0.5
    B.Text=""
    B.AutoButtonColor=false
    B.ZIndex=102
    cor(B,6)

    local I=Instance.new("Frame",B)
    I.Size=UDim2.new(0,3,1,-8)
    I.Position=UDim2.new(0,0,0.5,-0.5)
    I.AnchorPoint=Vector2.new(0,0.5)
    I.BackgroundColor3=ACC
    I.BackgroundTransparency=1
    I.BorderSizePixel=0
    I.ZIndex=103
    cor(I,2)

    local IF=Instance.new("Frame",B)
    IF.Size=UDim2.new(0,22,0,22)
    IF.Position=UDim2.new(0,10,0.5,-11)
    IF.BackgroundColor3=Themes[Config.Theme].TopBar
    IF.ZIndex=103
    cor(IF,6)

    local IL=Instance.new("TextLabel",IF)
    IL.Size=UDim2.new(1,0,1,0)
    IL.BackgroundTransparency=1
    IL.Text=icon or "?"
    IL.TextColor3=Themes[Config.Theme].TextDim
    IL.TextSize=11
    IL.Font=Enum.Font.GothamBold
    IL.ZIndex=104

    local X=Instance.new("TextLabel",B)
    X.Size=UDim2.new(1,-40,1,0)
    X.Position=UDim2.new(0,38,0,0)
    X.BackgroundTransparency=1
    X.Text=name
    X.TextColor3=Themes[Config.Theme].TextDim
    X.TextSize=10
    X.Font=Enum.Font.GothamMedium
    X.TextXAlignment=Enum.TextXAlignment.Left
    X.ZIndex=104

    local PG2=Instance.new("ScrollingFrame",PC)
    PG2.Size=UDim2.new(1,0,1,0)
    PG2.BackgroundTransparency=1
    PG2.BorderSizePixel=0
    PG2.ScrollBarThickness=3
    PG2.ScrollBarImageColor3=ACC
    PG2.ScrollBarImageTransparency=0.6
    PG2.Visible=false
    PG2.ZIndex=103

    local PL=Instance.new("UIListLayout",PG2)
    PL.SortOrder=Enum.SortOrder.LayoutOrder
    PL.Padding=UDim.new(0,7)
    PL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        PG2.CanvasSize=UDim2.new(0,0,0,PL.AbsoluteContentSize.Y+10)
    end)

    table.insert(ATB,{Button=B,Page=PG2,Indicator=I,IconFrame=IF,IconLabel=IL,TextLabel=X})
    table.insert(AP,PG2)

    B.MouseButton1Click:Connect(function()
        pC()
        for _,v in ipairs(ATB) do
            v.Button:SetAttribute("Active",false)
            v.Button.BackgroundTransparency=0.5
            v.Indicator.BackgroundTransparency=1
            v.IconFrame.BackgroundColor3=Themes[Config.Theme].TopBar
            v.IconLabel.TextColor3=Themes[Config.Theme].TextDim
            v.TextLabel.TextColor3=Themes[Config.Theme].TextDim
            v.Page.Visible=false
        end
        PG2.Visible=true
        B:SetAttribute("Active",true)
        B.BackgroundTransparency=0
        I.BackgroundTransparency=0
        IF.BackgroundColor3=ACC
        IL.TextColor3=Color3.fromRGB(20,20,30)
        X.TextColor3=Themes[Config.Theme].Text
        TS:Create(I,TweenInfo.new(0.25),{Size=UDim2.new(0,3,1,-8)}):Play()
    end)

    return PG2
end

-- Activate first tab
local function activateFirstTab()
    if #ATB>0 then
        local v=ATB[1]
        v.Button:SetAttribute("Active",true)
        v.Button.BackgroundTransparency=0
        v.Indicator.BackgroundTransparency=0
        v.Indicator.Size=UDim2.new(0,3,1,-8)
        v.IconFrame.BackgroundColor3=ACC
        v.IconLabel.TextColor3=Color3.fromRGB(20,20,30)
        v.TextLabel.TextColor3=Themes[Config.Theme].Text
        v.Page.Visible=true
    end
end

local function AddButtonToPage(page,name,cb,op)
    op=op or {}
    local isT=op.toggle or false
    local k=op.key
    local ic=op.icon
    local st=Config.Toggles[k] or false

    local B=Instance.new("TextButton",page)
    B.Size=UDim2.new(1,-8,0,36)
    B.BackgroundColor3=Themes[Config.Theme].Element
    B.BackgroundTransparency=0.15
    B.Text=""
    B.AutoButtonColor=false
    B.ZIndex=104
    table.insert(CE,B)
    cor(B,8)
    local BS2=str(B,Themes[Config.Theme].Border,1,0.4)

    local BR=Instance.new("Frame",B)
    BR.Size=UDim2.new(0,3,1,-12)
    BR.Position=UDim2.new(0,7,0.5,-0.5)
    BR.AnchorPoint=Vector2.new(0,0.5)
    BR.BackgroundColor3=ACC
    BR.BorderSizePixel=0
    BR.BackgroundTransparency=st and 0 or 1
    BR.ZIndex=105
    cor(BR,2)

    if ic then
        local IB=Instance.new("Frame",B)
        IB.Size=UDim2.new(0,20,0,20)
        IB.Position=UDim2.new(0,14,0.5,-10)
        IB.BackgroundColor3=Themes[Config.Theme].TopBar
        IB.BackgroundTransparency=0.3
        IB.ZIndex=105
        cor(IB,6)
        local II=Instance.new("TextLabel",IB)
        II.Size=UDim2.new(1,0,1,0)
        II.BackgroundTransparency=1
        II.Text=ic
        II.TextColor3=ACC
        II.TextSize=10
        II.Font=Enum.Font.GothamBold
        II.ZIndex=106
    end

    local T=Instance.new("TextLabel",B)
    T.Size=UDim2.new(1,-50,1,0)
    T.Position=UDim2.new(0,42,0,0)
    T.BackgroundTransparency=1
    T.Text=name
    T.TextColor3=Themes[Config.Theme].Text
    T.TextSize=10
    T.Font=Enum.Font.GothamMedium
    T.TextXAlignment=Enum.TextXAlignment.Left
    T.ZIndex=105

    if isT then
        local IND=Instance.new("Frame",B)
        IND.Size=UDim2.new(0,32,0,16)
        IND.Position=UDim2.new(1,-40,0.5,-8)
        IND.BackgroundColor3=st and ACG or Themes[Config.Theme].TopBar
        IND.ZIndex=105
        cor(IND,8)
        local DOT=Instance.new("Frame",IND)
        DOT.Size=UDim2.new(0,12,0,12)
        DOT.Position=st and UDim2.new(1,-14,0.5,-6) or UDim2.new(0,2,0.5,-6)
        DOT.BackgroundColor3=Color3.fromRGB(255,255,255)
        DOT.ZIndex=106
        cor(DOT,6)

        B.MouseButton1Click:Connect(function()
            st=not st
            Config.Toggles[k]=st
            svC(Config)
            TS:Create(IND,TweenInfo.new(0.2),{BackgroundColor3=st and ACG or Themes[Config.Theme].TopBar}):Play()
            TS:Create(DOT,TweenInfo.new(0.2),{Position=st and UDim2.new(1,-14,0.5,-6) or UDim2.new(0,2,0.5,-6)}):Play()
            TS:Create(BR,TweenInfo.new(0.2),{BackgroundTransparency=st and 0 or 1}):Play()
            pE()
            if cb then cb(st) end
        end)
    else
        B.MouseButton1Click:Connect(function()
            pC()
            if cb then cb() end
        end)
    end

    return B
end

local function addSection(page,title)
    local S=Instance.new("TextLabel",page)
    S.Size=UDim2.new(1,-8,0,20)
    S.BackgroundTransparency=1
    S.Text="— "..title.." —"
    S.TextColor3=Themes[Config.Theme].TextDim
    S.TextSize=9
    S.Font=Enum.Font.GothamBold
    S.ZIndex=104
    return S
end

local function createCollapsible(page,title,subtitle,icon,open,accent)
    local F=Instance.new("Frame",page)
    F.Size=UDim2.new(1,-8,0,36)
    F.BackgroundColor3=Themes[Config.Theme].Element
    F.BackgroundTransparency=0.15
    F.ZIndex=104
    cor(F,8)
    str(F,Themes[Config.Theme].Border,1,0.4)

    local H=Instance.new("TextButton",F)
    H.Size=UDim2.new(1,0,0,36)
    H.BackgroundTransparency=1
    H.Text=""
    H.ZIndex=105

    local IL=Instance.new("TextLabel",H)
    IL.Size=UDim2.new(0,24,1,0)
    IL.Position=UDim2.new(0,8,0,0)
    IL.BackgroundTransparency=1
    IL.Text=icon or "?"
    IL.TextSize=12
    IL.ZIndex=106

    local TL=Instance.new("TextLabel",H)
    TL.Size=UDim2.new(1,-80,1,0)
    TL.Position=UDim2.new(0,32,0,0)
    TL.BackgroundTransparency=1
    TL.Text=title
    TL.TextColor3=Themes[Config.Theme].Text
    TL.TextSize=10
    TL.Font=Enum.Font.GothamBold
    TL.TextXAlignment=Enum.TextXAlignment.Left
    TL.ZIndex=106

    local SL=Instance.new("TextLabel",H)
    SL.Size=UDim2.new(1,-80,0,12)
    SL.Position=UDim2.new(0,32,1,-14)
    SL.BackgroundTransparency=1
    SL.Text=subtitle or ""
    SL.TextColor3=Themes[Config.Theme].TextDim
    SL.TextSize=8
    SL.Font=Enum.Font.Gotham
    SL.TextXAlignment=Enum.TextXAlignment.Left
    SL.ZIndex=106

    local AR=Instance.new("TextLabel",H)
    AR.Size=UDim2.new(0,20,0,20)
    AR.Position=UDim2.new(1,-28,0.5,-10)
    AR.BackgroundTransparency=1
    AR.Text=open and "▼" or "▶"
    AR.TextColor3=accent or ACC
    AR.TextSize=10
    AR.ZIndex=106

    local C=Instance.new("Frame",F)
    C.Size=UDim2.new(1,-8,0,0)
    C.Position=UDim2.new(0,4,0,38)
    C.BackgroundTransparency=1
    C.ClipsDescendants=true
    C.ZIndex=104
    local CL=Instance.new("UIListLayout",C)
    CL.SortOrder=Enum.SortOrder.LayoutOrder
    CL.Padding=UDim.new(0,5)

    if open then
        C.Size=UDim2.new(1,-8,0,0)
        task.defer(function()
            C.Size=UDim2.new(1,-8,0,CL.AbsoluteContentSize.Y+8)
            F.Size=UDim2.new(1,-8,0,36+CL.AbsoluteContentSize.Y+12)
        end)
    end

    H.MouseButton1Click:Connect(function()
        open=not open
        AR.Text=open and "▼" or "▶"
        if open then
            C.Size=UDim2.new(1,-8,0,CL.AbsoluteContentSize.Y+8)
            F.Size=UDim2.new(1,-8,0,36+CL.AbsoluteContentSize.Y+12)
        else
            C.Size=UDim2.new(1,-8,0,0)
            F.Size=UDim2.new(1,-8,0,36)
        end
        pC()
    end)

    CL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if open then
            C.Size=UDim2.new(1,-8,0,CL.AbsoluteContentSize.Y+8)
            F.Size=UDim2.new(1,-8,0,36+CL.AbsoluteContentSize.Y+12)
        end
    end)

    return C
                end
                -- ============ CONFIG TAB ============
local ConfigTab=CreateTab("Config","⚙️")
addSection(ConfigTab,"Theme")

local themeList={"Default","Cyberpunk","Emerald","Ruby","Midnight","Sunset","Mono"}
for _,tn in ipairs(themeList) do
    AddButtonToPage(ConfigTab,"Theme: "..tn,function()
        Config.Theme=tn
        svC(Config)
        showN("Theme set to "..tn,"success")
    end,{icon="🎨"})
end

addSection(ConfigTab,"Webhook")
local webhookURL=""
local webhookOn=false

local function fireWebhook(msg)
    if not webhookOn or webhookURL=="" then return end
    pcall(function()
        HS:PostAsync(webhookURL,HS:JSONEncode({
            content="**Latina Hub**\n"..msg,
            username="Latina Hub"
        }),Enum.HttpContentType.ApplicationJson)
    end)
end

AddButtonToPage(ConfigTab,"Set Webhook URL",function()
    showN("Webhook set","info")
end,{icon="🔗"})

AddButtonToPage(ConfigTab,"Enable Webhook",function(s)
    webhookOn=s
    if s then
        if webhookURL=="" then showN("Paste URL first","error") webhookOn=false return end
        fireWebhook("Latina Hub connected")
        showN("Webhook ON","success")
    else
        showN("Webhook OFF","info")
    end
end,{toggle=true,key="megaWebhook",icon="💬"})

AddButtonToPage(ConfigTab,"Test Webhook",function()
    if not webhookOn then showN("Enable first","error") return end
    fireWebhook("Test message")
    showN("Sent","success")
end,{icon="📤"})

addSection(ConfigTab,"UI Settings")
AddButtonToPage(ConfigTab,"Reset All Toggles",function()
    local allToggles={"megaSpeed","megaJP","megaAntiRag","megaAntiKB","megaAntiTrap","megaGod","megaGravity","megaTrail","megaAura","megaRainbow","infJump","noclip","speed","fpsBoost","nameESP","eggESP","clickTP","invisible","clock","coords","rainbowChar","entCount","crosshair","sessionTimer"}
    for _,k in ipairs(allToggles) do Config.Toggles[k]=false end
    svC(Config)
    local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed=16 h.JumpPower=50 end
    workspace.Gravity=196.2
    showN("All toggles reset","info")
end,{icon="🔄"})

-- ============ STEAL EGG TAB ============
local ET=CreateTab("Steal Egg","🥚")

local SFR=Instance.new("Frame",ET)
SFR.Size=UDim2.new(1,-8,0,32)
SFR.BackgroundColor3=Themes[Config.Theme].Element
SFR.BackgroundTransparency=0.15
SFR.ZIndex=104
cor(SFR,8)
str(SFR,Themes[Config.Theme].Border,1,0.4)

local SI=Instance.new("TextLabel",SFR)
SI.Size=UDim2.new(0,28,1,0)
SI.Position=UDim2.new(0,4,0,0)
SI.BackgroundTransparency=1
SI.Text="🔍"
SI.TextSize=11
SI.ZIndex=105

local SBX=Instance.new("TextBox",SFR)
SBX.Size=UDim2.new(1,-36,1,0)
SBX.Position=UDim2.new(0,28,0,0)
SBX.BackgroundTransparency=1
SBX.PlaceholderText="Search hubs..."
SBX.PlaceholderColor3=Themes[Config.Theme].TextDim
SBX.Text=""
SBX.TextColor3=Themes[Config.Theme].Text
SBX.TextSize=10
SBX.Font=Enum.Font.GothamMedium
SBX.TextXAlignment=Enum.TextXAlignment.Left
SBX.ClearTextOnFocus=false
SBX.ZIndex=105

local KL=createCollapsible(ET,"KEYLESS HUBS","27 hubs","🔓",true,ACG)
local KQ=createCollapsible(ET,"KEY REQUIRED HUBS","10 hubs","🔑",false,ACR)

local KeylessScripts={
{Name="DECODE HUB",Icon="🔓",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzYumi/Decode/refs/heads/main/DE%3ACODE.lua", true))()'},
{Name="FOXNAME HUB",Icon="🦊",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/Fn-stealanegg.lua"))()'},
{Name="CRZHUB",Icon="🔥",Link='loadstring(game:HttpGet("https://flowauth.net/v1/loaders/3c4e87ed34813171b0f8d53a108a7d88.lua"))()'},
{Name="DARKNESS HUB",Icon="🌑",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/Darkness-KingScripts/Steal-a-egg/refs/heads/main/Darknesshub"))()'},
{Name="LKZ HUB",Icon="⚡",Link='loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/65bf3459d87ba3ac46350e154b640929.lua"))()'},
{Name="UNIVERSE HUB",Icon="🌌",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/Uranus197/-Univers-Hub-Graphics-Script-/refs/heads/main/UniversHub"))()'},
{Name="KURDMADE",Icon="🔒",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/elampo092/psychic-carnival/refs/heads/main/Kurdmade-hub"))()'},
{Name="SIMPLE SHADER",Icon="🎨",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/robloxscripts2026/simple-shader/refs/heads/main/lua"))()'},
{Name="RENE HUB",Icon="🎯",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/sabscrip-arch/srver/refs/heads/main/Stealanegg"))()'},
{Name="VOIDSHELL",Icon="💀",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/VoidShell-null/VoidShell-Hub/refs/heads/main/Scripts/StealAnEgg.luau"))()'},
{Name="TSUO HUB",Icon="🌟",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/stealanegg"))()'},
{Name="SOURCE HUB",Icon="📦",Link='loadstring(game:HttpGet("https://pastebin.com/raw/d0zBUM6r"))()'},
{Name="SERVER FINDER",Icon="🔍",Link='loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Low-Server-Finder-GUI-30660"))()'},
{Name="VINCITORE",Icon="👑",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/idk953072-crypto/Steal-an-Egg/refs/heads/main/vincitore"))()'},
{Name="LENNON V3",Icon="🎵",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/lennonxscripts/lennonhubv3/refs/heads/main/stealanegg.lua"))()'},
{Name="MIRANDA",Icon="⚡",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/miirandahub/loader/main/stealaeggs"))()'},
{Name="ON HUB",Icon="🔷",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/davizin713/ONhub/refs/heads/main/script.lua"))()'},
{Name="BEE HUB",Icon="🐝",Link='loadstring(game:HttpGet("https://flowauth.net/v1/loaders/178cde5c2aba98369938c59b56f63654.lua"))()'},
{Name="VORTEX X SAGE",Icon="🌿",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/Israel-Vortex/vortex-x-scripts/refs/heads/main/Official-Vortex-Software/Dev-Project/StealAnEgg.lua"))()'},
{Name="ANTI-CHASE",Icon="🏃",Link='loadstring(game:HttpGet("https://pastefy.app/nasHhfko/raw"))()'},
{Name="GLINT ANTI-CHASE",Icon="🏃",Link='loadstring(game:HttpGet("https://flowauth.net/v1/loaders/6824c37a4078d7d311677732e231edaa.lua"))()'},
{Name="NEVA HUB",Icon="🌑",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/VEZ2/NEVAHUB/main/2"))()'},
{Name="JANE HUB",Icon="🧞",Link='loadstring(game:HttpGet("https://flowauth.net/v1/loaders/b88a6143b351d79f4c5a108ec33b5a2c.lua"))()'},
{Name="PULSE HUB",Icon="💉",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/PulseZax/Loader/refs/heads/main/.lua"))()'},
{Name="CHILLI HUB",Icon="🌶️",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()'},
{Name="RONNIE HUB",Icon="👯‍♂️",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/elonmod/skibidi/refs/heads/main/Ronneihub-keyless.lua"))()'}
}

local KeyReqScripts={
{Name="OMG HUB",Icon="💎",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()'},
{Name="FLOW HUB",Icon="🌊",Link='loadstring(game:HttpGet("https://flowauth.net/v1/loaders/29f4f4b924aff467652814456286bb05.lua"))()'},
{Name="FYY COMMUNITY",Icon="🎭",Link='loadstring(game:HttpGet("https://FyyCommunity.com"))()'},
{Name="CLOVER HUB",Icon="🍀",Link='loadstring(game:HttpGet("https://cloverhub.app/clover.lua"))()'},
{Name="ZEROIN HUB",Icon="0️⃣",Link='loadstring(game:HttpGet("https://zeroinhub.com/api/script"))()'},
{Name="BIGFROOT",Icon="🌱",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))()'},
{Name="AJJANS",Icon="🎪",Link='loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/359e97f8618e9008afe5f496184ebb7c.lua"))()'},
{Name="HORIZON",Icon="🌅",Link='script_key="Trial"; loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/6582551b42d21c6b7eb55f1d76d8d50ce53cb35592093d6615b5e83437594dc0.lua"))()'},
{Name="Premium source hub",Icon="📙",Link='loadstring(game:HttpGet("https://api.obscuravm.com/scripts/7274301667433708967"))()'},
{Name="NIGHT HUB",Icon="🌃",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/StealEggOnly.luau"))()'},
{Name="HIP HUB",Icon="🦵",Link='loadstring(game:HttpGet("https://hiphub.cloud/api/script-roblox/loader"))()'}
}

local SBTN={}
local function makeBtn(container,sd,badge)
    local H=Instance.new("Frame",container)
    H.Size=UDim2.new(1,-4,0,36)
    H.BackgroundTransparency=1
    H.ZIndex=105
    AddButtonToPage(H,sd.Name,function()
        if sd.Link:find("http") and not sd.Link:find("loadstring") then
            loadstring(game:HttpGet(sd.Link))()
        else
            loadstring(sd.Link)()
        end
        pS()
        showN(sd.Name.." executed","success")
    end,{icon=sd.Icon})
    local b=H:FindFirstChildWhichIsA("TextButton")
    if b then
        b.Size=UDim2.new(1,0,1,0)
        if badge then
            local BD2=Instance.new("TextLabel",b)
            BD2.Size=UDim2.new(0,54,0,12)
            BD2.Position=UDim2.new(1,-64,0,3)
            BD2.BackgroundColor3=ACC
            BD2.BackgroundTransparency=0.75
            BD2.Text=badge
            BD2.TextColor3=ACC
            BD2.TextSize=7
            BD2.Font=Enum.Font.GothamBold
            BD2.ZIndex=107
            cor(BD2,3)
        end
    end
    table.insert(SBTN,{holder=H,name=sd.Name})
end

for _,sd in ipairs(KeylessScripts) do makeBtn(KL,sd,"KEYLESS") end
for _,sd in ipairs(KeyReqScripts) do makeBtn(KQ,sd,"KEY") end

SBX:GetPropertyChangedSignal("Text"):Connect(function()
    local q=SBX.Text:lower()
    for _,e in ipairs(SBTN) do
        e.holder.Visible=(q=="" or e.name:lower():find(q,1,true)~=nil)
    end
end)
                -- ============ PLAYER TAB ============
local PT=CreateTab("Player","👤")
addSection(PT,"Movement")

local IJc
AddButtonToPage(PT,"Infinite Jump",function(s)
    if s then
        IJc=UIS.JumpRequest:Connect(function()
            local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
            if h then h:ChangeState("Jumping") end
        end)
        showN("Infinite Jump ON","success")
    else
        if IJc then IJc:Disconnect() IJc=nil end
        showN("Infinite Jump OFF","info")
    end
end,{toggle=true,key="infJump",icon="⚡"})

local NC
AddButtonToPage(PT,"Noclip",function(s)
    if s then
        NC=RS.Stepped:Connect(function()
            if LP.Character then
                for _,p in ipairs(LP.Character:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide=false end
                end
            end
        end)
        showN("Noclip ON","success")
    else
        if NC then NC:Disconnect() NC=nil end
        showN("Noclip OFF","info")
    end
end,{toggle=true,key="noclip",icon="👻"})

local SC
AddButtonToPage(PT,"Speed Boost",function(s)
    if s then
        SC=RS.Heartbeat:Connect(function()
            local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
            if h and h.WalkSpeed<32 then h.WalkSpeed=32 end
        end)
        showN("Speed ON","success")
    else
        if SC then SC:Disconnect() SC=nil end
        local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed=16 end
        showN("Speed OFF","info")
    end
end,{toggle=true,key="speed",icon="💨"})

addSection(PT,"Performance")

local FB={active=false,saved={},particles={}}
local function enFB()
    FB.saved.Lighting={GlobalShadows=LT.GlobalShadows,FogEnd=LT.FogEnd,Brightness=LT.Brightness,ShadowSoftness=LT.ShadowSoftness,EnvironmentDiffuseScale=LT.EnvironmentDiffuseScale,EnvironmentSpecularScale=LT.EnvironmentSpecularScale}
    LT.GlobalShadows=false
    LT.FogEnd=100
    LT.Brightness=1
    pcall(function() LT.ShadowSoftness=0 LT.EnvironmentDiffuseScale=0 LT.EnvironmentSpecularScale=0 end)
    FB.saved.Effects={}
    for _,fx in ipairs(LT:GetChildren()) do
        if fx.Name~="LatinaBlur" then
            if fx:IsA("BloomEffect") or fx:IsA("DepthOfFieldEffect") or fx:IsA("SunRaysEffect") or fx:IsA("ColorCorrectionEffect") or fx:IsA("BlurEffect") then
                FB.saved.Effects[fx]=fx.Enabled
                fx.Enabled=false
            elseif fx:IsA("Atmosphere") then
                FB.saved.Effects[fx]=fx.Density
                fx.Density=0
            end
        end
    end
    FB.particles={}
    for _,o in ipairs(workspace:GetDescendants()) do
        if o:IsA("ParticleEmitter") or o:IsA("Smoke") or o:IsA("Fire") or o:IsA("Sparkles") or o:IsA("Trail") or o:IsA("Beam") then
            if o.Enabled then o.Enabled=false table.insert(FB.particles,o) end
        end
    end
    FB.active=true
end
local function dsFB()
    if FB.saved.Lighting then
        for k,v in pairs(FB.saved.Lighting) do LT[k]=v end
    end
    if FB.saved.Effects then
        for fx,st in pairs(FB.saved.Effects) do
            if fx and fx.Parent then
                if fx:IsA("Atmosphere") then fx.Density=st else fx.Enabled=st end
            end
        end
    end
    if FB.particles then
        for _,o in ipairs(FB.particles) do
            if o and o.Parent then o.Enabled=true end
        end
    end
    FB.active=false
end
AddButtonToPage(PT,"FPS Boost MAX",function(s)
    if s then enFB() showN("FPS Boost ON","success")
    else dsFB() showN("FPS Boost OFF","info") end
end,{toggle=true,key="fpsBoost",icon="🚀"})

-- ============ VISUALS TAB ============
local VT=CreateTab("Visuals","👁️")
addSection(VT,"Players")

local EC={Names={}}

local function aNE(pl)
    if pl==LP then return end
    local hd=pl.Character and pl.Character:FindFirstChild("Head")
    if not hd or hd:FindFirstChild("LatinaNameESP") then return end
    local bb=Instance.new("BillboardGui",hd)
    bb.Name="LatinaNameESP"
    bb.Size=UDim2.new(0,140,0,26)
    bb.StudsOffset=Vector3.new(0,4.5,0)
    bb.AlwaysOnTop=true
    local t=Instance.new("TextLabel",bb)
    t.Size=UDim2.new(1,0,1,0)
    t.Text=pl.Name
    t.BackgroundTransparency=1
    t.Font=Enum.Font.GothamBold
    t.TextSize=12
    t.TextColor3=ACC
    t.TextStrokeTransparency=0.5
    t.TextStrokeColor3=Color3.new(0,0,0)
end

AddButtonToPage(VT,"Player Name ESP",function(s)
    if s then
        for _,pl in ipairs(P:GetPlayers()) do aNE(pl) end
        table.insert(EC.Names,P.PlayerAdded:Connect(aNE))
        for _,pl in ipairs(P:GetPlayers()) do
            table.insert(EC.Names,pl.CharacterAdded:Connect(function() task.wait(1) aNE(pl) end))
        end
        showN("Name ESP ON","success")
    else
        for _,c in ipairs(EC.Names) do c:Disconnect() end
        EC.Names={}
        for _,pl in ipairs(P:GetPlayers()) do
            local hd=pl.Character and pl.Character:FindFirstChild("Head")
            local o=hd and hd:FindFirstChild("LatinaNameESP")
            if o then o:Destroy() end
        end
        showN("Name ESP OFF","info")
    end
end,{toggle=true,key="nameESP",icon="🌈"})

addSection(VT,"Eggs")

local ES={Eggs=false}
local EL

local function gTP(o)
    if o:IsA("Model") then return o.PrimaryPart or o:FindFirstChildWhichIsA("BasePart")
    elseif o:IsA("BasePart") then return o end
end

local function fN(n)
    n=tonumber(n)
    if not n then return "?" end
    if n>=1e15 then return string.format("%.2fQa",n/1e15) end
    if n>=1e12 then return string.format("%.2fT",n/1e12) end
    if n>=1e9 then return string.format("%.2fB",n/1e9) end
    if n>=1e6 then return string.format("%.2fM",n/1e6) end
    if n>=1e3 then return string.format("%.2fK",n/1e3) end
    return tostring(math.floor(n))
end

local function gEI(o)
    local p,ps
    for _,a in ipairs({"Pet","Brainrot","Contents","Name","Content","Item","Type","Rarity"}) do
        local v=o:GetAttribute(a)
        if v and type(v)=="string" and #v>1 then p=v break end
    end
    for _,a in ipairs({"PerSecond","CashPerSecond","Income","CashPerSec","Value","Cash","IncomePerSec"}) do
        local v=o:GetAttribute(a)
        if v and tonumber(v) then ps=tonumber(v) break end
    end
    return p,ps
end

local function clEE()
    for _,o in ipairs(workspace:GetChildren()) do
        local bb=o:FindFirstChild("LatinaEggESP")
        if bb then bb:Destroy() end
        if o:IsA("Model") then
            for _,c in ipairs(o:GetChildren()) do
                local bb2=c:FindFirstChild("LatinaEggESP")
                if bb2 then bb2:Destroy() end
            end
        end
    end
end

local function scE()
    local c=0
    for _,o in ipairs(workspace:GetChildren()) do
        if (o:IsA("BasePart") or o:IsA("Model")) and string.find(string.lower(o.Name),"egg") then
            if not string.find(string.lower(o.Name),"spawn") and not string.find(string.lower(o.Name),"base") then
                local tp=gTP(o)
                if tp and not tp:FindFirstChild("LatinaEggESP") then
                    c=c+1
                    local p,ps=gEI(o)
                    local bb=Instance.new("BillboardGui",tp)
                    bb.Name="LatinaEggESP"
                    bb.Size=UDim2.new(0,180,0,36)
                    bb.StudsOffset=Vector3.new(0,5,0)
                    bb.AlwaysOnTop=true
                    local pl=Instance.new("TextLabel",bb)
                    pl.Size=UDim2.new(1,0,0.5,0)
                    pl.BackgroundTransparency=1
                    pl.Text="Pet: "..(p or "???")
                    pl.Font=Enum.Font.GothamBold
                    pl.TextSize=11
                    pl.TextColor3=ACC
                    pl.TextStrokeTransparency=0.3
                    pl.TextStrokeColor3=Color3.new(0,0,0)
                    local sl=Instance.new("TextLabel",bb)
                    sl.Size=UDim2.new(1,0,0.5,0)
                    sl.Position=UDim2.new(0,0,0.5,0)
                    sl.BackgroundTransparency=1
                    sl.Text="$: "..(ps and fN(ps) or "???")
                    sl.Font=Enum.Font.GothamBold
                    sl.TextSize=10
                    sl.TextColor3=ACG
                    sl.TextStrokeTransparency=0.4
                    sl.TextStrokeColor3=Color3.new(0,0,0)
                end
            end
        end
    end
    return c
end

AddButtonToPage(VT,"Egg ESP + Pet Info",function(s)
    if s then
        ES.Eggs=true
        local n=scE()
        showN("Marked "..n.." eggs","success")
        EL=task.spawn(function()
            while ES.Eggs do
                task.wait(4)
                if ES.Eggs then scE() end
            end
        end)
    else
        ES.Eggs=false
        if EL then task.cancel(EL) EL=nil end
        clEE()
        showN("Egg ESP OFF","info")
    end
end,{toggle=true,key="eggESP",icon="🥚"})
                -- ============ QUICK TAB ============
local QT=CreateTab("Quick","⚡")
addSection(QT,"Movement")

local CT=false
AddButtonToPage(QT,"Click Teleport",function(s)
    CT=s
    if s then showN("Click TP ON","success") else showN("Click TP OFF","info") end
end,{toggle=true,key="clickTP",icon="📍"})

UIS.InputBegan:Connect(function(input,gp)
    if gp then return end
    if not CT then return end
    if input.UserInputType~=Enum.UserInputType.MouseButton1 and input.UserInputType~=Enum.UserInputType.Touch then return end
    local ch=LP.Character
    local h=ch and ch:FindFirstChild("HumanoidRootPart")
    if not h then return end
    local m=LP:GetMouse()
    if m and m.Hit then pcall(function() h.CFrame=CFrame.new(m.Hit.Position+Vector3.new(0,3,0)) end) end
end)

AddButtonToPage(QT,"Invisible",function(s)
    local ch=LP.Character
    if not ch then return end
    for _,p in ipairs(ch:GetDescendants()) do
        if p:IsA("BasePart") then
            if s then
                p.Transparency=1
                if p.Name=="Head" then
                    for _,d in ipairs(p:GetChildren()) do
                        if d:IsA("Decal") or d:IsA("Texture") then d.Transparency=1 end
                    end
                end
            else
                if p.Name~="HumanoidRootPart" then p.Transparency=0 end
                if p.Name=="Head" then
                    for _,d in ipairs(p:GetChildren()) do
                        if d:IsA("Decal") or d:IsA("Texture") then d.Transparency=0 end
                    end
                end
            end
        end
    end
    showN("Invisible "..(s and "ON" or "OFF"),s and "success" or "info")
end,{toggle=true,key="invisible",icon="👤"})

-- ============ EXTRAS TAB ============
local XT=CreateTab("Extras","✨")
addSection(XT,"Visual")

local CG,CL
AddButtonToPage(XT,"Clock Overlay",function(s)
    if s then
        CG=Instance.new("ScreenGui",PG)
        CG.IgnoreGuiInset=true
        CG.ResetOnSpawn=false
        local f=Instance.new("Frame",CG)
        f.Size=UDim2.new(0,90,0,22)
        f.Position=UDim2.new(1,-100,0,140)
        f.BackgroundColor3=Themes[Config.Theme].TopBar
        f.BackgroundTransparency=0.2
        cor(f,6)
        str(f,ACC,1,0.5)
        CL=Instance.new("TextLabel",f)
        CL.Size=UDim2.new(1,0,1,0)
        CL.BackgroundTransparency=1
        CL.Text="00:00:00"
        CL.TextColor3=ACC
        CL.TextSize=11
        CL.Font=Enum.Font.GothamBold
        task.spawn(function()
            while CG and CG.Parent do
                task.wait(1)
                local t=os.date("*t")
                CL.Text=string.format("%02d:%02d:%02d",t.hour,t.min,t.sec)
            end
        end)
        showN("Clock ON","success")
    else
        if CG then CG:Destroy() CG=nil end
        showN("Clock OFF","info")
    end
end,{toggle=true,key="clock",icon="🕐"})

local CG2,CL2
AddButtonToPage(XT,"Coordinates",function(s)
    if s then
        CG2=Instance.new("ScreenGui",PG)
        CG2.IgnoreGuiInset=true
        CG2.ResetOnSpawn=false
        local f=Instance.new("Frame",CG2)
        f.Size=UDim2.new(0,180,0,22)
        f.Position=UDim2.new(1,-190,0,168)
        f.BackgroundColor3=Themes[Config.Theme].TopBar
        f.BackgroundTransparency=0.2
        cor(f,6)
        str(f,ACC,1,0.5)
        CL2=Instance.new("TextLabel",f)
        CL2.Size=UDim2.new(1,0,1,0)
        CL2.BackgroundTransparency=1
        CL2.Text="X: --  Y: --  Z: --"
        CL2.TextColor3=ACC
        CL2.TextSize=10
        CL2.Font=Enum.Font.GothamBold
        task.spawn(function()
            while CG2 and CG2.Parent do
                local ch=LP.Character
                local h=ch and ch:FindFirstChild("HumanoidRootPart")
                if h then CL2.Text=string.format("X: %.0f  Y: %.0f  Z: %.0f",h.Position.X,h.Position.Y,h.Position.Z) end
                task.wait(0.2)
            end
        end)
        showN("Coords ON","success")
    else
        if CG2 then CG2:Destroy() CG2=nil end
        showN("Coords OFF","info")
    end
end,{toggle=true,key="coords",icon="📍"})

local RC
AddButtonToPage(XT,"Rainbow Character",function(s)
    if s then
        RC=RS.Heartbeat:Connect(function()
            local ch=LP.Character
            if not ch then return end
            local h=(tick()*0.3)%1
            for _,p in ipairs(ch:GetDescendants()) do
                if p:IsA("BasePart") then pcall(function() p.Color=Color3.fromHSV(h,0.8,1) end) end
            end
        end)
        showN("Rainbow ON","success")
    else
        if RC then RC:Disconnect() RC=nil end
        showN("Rainbow OFF","info")
    end
end,{toggle=true,key="rainbowChar",icon="🌈"})

addSection(XT,"Utility")

AddButtonToPage(XT,"Server Region",function()
    local r="Unknown"
    pcall(function()
        local d=HS:JSONDecode(game:HttpGet("https://ipinfo.io/json"))
        r=(d.city or "?")..", "..(d.country or "?")
    end)
    showN("Region: "..r,"info")
end,{icon="🌍"})

local EG,EL2
AddButtonToPage(XT,"Entity Counter",function(s)
    if s then
        EG=Instance.new("ScreenGui",PG)
        EG.IgnoreGuiInset=true
        EG.ResetOnSpawn=false
        local f=Instance.new("Frame",EG)
        f.Size=UDim2.new(0,150,0,50)
        f.Position=UDim2.new(1,-160,0,196)
        f.BackgroundColor3=Themes[Config.Theme].TopBar
        f.BackgroundTransparency=0.2
        cor(f,6)
        str(f,ACC,1,0.5)
        EL2=Instance.new("TextLabel",f)
        EL2.Size=UDim2.new(1,0,1,0)
        EL2.BackgroundTransparency=1
        EL2.Text="..."
        EL2.TextColor3=ACC
        EL2.TextSize=10
        EL2.Font=Enum.Font.GothamBold
        task.spawn(function()
            while EG and EG.Parent do
                task.wait(2)
                local c=0
                for _ in ipairs(workspace:GetDescendants()) do c=c+1 end
                EL2.Text=string.format("👥 %d players\n📦 %d objects",#P:GetPlayers(),c)
            end
        end)
        showN("Entity ON","success")
    else
        if EG then EG:Destroy() EG=nil end
        showN("Entity OFF","info")
    end
end,{toggle=true,key="entCount",icon="📊"})

local NTF=Instance.new("Frame",XT)
NTF.Size=UDim2.new(1,-8,0,90)
NTF.BackgroundColor3=Themes[Config.Theme].Element
NTF.BackgroundTransparency=0.15
NTF.ZIndex=104
cor(NTF,8)
str(NTF,Themes[Config.Theme].Border,1,0.4)
local NTT=Instance.new("TextLabel",NTF)
NTT.Size=UDim2.new(1,-20,0,16)
NTT.Position=UDim2.new(0,12,0,4)
NTT.BackgroundTransparency=1
NTT.Text="📝 QUICK NOTE"
NTT.TextColor3=ACC
NTT.TextSize=9
NTT.Font=Enum.Font.GothamBold
NTT.TextXAlignment=Enum.TextXAlignment.Left
NTT.ZIndex=105
local NTB=Instance.new("TextBox",NTF)
NTB.Size=UDim2.new(1,-24,1,-28)
NTB.Position=UDim2.new(0,12,0,24)
NTB.BackgroundColor3=Themes[Config.Theme].TopBar
NTB.BorderSizePixel=0
NTB.Text=""
NTB.PlaceholderText="Type notes here..."
NTB.PlaceholderColor3=Themes[Config.Theme].TextDim
NTB.TextColor3=Themes[Config.Theme].Text
NTB.TextSize=10
NTB.Font=Enum.Font.Gotham
NTB.TextXAlignment=Enum.TextXAlignment.Left
NTB.TextYAlignment=Enum.TextYAlignment.Top
NTB.TextWrapped=true
NTB.MultiLine=true
NTB.ClearTextOnFocus=false
NTB.ZIndex=105
cor(NTB,6)
str(NTB,Themes[Config.Theme].Border,1,0.4)
NTB:GetPropertyChangedSignal("Text"):Connect(function()
    if writefile then pcall(function() writefile("latina_note.txt",NTB.Text) end) end
end)
pcall(function()
    if readfile and isfile and isfile("latina_note.txt") then NTB.Text=readfile("latina_note.txt") end
end)

addSection(XT,"Fun")

AddButtonToPage(XT,"Screen Shake",function()
    task.spawn(function()
        local cm=workspace.CurrentCamera
        local og=cm.CFrame
        for i=1,20 do
            local off=Vector3.new(math.random(-5,5)/10,math.random(-5,5)/10,math.random(-5,5)/10)
            cm.CFrame=og*CFrame.new(off)
            task.wait(0.03)
        end
        cm.CFrame=og
    end)
    showN("Screen shake!","info")
end,{icon="🌋"})

AddButtonToPage(XT,"Emoji Rain",function()
    local RG=Instance.new("ScreenGui",PG)
    RG.IgnoreGuiInset=true
    RG.ResetOnSpawn=false
    local em={"🌟","✨","⭐","💫","🌙","☄️"}
    task.spawn(function()
        for i=1,30 do
            local e=Instance.new("TextLabel",RG)
            e.Size=UDim2.new(0,30,0,30)
            e.Position=UDim2.new(math.random(),0,-0.05,0)
            e.BackgroundTransparency=1
            e.Text=em[math.random(1,#em)]
            e.TextSize=math.random(18,30)
            e.ZIndex=99999
            TS:Create(e,TweenInfo.new(math.random(20,35)/10,Enum.EasingStyle.Linear),{Position=UDim2.new(e.Position.X.Scale,0,1.05,0)}):Play()
            task.spawn(function() task.wait(4) e:Destroy() end)
        end
        task.wait(5)
        RG:Destroy()
    end)
    showN("Emoji rain!","success")
end,{icon="🌧"})

-- ============ UTILITY TAB ============
local UT=CreateTab("Utility","⚙️")
addSection(UT,"Display")

local CHG
AddButtonToPage(UT,"Crosshair",function(s)
    if s then
        CHG=Instance.new("ScreenGui",PG)
        CHG.IgnoreGuiInset=true
        CHG.ResetOnSpawn=false
        local d=Instance.new("Frame",CHG)
        d.Size=UDim2.new(0,4,0,4) d.Position=UDim2.new(0.5,-2,0.5,-2)
        d.BackgroundColor3=ACC d.BorderSizePixel=0 cor(d,2)
        local c1=Instance.new("Frame",CHG)
        c1.Size=UDim2.new(0,16,0,1) c1.Position=UDim2.new(0.5,-8,0.5,-0.5)
        c1.BackgroundColor3=ACC c1.BorderSizePixel=0
        local c2=Instance.new("Frame",CHG)
        c2.Size=UDim2.new(0,1,0,16) c2.Position=UDim2.new(0.5,-0.5,0.5,-8)
        c2.BackgroundColor3=ACC c2.BorderSizePixel=0
        showN("Crosshair ON","success")
    else
        if CHG then CHG:Destroy() CHG=nil end
        showN("Crosshair OFF","info")
    end
end,{toggle=true,key="crosshair",icon="🎯"})

local SST=tick()
local SG2,SL2
AddButtonToPage(UT,"Session Timer",function(s)
    if s then
        SST=tick()
        SG2=Instance.new("ScreenGui",PG)
        SG2.IgnoreGuiInset=true
        SG2.ResetOnSpawn=false
        local f=Instance.new("Frame",SG2)
        f.Size=UDim2.new(0,130,0,24)
        f.Position=UDim2.new(1,-140,0,8)
        f.BackgroundColor3=Themes[Config.Theme].TopBar
        f.BackgroundTransparency=0.15
        cor(f,6)
        str(f,ACC,1,0.4)
        SL2=Instance.new("TextLabel",f)
        SL2.Size=UDim2.new(1,0,1,0)
        SL2.BackgroundTransparency=1
        SL2.Text="⏱ 00:00:00"
        SL2.TextColor3=ACC
        SL2.TextSize=11
        SL2.Font=Enum.Font.GothamBold
        task.spawn(function()
            while SG2 and SG2.Parent do
                task.wait(1)
                local el=math.floor(tick()-SST)
                local h=math.floor(el/3600)
                local m=math.floor((el%3600)/60)
                local sec=el%60
                SL2.Text=string.format("⏱ %02d:%02d:%02d",h,m,sec)
            end
        end)
        showN("Session Timer ON","success")
    else
        if SG2 then SG2:Destroy() SG2=nil end
        showN("Session Timer OFF","info")
    end
end,{toggle=true,key="sessionTimer",icon="⏱"})

addSection(UT,"Server")

local PJ1,PJ2
AddButtonToPage(UT,"Join/Leave Notifs",function(s)
    if s then
        PJ1=P.PlayerAdded:Connect(function(pl) showN("✅ "..pl.Name.." joined","success") end)
        PJ2=P.PlayerRemoving:Connect(function(pl) showN("❌ "..pl.Name.." left","error") end)
        showN("Join/Leave ON","success")
    else
        if PJ1 then PJ1:Disconnect() PJ1=nil end
        if PJ2 then PJ2:Disconnect() PJ2=nil end
        showN("Join/Leave OFF","info")
    end
end,{toggle=true,key="joinLeave",icon="📢"})

-- ============ SPLASH SCREEN ============
local CN=Instance.new("Frame",SG)
CN.Size=UDim2.new(0,0,0,0)
CN.Position=UDim2.new(0.5,0,0.5,0)
CN.AnchorPoint=Vector2.new(0.5,0.5)
CN.BackgroundColor3=Themes[Config.Theme].MainBg
CN.ZIndex=5000
cor(CN,20)
str(CN,ACC,2,0.3)

local BD=Instance.new("TextButton",CN)
BD.Size=UDim2.new(1,0,1,0)
BD.BackgroundColor3=Themes[Config.Theme].MainBg
BD.BackgroundTransparency=1
BD.Text=""
BD.ZIndex=5001
cor(BD,20)

local IM=Instance.new("ImageLabel",CN)
IM.Size=UDim2.new(0,120,0,120)
IM.Position=UDim2.new(0.5,-60,0.5,-80)
IM.BackgroundTransparency=1
IM.Image="rbxassetid://100104680190424"
IM.ImageTransparency=1
IM.ZIndex=5001

local ST2=Instance.new("UIStroke",IM)
ST2.Color=ACC
ST2.Thickness=2
ST2.Transparency=1

local TT=Instance.new("TextLabel",CN)
TT.Size=UDim2.new(1,0,0,40)
TT.Position=UDim2.new(0,0,0.5,20)
TT.BackgroundTransparency=1
TT.Text="LATINA HUB"
TT.TextColor3=ACC
TT.TextSize=20
TT.Font=Enum.Font.GothamBold
TT.TextTransparency=1
TT.ZIndex=5002

local SU=Instance.new("TextLabel",CN)
SU.Size=UDim2.new(1,0,0,20)
SU.Position=UDim2.new(0,0,1,40)
SU.BackgroundTransparency=1
SU.Text="V1 NEW RELEASE"
SU.TextColor3=ACC
SU.TextSize=11
SU.Font=Enum.Font.GothamMedium
SU.TextTransparency=1
SU.ZIndex=5002

task.spawn(function()
    TS:Create(BD,TweenInfo.new(0.5),{BackgroundTransparency=0.4}):Play()
    TS:Create(IM,TweenInfo.new(0.9),{ImageTransparency=0}):Play()
    TS:Create(ST2,TweenInfo.new(0.9),{Transparency=0}):Play()
    TS:Create(CN,TweenInfo.new(1.0),{Size=UDim2.new(0,240,0,240)}):Play()
    task.wait(0.35)
    TS:Create(TT,TweenInfo.new(0.5),{TextTransparency=0}):Play()
    task.wait(0.15)
    TS:Create(SU,TweenInfo.new(0.5),{TextTransparency=0}):Play()
    task.wait(1.5)
    local out=TS:Create(CN,TweenInfo.new(0.7,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Size=UDim2.new(0,280,0,280)})
    TS:Create(IM,TweenInfo.new(0.7),{ImageTransparency=1}):Play()
    TS:Create(ST2,TweenInfo.new(0.7),{Transparency=1}):Play()
    TS:Create(TT,TweenInfo.new(0.4),{TextTransparency=1}):Play()
    TS:Create(SU,TweenInfo.new(0.4),{TextTransparency=1}):Play()
    TS:Create(BD,TweenInfo.new(0.6),{BackgroundTransparency=1}):Play()
    out:Play()
    out.Completed:Wait()
    BD:Destroy()
    CN:Destroy()
    if IS then IS:Destroy() IS=nil end
    MF.Visible=true
    activateFirstTab()
    if BL then TS:Create(BL,TweenInfo.new(0.5),{Size=8}):Play() end
    showN("LATINA HUB V1 — Ready","success")
end)
