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

local function cor(p,r) local c=Instance.new("UICorner",p) c.CornerRadius=UDim.new(0,r or 8) return c end
local function str(p,c,t,tr) local s=Instance.new("UIStroke",p) s.Color=c or Color3.fromRGB(70,70,90) s.Thickness=t or 1 s.Transparency=tr or 0.5 s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border return s end
local function gr(p,c1,c2,r) local g=Instance.new("UIGradient",p) g.Rotation=r or 90 g.Color=ColorSequence.new(c1,c2) return g end

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
                local T2=Instance.new("TextLabel",F)
                T2.Size=UDim2.new(1,-28,1,0)
                T2.Position=UDim2.new(0,20,0,0)
                T2.BackgroundTransparency=1
                T2.Text=e.text
                T2.TextColor3=Themes[Config.Theme].Text
                T2.TextTransparency=0.1
                T2.TextSize=11
                T2.Font=Enum.Font.GothamMedium
                T2.TextWrapped=true
                T2.TextXAlignment=Enum.TextXAlignment.Left
                T2.ZIndex=100000
                TS:Create(F,TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-140,1,-60)}):Play()
                task.wait(2.4)
                local out=TS:Create(F,TweenInfo.new(0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Position=UDim2.new(0.5,-140,1,20),BackgroundTransparency=1})
                TS:Create(T2,TweenInfo.new(0.3),{TextTransparency=1}):Play()
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

local BS=Instance.new("Frame",TBAR)
BS.Size=UDim2.new(0,26,0,26)
BS.Position=UDim2.new(0,12,0.5,-13)
BS.BackgroundColor3=ACC
BS.ZIndex=103
cor(BS,7)
gr(BS,Color3.fromRGB(150,160,255),Color3.fromRGB(100,110,220))

local BI=Instance.new("ImageLabel",BS)
BI.Size=UDim2.new(1,-6,1,-6)
BI.Position=UDim2.new(0,3,0,3)
BI.BackgroundTransparency=1
BI.Image="rbxassetid://100104680190424"
BI.ZIndex=104

local TL=Instance.new("TextLabel",TBAR)
TL.Size=UDim2.new(0,200,0,18)
TL.Position=UDim2.new(0,46,0,4)
TL.BackgroundTransparency=1
TL.Text="LATINA HUB"
TL.TextColor3=Themes[Config.Theme].Text
TL.TextSize=13
TL.Font=Enum.Font.GothamBold
TL.TextXAlignment=Enum.TextXAlignment.Left
TL.ZIndex=103
task.spawn(function()
    local h=0
    while TL and TL.Parent do
        h=(h+0.006)%1
        TL.TextColor3=Color3.fromHSV(h,1,1)
        task.wait(0.03)
    end
end)

local VB=Instance.new("TextLabel",TBAR)
VB.Size=UDim2.new(0,96,0,14)
VB.Position=UDim2.new(0,46,0,23)
VB.BackgroundColor3=ACC
VB.BackgroundTransparency=0.7
VB.Text="V1 NEW RELEASE"
VB.TextColor3=ACC
VB.TextSize=8
VB.Font=Enum.Font.GothamBold
VB.ZIndex=103
cor(VB,4)
task.spawn(function()
    local h=0.5
    while VB and VB.Parent do
        h=(h+0.008)%1
        local c=Color3.fromHSV(h,1,1)
        VB.TextColor3=c
        VB.BackgroundColor3=c
        task.wait(0.03)
    end
end)

local ML=Instance.new("TextLabel",TBAR)
ML.Size=UDim2.new(0,140,0,12)
ML.Position=UDim2.new(1,-180,0,15)
ML.BackgroundTransparency=1
ML.Text="FPS -- | --ms"
ML.TextColor3=ACG
ML.TextSize=9
ML.Font=Enum.Font.GothamBold
ML.TextXAlignment=Enum.TextXAlignment.Right
ML.ZIndex=104

local DH=Instance.new("TextLabel",TBAR)
DH.Size=UDim2.new(0,60,1,0)
DH.Position=UDim2.new(0,200,0,0)
DH.BackgroundTransparency=1
DH.Text="⋮⋮"
DH.TextColor3=Themes[Config.Theme].TextDim
DH.TextSize=10
DH.Font=Enum.Font.GothamBold
DH.ZIndex=103

local function iB(pr,tx,c,x)
    local b=Instance.new("TextButton",pr)
    b.Size=UDim2.new(0,26,0,26)
    b.Position=UDim2.new(1,x,0.5,-13)
    b.BackgroundColor3=Themes[Config.Theme].Element
    b.Text=tx
    b.TextColor3=c
    b.TextSize=13
    b.Font=Enum.Font.GothamBold
    b.AutoButtonColor=false
    b.ZIndex=105
    cor(b,8)
    str(b,Themes[Config.Theme].Border,1,0.5)
    return b
end

local CB=iB(TBAR,"✕",ACR,-34)
CB.MouseEnter:Connect(function()
    TS:Create(CB,TweenInfo.new(0.15),{BackgroundColor3=ACR}):Play()
    CB.TextColor3=Color3.fromRGB(20,20,30)
end)
CB.MouseLeave:Connect(function()
    TS:Create(CB,TweenInfo.new(0.15),{BackgroundColor3=Themes[Config.Theme].Element}):Play()
    CB.TextColor3=ACR
end)

local DRG=false
local DS=nil
local SP=nil
TBAR.InputBegan:Connect(function(input)
    if input.UserInputType~=Enum.UserInputType.MouseButton1 and input.UserInputType~=Enum.UserInputType.Touch then return end
    DRG=true
    DS=input.Position
    SP=MF.Position
end)
UIS.InputChanged:Connect(function(input)
    if not DRG then return end
    if input.UserInputType~=Enum.UserInputType.MouseMovement and input.UserInputType~=Enum.UserInputType.Touch then return end
    local d=input.Position-DS
    MF.Position=UDim2.new(SP.X.Scale,SP.X.Offset+d.X,SP.Y.Scale,SP.Y.Offset+d.Y)
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then DRG=false end
end)

local FC,LU=0,tick()
RS.RenderStepped:Connect(function()
    FC=FC+1
    if tick()-LU>=1 then
        local f=FC
        FC=0
        LU=tick()
        local pg=0
        pcall(function() pg=math.floor(ST.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
        ML.Text=string.format("FPS %d | %dms",f,pg)
        if pg<80 and f>45 then ML.TextColor3=ACG
        elseif pg<150 and f>25 then ML.TextColor3=ACY
        else ML.TextColor3=ACR end
    end
end)

local IO=true
local function sB(t) TS:Create(BL,TweenInfo.new(0.4,Enum.EasingStyle.Quart),{Size=t}):Play() end
local function TW()
    pC()
    IO=not IO
    MF.Visible=IO
    sB(IO and 8 or 0)
end
TB.MouseButton1Click:Connect(TW)
CB.MouseButton1Click:Connect(TW)
UIS.InputBegan:Connect(function(input,gp)
    if gp then return end
    if input.KeyCode==Enum.KeyCode.RightShift then TW() end
end)

local SB=Instance.new("ScrollingFrame",MF)
SB.Size=UDim2.new(0,110,1,-56)
SB.Position=UDim2.new(0,12,0,52)
SB.BackgroundTransparency=1
SB.BorderSizePixel=0
SB.CanvasSize=UDim2.new(0,0,0,800)
SB.ScrollBarThickness=2
SB.ScrollBarImageColor3=ACC
SB.ScrollBarImageTransparency=0.7
SB.ZIndex=102

local SBL=Instance.new("UIListLayout",SB)
SBL.SortOrder=Enum.SortOrder.LayoutOrder
SBL.Padding=UDim.new(0,3)

local PC2=Instance.new("Frame",MF)
PC2.Size=UDim2.new(1,-135,1,-56)
PC2.Position=UDim2.new(0,127,0,52)
PC2.BackgroundTransparency=1
PC2.ZIndex=102

local ATB={}
local AP={}
local CE={}
local function CreateTab(title,icon)
    local ti=#ATB+1
    local T=Instance.new("TextButton",SB)
    T.Size=UDim2.new(1,-6,0,32)
    T.BackgroundColor3=Themes[Config.Theme].Element
    T.BackgroundTransparency=0.5
    T.Text=""
    T.AutoButtonColor=false
    T.ZIndex=103
    cor(T,7)

    local I=Instance.new("Frame",T)
    I.Size=UDim2.new(0,3,0,0)
    I.Position=UDim2.new(0,-1,0.5,0)
    I.AnchorPoint=Vector2.new(0,0.5)
    I.BackgroundColor3=ACC
    I.BorderSizePixel=0
    I.BackgroundTransparency=1
    I.ZIndex=104
    cor(I,2)

    local IF=Instance.new("Frame",T)
    IF.Size=UDim2.new(0,18,0,18)
    IF.Position=UDim2.new(0,6,0.5,-9)
    IF.BackgroundColor3=Themes[Config.Theme].TopBar
    IF.BackgroundTransparency=0.3
    IF.ZIndex=104
    cor(IF,5)

    local IL=Instance.new("TextLabel",IF)
    IL.Size=UDim2.new(1,0,1,0)
    IL.BackgroundTransparency=1
    IL.Text=icon or "•"
    IL.TextColor3=Themes[Config.Theme].TextDim
    IL.TextSize=10
    IL.Font=Enum.Font.GothamBold
    IL.ZIndex=105

    local X=Instance.new("TextLabel",T)
    X.Size=UDim2.new(1,-30,1,0)
    X.Position=UDim2.new(0,28,0,0)
    X.BackgroundTransparency=1
    X.Text=title
    X.TextColor3=Themes[Config.Theme].TextDim
    X.TextSize=10
    X.Font=Enum.Font.GothamMedium
    X.TextXAlignment=Enum.TextXAlignment.Left
    X.TextTruncate=Enum.TextTruncate.AtEnd
    X.ZIndex=105

    T.MouseEnter:Connect(function()
        if not T:GetAttribute("Active") then
            TS:Create(T,TweenInfo.new(0.15),{BackgroundTransparency=0.15}):Play()
        end
    end)
    T.MouseLeave:Connect(function()
        if not T:GetAttribute("Active") then
            TS:Create(T,TweenInfo.new(0.15),{BackgroundTransparency=0.5}):Play()
        end
    end)

    local PG2=Instance.new("ScrollingFrame",PC2)
    PG2.Size=UDim2.new(1,0,1,0)
    PG2.BackgroundTransparency=1
    PG2.BorderSizePixel=0
    PG2.CanvasSize=UDim2.new(0,0,0,0)
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

    table.insert(ATB,{Button=T,Page=PG2,Indicator=I,IconFrame=IF,IconLabel=IL,TextLabel=X})
    table.insert(AP,PG2)

    T.MouseButton1Click:Connect(function()
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
        T:SetAttribute("Active",true)
        T.BackgroundTransparency=0
        I.BackgroundTransparency=0
        IF.BackgroundColor3=ACC
        IL.TextColor3=Color3.fromRGB(20,20,30)
        X.TextColor3=Themes[Config.Theme].Text
        TS:Create(I,TweenInfo.new(0.25),{Size=UDim2.new(0,3,1,-8)}):Play()
    end)

    if ti==1 then
        PG2.Visible=true
        T:SetAttribute("Active",true)
        T.BackgroundTransparency=0
        I.BackgroundTransparency=0
        I.Size=UDim2.new(0,3,1,-8)
        IF.BackgroundColor3=ACC
        IL.TextColor3=Color3.fromRGB(20,20,30)
        X.TextColor3=Themes[Config.Theme].Text
    end

    return PG2
end

local function AddButtonToPage(page,name,cb,op)
    op=op or {}
    local isT=op.toggle or false
    local sE=op.exec or false
    local k=op.key
    local ic=op.icon
    local st=false

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
    BR.BackgroundTransparency=1
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

    local lP=ic and 42 or 18
    local NL=Instance.new("TextLabel",B)
    NL.Size=UDim2.new(1,(sE and 80 or 0)+(isT and 55 or 0)+(-lP),1,0)
    NL.Position=UDim2.new(0,lP,0,0)
    NL.BackgroundTransparency=1
    NL.Text=name
    NL.TextColor3=Themes[Config.Theme].Text
    NL.TextSize=11
    NL.Font=Enum.Font.GothamMedium
    NL.TextXAlignment=Enum.TextXAlignment.Left
    NL.TextTruncate=Enum.TextTruncate.AtEnd
    NL.ZIndex=105

    if sE and not isT then
        local ET=Instance.new("TextLabel",B)
        ET.Size=UDim2.new(0,70,1,0)
        ET.Position=UDim2.new(1,-78,0,0)
        ET.BackgroundTransparency=1
        ET.Text="RUN  ›"
        ET.TextColor3=ACC
        ET.TextSize=10
        ET.Font=Enum.Font.GothamBold
        ET.TextXAlignment=Enum.TextXAlignment.Right
        ET.ZIndex=105
    end

    if isT then
        local Pi=Instance.new("Frame",B)
        Pi.Size=UDim2.new(0,34,0,18)
        Pi.Position=UDim2.new(1,-44,0.5,-9)
        Pi.BackgroundColor3=Themes[Config.Theme].TopBar
        Pi.BorderSizePixel=0
        Pi.ZIndex=105
        cor(Pi,999)
        local K=Instance.new("Frame",Pi)
        K.Size=UDim2.new(0,14,0,14)
        K.Position=UDim2.new(0,2,0.5,-7)
        K.BackgroundColor3=Themes[Config.Theme].TextDim
        K.BorderSizePixel=0
        K.ZIndex=106
        cor(K,999)

        local function sV(on)
            TS:Create(Pi,TweenInfo.new(0.22),{BackgroundColor3=on and ACC or Themes[Config.Theme].TopBar}):Play()
            TS:Create(K,TweenInfo.new(0.25),{Position=on and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7),BackgroundColor3=on and Color3.fromRGB(255,255,255) or Themes[Config.Theme].TextDim}):Play()
            TS:Create(BS2,TweenInfo.new(0.2),{Color=on and ACC or Themes[Config.Theme].Border,Transparency=on and 0.2 or 0.4}):Play()
            TS:Create(BR,TweenInfo.new(0.2),{BackgroundTransparency=on and 0 or 1}):Play()
        end

        if k and Config.Toggles[k] then st=true sV(true) end
        B.MouseButton1Click:Connect(function()
            pC()
            st=not st
            sV(st)
            if k then Config.Toggles[k]=st svC(Config) end
            local ok,er=pcall(cb,st)
            if not ok then warn("[Latina] "..tostring(er)) end
        end)
        B.MouseEnter:Connect(function()
            TS:Create(B,TweenInfo.new(0.15),{BackgroundColor3=Themes[Config.Theme].ElementHover,BackgroundTransparency=0}):Play()
        end)
        B.MouseLeave:Connect(function()
            TS:Create(B,TweenInfo.new(0.15),{BackgroundColor3=Themes[Config.Theme].Element,BackgroundTransparency=0.15}):Play()
        end)
    else
        B.MouseButton1Click:Connect(function()
            pC()
            if sE then pE() end
            local ok,er=pcall(cb)
            if not ok then warn("[Latina] "..tostring(er)) end
        end)
        B.MouseEnter:Connect(function()
            TS:Create(B,TweenInfo.new(0.15),{BackgroundColor3=Themes[Config.Theme].ElementHover,BackgroundTransparency=0}):Play()
            TS:Create(BS2,TweenInfo.new(0.15),{Color=ACC,Transparency=0.3}):Play()
            TS:Create(BR,TweenInfo.new(0.15),{BackgroundTransparency=0.4}):Play()
        end)
        B.MouseLeave:Connect(function()
            TS:Create(B,TweenInfo.new(0.15),{BackgroundColor3=Themes[Config.Theme].Element,BackgroundTransparency=0.15}):Play()
            TS:Create(BS2,TweenInfo.new(0.15),{Color=Themes[Config.Theme].Border,Transparency=0.4}):Play()
            TS:Create(BR,TweenInfo.new(0.15),{BackgroundTransparency=1}):Play()
        end)
    end
end

local function addSection(page,text)
    local H=Instance.new("TextLabel",page)
    H.Size=UDim2.new(1,-10,0,16)
    H.BackgroundTransparency=1
    H.Text=string.upper(text)
    H.TextColor3=Themes[Config.Theme].TextDim
    H.TextSize=9
    H.Font=Enum.Font.GothamBold
    H.TextXAlignment=Enum.TextXAlignment.Left
    H.ZIndex=105
    return H
end

local function createCollapsible(parent,title,sub,icon,defOpen,ac)
    local C=Instance.new("Frame",parent)
    C.Size=UDim2.new(1,-8,0,40)
    C.BackgroundColor3=Themes[Config.Theme].Element
    C.BackgroundTransparency=0.1
    C.ZIndex=104
    cor(C,8)
    str(C,ac or ACC,1.2,0.4)
    gr(C,Themes[Config.Theme].Element,Themes[Config.Theme].TopBar)

    local HD=Instance.new("TextButton",C)
    HD.Size=UDim2.new(1,0,0,40)
    HD.BackgroundTransparency=1
    HD.Text=""
    HD.AutoButtonColor=false
    HD.ZIndex=105

    local IB2=Instance.new("Frame",HD)
    IB2.Size=UDim2.new(0,24,0,24)
    IB2.Position=UDim2.new(0,10,0,8)
    IB2.BackgroundColor3=ac or ACC
    IB2.BackgroundTransparency=0.75
    IB2.ZIndex=106
    cor(IB2,6)

    local IL2=Instance.new("TextLabel",IB2)
    IL2.Size=UDim2.new(1,0,1,0)
    IL2.BackgroundTransparency=1
    IL2.Text=icon or "📁"
    IL2.TextSize=12
    IL2.ZIndex=107

    local T1=Instance.new("TextLabel",HD)
    T1.Size=UDim2.new(1,-90,0,14)
    T1.Position=UDim2.new(0,42,0,6)
    T1.BackgroundTransparency=1
    T1.Text=title
    T1.TextColor3=Themes[Config.Theme].Text
    T1.TextSize=11
    T1.Font=Enum.Font.GothamBold
    T1.TextXAlignment=Enum.TextXAlignment.Left
    T1.ZIndex=106

    local S1=Instance.new("TextLabel",HD)
    S1.Size=UDim2.new(1,-90,0,12)
    S1.Position=UDim2.new(0,42,0,21)
    S1.BackgroundTransparency=1
    S1.Text=sub or ""
    S1.TextColor3=Themes[Config.Theme].TextDim
    S1.TextSize=8
    S1.Font=Enum.Font.Gotham
    S1.TextXAlignment=Enum.TextXAlignment.Left
    S1.ZIndex=106

    local AR=Instance.new("TextLabel",HD)
    AR.Size=UDim2.new(0,20,0,20)
    AR.Position=UDim2.new(1,-30,0,10)
    AR.BackgroundTransparency=1
    AR.Text=defOpen and "▲" or "▼"
    AR.TextColor3=ac or ACC
    AR.TextSize=11
    AR.Font=Enum.Font.GothamBold
    AR.ZIndex=106

    local CT=Instance.new("Frame",C)
    CT.Size=UDim2.new(1,0,0,0)
    CT.Position=UDim2.new(0,0,0,40)
    CT.BackgroundTransparency=1
    CT.ClipsDescendants=true
    CT.ZIndex=104

    local CLL=Instance.new("UIListLayout",CT)
    CLL.SortOrder=Enum.SortOrder.LayoutOrder
    CLL.Padding=UDim.new(0,5)

    local PD=Instance.new("UIPadding",CT)
    PD.PaddingTop=UDim.new(0,5)
    PD.PaddingBottom=UDim.new(0,7)
    PD.PaddingLeft=UDim.new(0,4)
    PD.PaddingRight=UDim.new(0,4)

    local isO=defOpen or false

    local function US()
        if isO then
            local h=CLL.AbsoluteContentSize.Y+12
            C.Size=UDim2.new(1,-8,0,40+h)
            CT.Size=UDim2.new(1,0,0,h)
        else
            C.Size=UDim2.new(1,-8,0,40)
            CT.Size=UDim2.new(1,0,0,0)
        end
    end

    CLL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(US)
    task.spawn(function() task.wait(0.1) US() end)

    HD.MouseButton1Click:Connect(function()
        pC()
        isO=not isO
        AR.Text=isO and "▲" or "▼"
        US()
    end)
    HD.MouseEnter:Connect(function()
        TS:Create(C,TweenInfo.new(0.15),{BackgroundColor3=Themes[Config.Theme].ElementHover,BackgroundTransparency=0}):Play()
    end)
    HD.MouseLeave:Connect(function()
        TS:Create(C,TweenInfo.new(0.15),{BackgroundColor3=Themes[Config.Theme].Element,BackgroundTransparency=0.1}):Play()
    end)

    return CT
end

local function ApplyTheme(td,tn)
    ACC=td.Accent
    MF.BackgroundColor3=td.MainBg
    MG.Color=ColorSequence.new(td.MainBg,td.MainBg2)
    MS.Color=td.Border
    TBAR.BackgroundColor3=td.TopBar
    TF.BackgroundColor3=td.TopBar
    TG2.Color=ColorSequence.new(td.TopBar,td.MainBg)
    AL.BackgroundColor3=td.Accent
    BS.BackgroundColor3=td.Accent
    TBS.Color=td.Accent
    DH.TextColor3=td.TextDim
    for _,v in ipairs(ATB) do
        v.Button.BackgroundColor3=td.Element
        v.Indicator.BackgroundColor3=td.Accent
        if not v.Button:GetAttribute("Active") then
            v.IconFrame.BackgroundColor3=td.TopBar
            v.IconLabel.TextColor3=td.TextDim
            v.TextLabel.TextColor3=td.TextDim
        end
    end
    for _,e in ipairs(CE) do e.BackgroundColor3=td.Element end
    if tn then Config.Theme=tn svC(Config) end
                end
                local MainTab=CreateTab("Main","🏠")
addSection(MainTab,"User Info")

local card=Instance.new("Frame",MainTab)
card.Size=UDim2.new(1,-8,0,90)
card.BackgroundColor3=Themes[Config.Theme].Element
card.BackgroundTransparency=0.15
card.ZIndex=104
cor(card,8)
str(card,Themes[Config.Theme].Border,1,0.4)

local av=Instance.new("ImageLabel",card)
av.Size=UDim2.new(0,60,0,60)
av.Position=UDim2.new(0,12,0,15)
av.BackgroundColor3=Themes[Config.Theme].TopBar
av.BackgroundTransparency=0.3
av.ZIndex=105
cor(av,8)

local nameLbl=Instance.new("TextLabel",card)
nameLbl.Size=UDim2.new(1,-90,0,22)
nameLbl.Position=UDim2.new(0,82,0,15)
nameLbl.BackgroundTransparency=1
nameLbl.Text=LP.DisplayName or LP.Name
nameLbl.TextColor3=Themes[Config.Theme].Text
nameLbl.TextSize=15
nameLbl.Font=Enum.Font.GothamBold
nameLbl.TextXAlignment=Enum.TextXAlignment.Left
nameLbl.TextTruncate=Enum.TextTruncate.AtEnd
nameLbl.ZIndex=105

local userLbl=Instance.new("TextLabel",card)
userLbl.Size=UDim2.new(1,-90,0,18)
userLbl.Position=UDim2.new(0,82,0,40)
userLbl.BackgroundTransparency=1
userLbl.Text="@"..LP.Name
userLbl.TextColor3=ACC
userLbl.TextSize=13
userLbl.Font=Enum.Font.GothamBold
userLbl.TextXAlignment=Enum.TextXAlignment.Left
userLbl.TextTruncate=Enum.TextTruncate.AtEnd
userLbl.ZIndex=105

local idLbl=Instance.new("TextLabel",card)
idLbl.Size=UDim2.new(1,-90,0,16)
idLbl.Position=UDim2.new(0,82,0,60)
idLbl.BackgroundTransparency=1
idLbl.Text="ID: "..tostring(LP.UserId)
idLbl.TextColor3=Themes[Config.Theme].TextDim
idLbl.TextSize=10
idLbl.Font=Enum.Font.Gotham
idLbl.TextXAlignment=Enum.TextXAlignment.Left
idLbl.ZIndex=105

task.spawn(function()
    pcall(function()
        local thumb=P:GetUserThumbnailAsync(LP.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)
        if thumb and av then av.Image=thumb end
    end)
end)

addSection(MainTab,"Live Stats")
local statCard=Instance.new("Frame",MainTab)
statCard.Size=UDim2.new(1,-8,0,60)
statCard.BackgroundColor3=Themes[Config.Theme].Element
statCard.BackgroundTransparency=0.15
statCard.ZIndex=104
cor(statCard,8)
str(statCard,Themes[Config.Theme].Border,1,0.4)

local fpsM=Instance.new("TextLabel",statCard)
fpsM.Size=UDim2.new(0.5,-12,0,20)
fpsM.Position=UDim2.new(0,12,0,10)
fpsM.BackgroundTransparency=1
fpsM.Text="FPS: --"
fpsM.TextSize=12
fpsM.Font=Enum.Font.GothamBold
fpsM.TextXAlignment=Enum.TextXAlignment.Left
fpsM.ZIndex=105

local pingM=Instance.new("TextLabel",statCard)
pingM.Size=UDim2.new(0.5,-12,0,20)
pingM.Position=UDim2.new(0.5,0,0,10)
pingM.BackgroundTransparency=1
pingM.Text="PING: --"
pingM.TextSize=12
pingM.Font=Enum.Font.GothamBold
pingM.TextXAlignment=Enum.TextXAlignment.Right
pingM.ZIndex=105

local timeM=Instance.new("TextLabel",statCard)
timeM.Size=UDim2.new(1,-24,0,20)
timeM.Position=UDim2.new(0,12,0,34)
timeM.BackgroundTransparency=1
timeM.Text="Session: 00:00:00"
timeM.TextSize=11
timeM.Font=Enum.Font.GothamBold
timeM.TextXAlignment=Enum.TextXAlignment.Left
timeM.ZIndex=105

local sStart=tick()
task.spawn(function()
    while statCard and statCard.Parent do
        task.wait(1)
        if ML and ML.Text then
            local fp,pg=ML.Text:match("FPS (%d+) | (%d+)ms")
            if fp then fpsM.Text="FPS: "..fp end
            if pg then pingM.Text="PING: "..pg.."ms" end
        end
        local hue=(tick()*0.3)%1
        local rc=Color3.fromHSV(hue,1,1)
        fpsM.TextColor3=rc
        pingM.TextColor3=rc
        timeM.TextColor3=rc
        local el=math.floor(tick()-sStart)
        timeM.Text=string.format("Session: %02d:%02d:%02d",math.floor(el/3600),math.floor((el%3600)/60),el%60)
    end
end)

local ConfigTab=CreateTab("Config","⚙")
addSection(ConfigTab,"Discord Webhook")

local webhookOn=false
local webhookURL=""
local whFrame=Instance.new("Frame",ConfigTab)
whFrame.Size=UDim2.new(1,-8,0,60)
whFrame.BackgroundColor3=Themes[Config.Theme].Element
whFrame.BackgroundTransparency=0.15
whFrame.ZIndex=104
cor(whFrame,8)
str(whFrame,Themes[Config.Theme].Border,1,0.4)

local whBox=Instance.new("TextBox",whFrame)
whBox.Size=UDim2.new(1,-16,0,26)
whBox.Position=UDim2.new(0,8,0,8)
whBox.BackgroundColor3=Themes[Config.Theme].TopBar
whBox.Text=""
whBox.PlaceholderText="Paste Discord webhook URL"
whBox.PlaceholderColor3=Themes[Config.Theme].TextDim
whBox.TextColor3=Themes[Config.Theme].Text
whBox.TextSize=10
whBox.Font=Enum.Font.Gotham
whBox.ClearTextOnFocus=false
whBox.ZIndex=105
cor(whBox,4)
str(whBox,Themes[Config.Theme].Border,1,0.4)
whBox:GetPropertyChangedSignal("Text"):Connect(function() webhookURL=whBox.Text end)

local hint=Instance.new("TextLabel",whFrame)
hint.Size=UDim2.new(1,-16,0,16)
hint.Position=UDim2.new(0,8,0,38)
hint.BackgroundTransparency=1
hint.Text="Sends: session start, close"
hint.TextColor3=Themes[Config.Theme].TextDim
hint.TextSize=9
hint.Font=Enum.Font.Gotham
hint.TextXAlignment=Enum.TextXAlignment.Left
hint.ZIndex=105

local function fireWebhook(msg)
    if not webhookOn or webhookURL=="" then return end
    task.spawn(function()
        pcall(function()
            HS:PostAsync(webhookURL,HS:JSONEncode({content="Latina Hub | "..msg,username="Latina Notifier"}),Enum.HttpContentType.ApplicationJson)
        end)
    end)
end

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

addSection(ConfigTab,"Theme")
for tn,td in pairs(Themes) do
    AddButtonToPage(ConfigTab,"Theme: "..tn,function()
        ApplyTheme(td,tn)
        showN("Theme: "..tn,"success")
    end,{icon="🎨"})
end

addSection(ConfigTab,"UI Settings")
AddButtonToPage(ConfigTab,"Reset All Toggles",function()
    local allToggles={"megaSpeed","megaJP","megaAntiRag","megaAntiKB","megaAntiTrap","megaGod","megaGravity","megaTrail","megaAura","megaRainbow","infJump","noclip","speed","fpsBoost","nameESP","eggESP","clickTP","invisible","clock","coords","rainbowChar","entCount","crosshair","sessionTimer","pjn"}
    for _,k in ipairs(allToggles) do Config.Toggles[k]=false end
    svC(Config)
    local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed=16 h.JumpPower=50 end
    workspace.Gravity=196.2
    showN("All toggles reset","info")
end,{icon="🔄"})

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

local KL=createCollapsible(ET,"KEYLESS HUBS","28 hubs","🔓",true,ACG)
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
{Name="GLINT ANTI-CHASE",Icon="🏃",Link='loadstring(game:HttpGet("https://flowauth.net/v1/loaders/6824c37a4078d7d311677732e231edaa.lua"))()'},
{Name="NEVA HUB",Icon="🌑",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/VEZ2/NEVAHUB/main/2"))()'},
{Name="JANE HUB",Icon="🧞",Link='loadstring(game:HttpGet("https://flowauth.net/v1/loaders/b88a6143b351d79f4c5a108ec33b5a2c.lua"))()'},
{Name="PULSE HUB",Icon="💉",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/PulseZax/Loader/refs/heads/main/.lua"))()'},
{Name="CHILLI HUB",Icon="🌶️",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()'},
{Name="RONNIE HUB",Icon="👯‍♂️",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/elonmod/skibidi/refs/heads/main/Ronneihub-keyless.lua"))()'},
{Name="HORIZON",Icon="🌅",Link='script_key="Trial"; loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/6582551b42d21c6b7eb55f1d76d8d50ce53cb35592093d6615b5e83437594dc0.lua"))()'}
}

local KeyReqScripts={
{Name="OMG HUB",Icon="💎",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()'},
{Name="FLOW HUB",Icon="🌊",Link='loadstring(game:HttpGet("https://flowauth.net/v1/loaders/29f4f4b924aff467652814456286bb05.lua"))()'},
{Name="FYY COMMUNITY",Icon="🎭",Link='loadstring(game:HttpGet("https://FyyCommunity.com"))()'},
{Name="CLOVER HUB",Icon="🍀",Link='loadstring(game:HttpGet("https://cloverhub.app/clover.lua"))()'},
{Name="ZEROIN HUB",Icon="0️⃣",Link='loadstring(game:HttpGet("https://zeroinhub.com/api/script"))()'},
{Name="BIGFROOT",Icon="🌱",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))()'},
{Name="AJJANS",Icon="🎪",Link='loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/359e97f8618e9008afe5f496184ebb7c.lua"))()'},
{Name="HIP HUB",Icon="🦵",Link='loadstring(game:HttpGet("https://hiphub.cloud/api/script-roblox/loader"))()'},
{Name="NIGHT HUB",Icon="🌃",Link='loadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/StealEggOnly.luau"))()'},
{Name="Premium source hub",Icon="📙",Link='loadstring(game:HttpGet("https://api.obscuravm.com/scripts/7274301667433708967"))()'}
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
    end,{exec=true,icon=sd.Icon})
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
            task.spawn(function()
                local h=math.random()
                while BD2 and BD2.Parent do
                    h=(h+0.008)%1
                    local c=Color3.fromHSV(h,1,1)
                    BD2.TextColor3=c
                    BD2.BackgroundColor3=c
                    task.wait(0.03)
                end
            end)
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

local VT=CreateTab("Visuals","👁️")
addSection(VT,"Players")
local ES={Names=false,Eggs=false}
local EC={Names={}}
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
    for _,d in ipairs(o:GetDescendants()) do
        local ln=d.Name:lower()
        if not p then
            if d:IsA("StringValue") and (ln:find("pet") or ln:find("brainrot") or ln:find("content") or ln:find("name") or ln:find("type")) then
                if d.Value and #d.Value>1 then p=d.Value end
            elseif d:IsA("ObjectValue") and (ln:find("pet") or ln:find("brainrot")) then
                if d.Value then p=d.Value.Name end
            end
        end
        if not ps then
            if d:IsA("NumberValue") and (ln:find("cash") or ln:find("income") or ln:find("per") or ln:find("second") or ln:find("value")) then
                ps=d.Value
            end
        end
        if p and ps then break end
    end
    if not p or not ps then
        for _,d in ipairs(o:GetDescendants()) do
            if d:IsA("TextLabel") and d.Text and #d.Text>0 then
                local t=d.Text
                local m=t:match("[Pp]et[:%s]*([%w%s%-]+)")
                if m and not p then p=m:gsub("[%s$]+$","") end
                if not ps then
                    local vl,sf=t:match("%$?([%d%.]+)([BbMmKkTtQq][Aa]?)")
                    if vl then
                        local n=tonumber(vl)
                        sf=sf:upper()
                        if sf:find("Q") then n=n*1e15
                        elseif sf:find("T") then n=n*1e12
                        elseif sf:find("B") then n=n*1e9
                        elseif sf:find("M") then n=n*1e6
                        elseif sf:find("K") then n=n*1e3 end
                        ps=n
                    end
                end
            end
        end
    end
    if not p then
        for _,d in ipairs(o:GetChildren()) do
            if d:IsA("Model") and #d.Name>2 and not d.Name:lower():find("egg") then
                p=d.Name
                break
            end
        end
    end
    return p,ps
end

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
                    task.spawn(function()
                        while bb and bb.Parent do
                            task.wait(2)
                            local p2,s2=gEI(o)
                            pl.Text="Pet: "..(p2 or "???")
                            sl.Text="$: "..(s2 and fN(s2) or "???")
                        end
                    end)
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

addSection(XT,"Emotes")
local EL3={
{Name="Wave",Icon="👋",ID="507770239"},
{Name="Dance",Icon="💃",ID="507771019"},
{Name="Dance 2",Icon="🕺",ID="507777826"},
{Name="Brazilian Dance",Icon="🇧🇷",ID="88211179137169"},
{Name="Laugh",Icon="😂",ID="507770818"},
{Name="Cheer",Icon="🎉",ID="507770677"},
{Name="Point",Icon="👉",ID="507770453"},
{Name="Salute",Icon="🫡",ID="6899082783"},
{Name="Facepalm",Icon="🤦",ID="6899093391"},
{Name="Shrug",Icon="🤷",ID="6899088466"},
{Name="Kick",Icon="🦵",ID="6899085906"}
}
local AET={}
local function pCE(aid)
    local ch=LP.Character
    if not ch then return end
    local h=ch:FindFirstChildOfClass("Humanoid")
    if not h then return end
    local LA=h:FindFirstChild("LatinaLocalAnimator")
    if not LA then LA=Instance.new("Animator") LA.Name="LatinaLocalAnimator" LA.Parent=h end
    for _,t in ipairs(AET) do pcall(function() t:Stop(0.2) end) end
    AET={}
    local an=Instance.new("Animation")
    an.AnimationId="rbxassetid://"..aid
    local tr=LA:LoadAnimation(an)
    tr.Priority=Enum.AnimationPriority.Action
    tr.Looped=false
    pcall(function() tr:Play(0.1) end)
    table.insert(AET,tr)
end
AddButtonToPage(XT,"❌ Stop Emote",function()
    for _,t in ipairs(AET) do pcall(function() t:Stop(0.2) end) end
    AET={}
    showN("Emote stopped","info")
end,{icon="⏹"})
for _,em in ipairs(EL3) do
    AddButtonToPage(XT,em.Name,function()
        pCE(em.ID)
        showN("Emote: "..em.Name,"success")
    end,{icon=em.Icon})
                end
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
end,{toggle=true,key="pjn",icon="🔔"})

AddButtonToPage(UT,"Copy Player List",function()
    local n={}
    for _,pl in ipairs(P:GetPlayers()) do table.insert(n,pl.Name..(pl==LP and " (you)" or "")) end
    pcall(function()
        setclipboard(table.concat(n,"\n"))
        showN("Copied "..#n.." names","success")
    end)
end,{icon="📋"})

local PTB=CreateTab("Players","👥")
addSection(PTB,"Live Player List")
local PLF=Instance.new("ScrollingFrame",PTB)
PLF.Size=UDim2.new(1,-8,0,180)
PLF.BackgroundColor3=Themes[Config.Theme].Element
PLF.BackgroundTransparency=0.15
PLF.BorderSizePixel=0
PLF.CanvasSize=UDim2.new(0,0,0,0)
PLF.ScrollBarThickness=3
PLF.ScrollBarImageColor3=ACC
PLF.ZIndex=104
cor(PLF,8)
str(PLF,Themes[Config.Theme].Border,1,0.4)
local PLL=Instance.new("UIListLayout",PLF)
PLL.Padding=UDim.new(0,4)
PLL.SortOrder=Enum.SortOrder.LayoutOrder

local function rPL()
    for _,c in ipairs(PLF:GetChildren()) do
        if c:IsA("TextLabel") or c:IsA("Frame") then c:Destroy() end
    end
    local pls=P:GetPlayers()
    table.sort(pls,function(a,b) return a.Name<b.Name end)
    for _,pl in ipairs(pls) do
        local r=Instance.new("Frame",PLF)
        r.Size=UDim2.new(1,-8,0,28)
        r.BackgroundColor3=Themes[Config.Theme].TopBar
        r.BackgroundTransparency=0.3
        r.BorderSizePixel=0
        r.ZIndex=105
        cor(r,6)
        local iL=pl==LP
        local nL=Instance.new("TextLabel",r)
        nL.Size=UDim2.new(1,-90,1,0)
        nL.Position=UDim2.new(0,10,0,0)
        nL.BackgroundTransparency=1
        nL.Text=(iL and "⭐ " or "👤 ")..pl.Name
        nL.TextColor3=iL and ACC or Themes[Config.Theme].Text
        nL.TextSize=11
        nL.Font=Enum.Font.GothamBold
        nL.TextXAlignment=Enum.TextXAlignment.Left
        nL.TextTruncate=Enum.TextTruncate.AtEnd
        nL.ZIndex=106
        local iL2=Instance.new("TextLabel",r)
        iL2.Size=UDim2.new(0,80,1,0)
        iL2.Position=UDim2.new(1,-85,0,0)
        iL2.BackgroundTransparency=1
        local hp="?"
        if pl.Character then
            local h=pl.Character:FindFirstChildOfClass("Humanoid")
            if h then hp=math.floor(h.Health) end
        end
        iL2.Text="HP: "..hp
        iL2.TextColor3=Themes[Config.Theme].TextDim
        iL2.TextSize=9
        iL2.Font=Enum.Font.Gotham
        iL2.TextXAlignment=Enum.TextXAlignment.Right
        iL2.ZIndex=106
    end
    PLF.CanvasSize=UDim2.new(0,0,0,PLL.AbsoluteContentSize.Y+8)
end
task.spawn(function()
    while PLF and PLF.Parent do
        rPL()
        task.wait(2)
    end
end)
AddButtonToPage(PTB,"Refresh Now",function() rPL() showN("Refreshed","success") end,{icon="🔄"})

local STB=CreateTab("Sounds","🎵")
addSection(STB,"Custom Music")
local CSnd=nil
local AF=Instance.new("Frame",STB)
AF.Size=UDim2.new(1,-8,0,90)
AF.BackgroundColor3=Themes[Config.Theme].Element
AF.BackgroundTransparency=0.15
AF.ZIndex=104
cor(AF,8)
str(AF,Themes[Config.Theme].Border,1,0.4)
local SI2=Instance.new("TextBox",AF)
SI2.Size=UDim2.new(1,-24,0,26)
SI2.Position=UDim2.new(0,12,0,26)
SI2.BackgroundColor3=Themes[Config.Theme].TopBar
SI2.BorderSizePixel=0
SI2.Text=""
SI2.PlaceholderText="Roblox audio ID"
SI2.PlaceholderColor3=Themes[Config.Theme].TextDim
SI2.TextColor3=Themes[Config.Theme].Text
SI2.TextSize=10
SI2.Font=Enum.Font.Gotham
SI2.ClearTextOnFocus=false
SI2.ZIndex=105
cor(SI2,6)
str(SI2,Themes[Config.Theme].Border,1,0.4)
addSection(STB,"Controls")
AddButtonToPage(STB,"Play",function()
    local id=SI2.Text:gsub("%D","")
    if id=="" then showN("Walang ID","error") return end
    pcall(function()
        if CSnd then CSnd:Destroy() end
        CSnd=Instance.new("Sound",SG)
        CSnd.SoundId="rbxassetid://"..id
        CSnd.Volume=0.5
        CSnd.Looped=true
        CSnd:Play()
        showN("Playing: "..id,"success")
    end)
end,{icon="▶️"})
AddButtonToPage(STB,"Stop",function()
    if CSnd then CSnd:Stop() CSnd:Destroy() CSnd=nil showN("Stopped","info") end
end,{icon="⏹"})
                local SVT=CreateTab("Server","🌐")
addSection(SVT,"Server Actions")
AddButtonToPage(SVT,"Rejoin Current",function()
    TPS:Teleport(game.PlaceId,LP)
end,{exec=true,icon="🔄"})
AddButtonToPage(SVT,"Hop New Server",function()
    local ok=pcall(function()
        local api="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
        local list=HS:JSONDecode(game:HttpGet(api))
        if list and list.data then
            for _,s in ipairs(list.data) do
                if s.playing~=s.maxPlayers and s.id~=game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId,s.id,LP)
                    return
                end
            end
        end
    end)
    if not ok then showN("Hop failed","error") end
end,{exec=true,icon="🔀"})

local THT=CreateTab("Themes","🎨")
addSection(THT,"Color Themes")
for tn,td in pairs(Themes) do
    AddButtonToPage(THT,tn,function()
        ApplyTheme(td,tn)
        showN("Theme: "..tn,"success")
    end,{icon="🎨"})
end

local DCT=CreateTab("Discord","💬")
addSection(DCT,"Community Links")
local DLs={
{Name="Main Discord",Link="https://discord.gg/qdCycSk4K",Icon="💬"},
{Name="Backup Discord",Link="https://discord.gg/SyXbWjemT",Icon="🔗"}
}
for _,dl in ipairs(DLs) do
    AddButtonToPage(DCT,"Copy "..dl.Name,function()
        pcall(function()
            setclipboard(dl.Link)
            showN(dl.Name.." copied!","success")
        end)
    end,{icon=dl.Icon})
end

local OT=CreateTab("Owner","👑")
addSection(OT,"About")
local OC=Instance.new("Frame",OT)
OC.Size=UDim2.new(1,-8,0,80)
OC.BackgroundColor3=Themes[Config.Theme].Element
OC.BackgroundTransparency=0.15
OC.ZIndex=104
cor(OC,9)
str(OC,ACC,1.5,0.4)
gr(OC,Themes[Config.Theme].Element,Themes[Config.Theme].TopBar)
local CR=Instance.new("TextLabel",OC)
CR.Size=UDim2.new(0,36,0,36)
CR.Position=UDim2.new(0,12,0,12)
CR.BackgroundColor3=ACC
CR.BackgroundTransparency=0.85
CR.Text="👑"
CR.TextSize=18
CR.ZIndex=105
cor(CR,9)
local OT2=Instance.new("TextLabel",OC)
OT2.Size=UDim2.new(1,-60,0,18)
OT2.Position=UDim2.new(0,56,0,18)
OT2.BackgroundTransparency=1
OT2.Text="OWNER"
OT2.TextColor3=Themes[Config.Theme].TextDim
OT2.TextSize=10
OT2.Font=Enum.Font.GothamBold
OT2.TextXAlignment=Enum.TextXAlignment.Left
OT2.ZIndex=105
local ON2=Instance.new("TextLabel",OC)
ON2.Size=UDim2.new(1,-60,0,22)
ON2.Position=UDim2.new(0,56,0,34)
ON2.BackgroundTransparency=1
ON2.Text="ANONYMOUS"
ON2.TextColor3=Themes[Config.Theme].Text
ON2.TextSize=15
ON2.Font=Enum.Font.GothamBold
ON2.TextXAlignment=Enum.TextXAlignment.Left
ON2.ZIndex=105
local TG3=Instance.new("TextLabel",OC)
TG3.Size=UDim2.new(1,-20,0,14)
TG3.Position=UDim2.new(0,12,1,-18)
TG3.BackgroundTransparency=1
TG3.Text="LATINA HUB  ·  V1 NEW RELEASE"
TG3.TextColor3=Themes[Config.Theme].TextDim
TG3.TextSize=9
TG3.Font=Enum.Font.GothamMedium
TG3.TextXAlignment=Enum.TextXAlignment.Left
TG3.ZIndex=105

if Themes[Config.Theme] then ApplyTheme(Themes[Config.Theme],nil) end

local MegaState={
    AntiRag=false,AntiKnockback=false,AntiTrap=false,
    GodMode=false,SpeedSlider=false,SpeedVal=32,
    JumpPower=false,JumpPowerVal=50,
    Gravity=false,GravityVal=196.2,
    FunTrail=false,FunAura=false,Rainbow=false,
    WebhookOn=false,WebhookURL="",
    ConfirmClose=true,
    Connections={},Threads={},
    SavedGravity=workspace.Gravity,
}
local function killThread(t) if t then pcall(function() task.cancel(t) end) end end
local function disconnectAll()
    for _,c in ipairs(MegaState.Connections) do pcall(function() c:Disconnect() end) end
    MegaState.Connections={}
                end
                addSection(PT,"Speed Control (1-1000)")
local speedFrame=Instance.new("Frame",PT)
speedFrame.Size=UDim2.new(1,-8,0,80)
speedFrame.BackgroundColor3=Themes[Config.Theme].Element
speedFrame.BackgroundTransparency=0.15
speedFrame.ZIndex=104
cor(speedFrame,8)
str(speedFrame,Themes[Config.Theme].Border,1,0.4)
local speedLbl=Instance.new("TextLabel",speedFrame)
speedLbl.Size=UDim2.new(1,-16,0,20)
speedLbl.Position=UDim2.new(0,8,0,4)
speedLbl.BackgroundTransparency=1
speedLbl.Text="Speed: 32"
speedLbl.TextColor3=Themes[Config.Theme].Text
speedLbl.TextSize=12
speedLbl.Font=Enum.Font.GothamBold
speedLbl.TextXAlignment=Enum.TextXAlignment.Left
speedLbl.ZIndex=105
local speedBar=Instance.new("TextButton",speedFrame)
speedBar.Size=UDim2.new(1,-16,0,24)
speedBar.Position=UDim2.new(0,8,0,30)
speedBar.BackgroundColor3=Themes[Config.Theme].TopBar
speedBar.Text=""
speedBar.AutoButtonColor=false
speedBar.ZIndex=105
cor(speedBar,4)
local speedFill=Instance.new("Frame",speedBar)
speedFill.Size=UDim2.new(0.031,0,1,0)
speedFill.BackgroundColor3=ACC
speedFill.BorderSizePixel=0
speedFill.ZIndex=106
cor(speedFill,4)
local speedHint=Instance.new("TextLabel",speedFrame)
speedHint.Size=UDim2.new(1,-16,0,12)
speedHint.Position=UDim2.new(0,8,0,58)
speedHint.BackgroundTransparency=1
speedHint.Text="Drag: min 1 / max 1000"
speedHint.TextColor3=Themes[Config.Theme].TextDim
speedHint.TextSize=8
speedHint.Font=Enum.Font.Gotham
speedHint.TextXAlignment=Enum.TextXAlignment.Left
speedHint.ZIndex=105
local MegaSpeedVal=32
local speedDragging=false
local function updateSpeed(input)
    local rel=input.Position.X-speedBar.AbsolutePosition.X
    local pct=math.clamp(rel/math.max(speedBar.AbsoluteSize.X,1),0,1)
    MegaSpeedVal=math.floor(1+pct*999)
    speedFill.Size=UDim2.new(pct,0,1,0)
    speedLbl.Text="Speed: "..MegaSpeedVal
end
speedBar.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        speedDragging=true
        updateSpeed(input)
    end
end)
UIS.InputChanged:Connect(function(input)
    if speedDragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
        updateSpeed(input)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        speedDragging=false
    end
end)
local speedThread
AddButtonToPage(PT,"Custom Speed Slider",function(s)
    if s then
        if speedThread then task.cancel(speedThread) end
        speedThread=task.spawn(function()
            while true do
                task.wait(0.1)
                local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                if h and h.WalkSpeed~=MegaSpeedVal then h.WalkSpeed=MegaSpeedVal end
            end
        end)
        showN("Speed ON: "..MegaSpeedVal,"success")
    else
        if speedThread then task.cancel(speedThread) speedThread=nil end
        local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed=16 end
        showN("Speed OFF","info")
    end
end,{toggle=true,key="megaSpeed",icon="⚡"})

addSection(PT,"Jump Power (1-500)")
local jpFrame=Instance.new("Frame",PT)
jpFrame.Size=UDim2.new(1,-8,0,60)
jpFrame.BackgroundColor3=Themes[Config.Theme].Element
jpFrame.BackgroundTransparency=0.15
jpFrame.ZIndex=104
cor(jpFrame,8)
str(jpFrame,Themes[Config.Theme].Border,1,0.4)
local jpLbl=Instance.new("TextLabel",jpFrame)
jpLbl.Size=UDim2.new(1,-16,0,20)
jpLbl.Position=UDim2.new(0,8,0,4)
jpLbl.BackgroundTransparency=1
jpLbl.Text="Jump: 50"
jpLbl.TextColor3=Themes[Config.Theme].Text
jpLbl.TextSize=12
jpLbl.Font=Enum.Font.GothamBold
jpLbl.TextXAlignment=Enum.TextXAlignment.Left
jpLbl.ZIndex=105
local jpBar=Instance.new("TextButton",jpFrame)
jpBar.Size=UDim2.new(1,-16,0,24)
jpBar.Position=UDim2.new(0,8,0,30)
jpBar.BackgroundColor3=Themes[Config.Theme].TopBar
jpBar.Text=""
jpBar.AutoButtonColor=false
jpBar.ZIndex=105
cor(jpBar,4)
local jpFill=Instance.new("Frame",jpBar)
jpFill.Size=UDim2.new(0.1,0,1,0)
jpFill.BackgroundColor3=ACC
jpFill.BorderSizePixel=0
jpFill.ZIndex=106
cor(jpFill,4)
local MegaJumpVal=50
local jpDragging=false
local function updateJP(input)
    local rel=input.Position.X-jpBar.AbsolutePosition.X
    local pct=math.clamp(rel/math.max(jpBar.AbsoluteSize.X,1),0,1)
    MegaJumpVal=math.floor(1+pct*499)
    jpFill.Size=UDim2.new(pct,0,1,0)
    jpLbl.Text="Jump: "..MegaJumpVal
end
jpBar.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        jpDragging=true
        updateJP(input)
    end
end)
UIS.InputChanged:Connect(function(input)
    if jpDragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
        updateJP(input)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        jpDragging=false
    end
end)
local jpThread
AddButtonToPage(PT,"Custom Jump Power",function(s)
    if s then
        if jpThread then task.cancel(jpThread) end
        jpThread=task.spawn(function()
            while true do
                task.wait(0.1)
                local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                if h then h.UseJumpPower=true h.JumpPower=MegaJumpVal end
            end
        end)
        showN("Jump ON: "..MegaJumpVal,"success")
    else
        if jpThread then task.cancel(jpThread) jpThread=nil end
        local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.JumpPower=50 end
        showN("Jump OFF","info")
    end
end,{toggle=true,key="megaJP",icon="🦘"})
                addSection(PT,"Protection")
local antiRagConn,antiKbConn,antiTrapConn,godConn
AddButtonToPage(PT,"Anti-Ragdoll / Anti-Stun",function(s)
    if s then
        if antiRagConn then antiRagConn:Disconnect() end
        antiRagConn=RS.Heartbeat:Connect(function()
            local ch=LP.Character
            if not ch then return end
            local h=ch:FindFirstChildOfClass("Humanoid")
            if not h then return end
            if h.PlatformStand then h.PlatformStand=false end
            if h.Sit then h.Sit=false end
            local st=h:GetState()
            if st==Enum.HumanoidStateType.Ragdoll or st==Enum.HumanoidStateType.FallingDown or st==Enum.HumanoidStateType.Physics then
                h:ChangeState(Enum.HumanoidStateType.Running)
            end
            local root=ch:FindFirstChild("HumanoidRootPart")
            if root then
                for _,v in ipairs(root:GetChildren()) do
                    if v:IsA("BallSocketConstraint") or v:IsA("RagdollConstraint") then v:Destroy() end
                end
            end
        end)
        showN("Anti-Ragdoll ON","success")
    else
        if antiRagConn then antiRagConn:Disconnect() antiRagConn=nil end
        showN("Anti-Ragdoll OFF","info")
    end
end,{toggle=true,key="megaAntiRag",icon="🛡"})

AddButtonToPage(PT,"Anti-Knockback",function(s)
    if s then
        if antiKbConn then antiKbConn:Disconnect() end
        antiKbConn=RS.Heartbeat:Connect(function()
            local ch=LP.Character
            if not ch then return end
            local hrp=ch:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local hum=ch:FindFirstChildOfClass("Humanoid")
            local moveDir=hum and hum.MoveDirection or Vector3.zero
            local vel=hrp.AssemblyLinearVelocity
            if moveDir.Magnitude<0.05 then
                hrp.AssemblyLinearVelocity=Vector3.new(0,vel.Y,0)
            end
            hrp.AssemblyAngularVelocity=Vector3.zero
            for _,v in ipairs(hrp:GetChildren()) do
                if v:IsA("BodyVelocity") or v:IsA("BodyThrust") then v:Destroy() end
            end
        end)
        showN("Anti-Knockback ON","success")
    else
        if antiKbConn then antiKbConn:Disconnect() antiKbConn=nil end
        showN("Anti-Knockback OFF","info")
    end
end,{toggle=true,key="megaAntiKB",icon="🚫"})

AddButtonToPage(PT,"Anti-Trap",function(s)
    if s then
        if antiTrapConn then antiTrapConn:Disconnect() end
        antiTrapConn=RS.Heartbeat:Connect(function()
            local ch=LP.Character
            if not ch then return end
            local hrp=ch:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            for _,o in ipairs(workspace:GetChildren()) do
                if o:IsA("BasePart") and not o:IsDescendantOf(ch) then
                    local d=(o.Position-hrp.Position).Magnitude
                    if d<6 and o.Anchored and o.CanCollide then
                        local sz=o.Size
                        if sz.X<20 and sz.Y<20 and sz.Z<20 then o.CanCollide=false end
                    end
                end
            end
            for _,cc in ipairs(hrp:GetChildren()) do
                if cc:IsA("WeldConstraint") then
                    if (cc.Part0 and not cc.Part0:IsDescendantOf(ch)) or (cc.Part1 and not cc.Part1:IsDescendantOf(ch)) then cc:Destroy() end
                end
            end
        end)
        showN("Anti-Trap ON","success")
    else
        if antiTrapConn then antiTrapConn:Disconnect() antiTrapConn=nil end
        showN("Anti-Trap OFF","info")
    end
end,{toggle=true,key="megaAntiTrap",icon="🕸"})

AddButtonToPage(PT,"God Mode (client)",function(s)
    if s then
        if godConn then godConn:Disconnect() end
        godConn=RS.Heartbeat:Connect(function()
            local ch=LP.Character
            if not ch then return end
            local h=ch:FindFirstChildOfClass("Humanoid")
            if not h then return end
            if h.Health<h.MaxHealth then h.Health=h.MaxHealth end
            h.BreakJointsOnDeath=false
            if not ch:FindFirstChildOfClass("ForceField") then
                local ff=Instance.new("ForceField",ch)
                ff.Visible=false
            end
        end)
        showN("God Mode ON","success")
    else
        if godConn then godConn:Disconnect() godConn=nil end
        showN("God Mode OFF","info")
    end
end,{toggle=true,key="megaGod",icon="👼"})

addSection(PT,"Gravity (0-1000)")
local gvFrame=Instance.new("Frame",PT)
gvFrame.Size=UDim2.new(1,-8,0,60)
gvFrame.BackgroundColor3=Themes[Config.Theme].Element
gvFrame.BackgroundTransparency=0.15
gvFrame.ZIndex=104
cor(gvFrame,8)
str(gvFrame,Themes[Config.Theme].Border,1,0.4)
local gvLbl=Instance.new("TextLabel",gvFrame)
gvLbl.Size=UDim2.new(1,-16,0,20)
gvLbl.Position=UDim2.new(0,8,0,4)
gvLbl.BackgroundTransparency=1
gvLbl.Text="Gravity: 196"
gvLbl.TextColor3=Themes[Config.Theme].Text
gvLbl.TextSize=12
gvLbl.Font=Enum.Font.GothamBold
gvLbl.TextXAlignment=Enum.TextXAlignment.Left
gvLbl.ZIndex=105
local gvBar=Instance.new("TextButton",gvFrame)
gvBar.Size=UDim2.new(1,-16,0,24)
gvBar.Position=UDim2.new(0,8,0,30)
gvBar.BackgroundColor3=Themes[Config.Theme].TopBar
gvBar.Text=""
gvBar.AutoButtonColor=false
gvBar.ZIndex=105
cor(gvBar,4)
local gvFill=Instance.new("Frame",gvBar)
gvFill.Size=UDim2.new(0.196,0,1,0)
gvFill.BackgroundColor3=ACC
gvFill.BorderSizePixel=0
gvFill.ZIndex=106
cor(gvFill,4)
local MegaGravVal=196
local savedGrav=workspace.Gravity
local gvDragging=false
local function updateGV(input)
    local rel=input.Position.X-gvBar.AbsolutePosition.X
    local pct=math.clamp(rel/math.max(gvBar.AbsoluteSize.X,1),0,1)
    MegaGravVal=math.floor(pct*1000)
    gvFill.Size=UDim2.new(pct,0,1,0)
    gvLbl.Text="Gravity: "..MegaGravVal
end
gvBar.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        gvDragging=true
        updateGV(input)
    end
end)
UIS.InputChanged:Connect(function(input)
    if gvDragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
        updateGV(input)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        gvDragging=false
    end
end)
local gravConn
AddButtonToPage(PT,"Custom Gravity",function(s)
    if s then
        savedGrav=workspace.Gravity
        if gravConn then gravConn:Disconnect() end
        gravConn=RS.Heartbeat:Connect(function()
            workspace.Gravity=MegaGravVal
        end)
        showN("Gravity ON: "..MegaGravVal,"success")
    else
        workspace.Gravity=savedGrav
        if gravConn then gravConn:Disconnect() gravConn=nil end
        showN("Gravity OFF","info")
    end
end,{toggle=true,key="megaGravity",icon="🌍"})
                addSection(XT,"Mega Fun")
local trailConn
AddButtonToPage(XT,"Rainbow Trail",function(s)
    if s then
        if trailConn then trailConn:Disconnect() end
        trailConn=RS.Heartbeat:Connect(function()
            local ch=LP.Character
            if not ch then return end
            local hrp=ch:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local trail=hrp:FindFirstChild("MegaTrail")
            if not trail then
                trail=Instance.new("Trail",hrp)
                trail.Name="MegaTrail"
                trail.Lifetime=1
                trail.Transparency=NumberSequence.new({
                    NumberSequenceKeypoint.new(0,0),
                    NumberSequenceKeypoint.new(1,1),
                })
                trail.WidthScale=NumberSequence.new({
                    NumberSequenceKeypoint.new(0,1),
                    NumberSequenceKeypoint.new(1,0),
                })
                local a0=Instance.new("Attachment",hrp)
                a0.Name="MegaTrail0"
                a0.Position=Vector3.new(0,-1.5,0)
                local a1=Instance.new("Attachment",hrp)
                a1.Name="MegaTrail1"
                a1.Position=Vector3.new(0,1.5,0)
                trail.Attachment0=a0
                trail.Attachment1=a1
            end
            local hue=(tick()*0.5)%1
            trail.Color=ColorSequence.new(Color3.fromHSV(hue,1,1))
        end)
        showN("Rainbow Trail ON","success")
    else
        if trailConn then trailConn:Disconnect() trailConn=nil end
        local ch=LP.Character
        if ch then
            local hrp=ch:FindFirstChild("HumanoidRootPart")
            if hrp then
                local t=hrp:FindFirstChild("MegaTrail")
                if t then t:Destroy() end
                for _,a in ipairs(hrp:GetChildren()) do
                    if a.Name:find("MegaTrail") then a:Destroy() end
                end
            end
        end
        showN("Rainbow Trail OFF","info")
    end
end,{toggle=true,key="megaTrail",icon="🌈"})

local auraThread
AddButtonToPage(XT,"Particle Aura",function(s)
    if s then
        if auraThread then task.cancel(auraThread) end
        auraThread=task.spawn(function()
            while true do
                task.wait(0.5)
                local ch=LP.Character
                if ch then
                    local hrp=ch:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local emitter=hrp:FindFirstChild("MegaAura")
                        if not emitter then
                            emitter=Instance.new("ParticleEmitter",hrp)
                            emitter.Name="MegaAura"
                            emitter.Rate=30
                            emitter.Lifetime=NumberRange.new(1,2)
                            emitter.Speed=NumberRange.new(2,5)
                            emitter.SpreadAngle=Vector2.new(180,180)
                            emitter.Size=NumberSequence.new({
                                NumberSequenceKeypoint.new(0,0.5),
                                NumberSequenceKeypoint.new(1,0),
                            })
                            emitter.Texture="rbxasset://textures/particles/sparkles_main.dds"
                            emitter.LightEmission=1
                        end
                        local hue=(tick()*0.7)%1
                        emitter.Color=ColorSequence.new(Color3.fromHSV(hue,1,1))
                    end
                end
            end
        end)
        showN("Particle Aura ON","success")
    else
        if auraThread then task.cancel(auraThread) auraThread=nil end
        local ch=LP.Character
        if ch then
            local hrp=ch:FindFirstChild("HumanoidRootPart")
            if hrp then
                local e=hrp:FindFirstChild("MegaAura")
                if e then e:Destroy() end
            end
        end
        showN("Particle Aura OFF","info")
    end
end,{toggle=true,key="megaAura",icon="✨"})

local rainbowConn
AddButtonToPage(XT,"Rainbow Character (Mega)",function(s)
    if s then
        if rainbowConn then rainbowConn:Disconnect() end
        rainbowConn=RS.Heartbeat:Connect(function()
            local ch=LP.Character
            if not ch then return end
            local hue=(tick()*0.3)%1
            for _,p in ipairs(ch:GetDescendants()) do
                if p:IsA("BasePart") then
                    pcall(function() p.Color=Color3.fromHSV(hue,0.8,1) end)
                end
            end
        end)
        showN("Rainbow ON","success")
    else
        if rainbowConn then rainbowConn:Disconnect() rainbowConn=nil end
        showN("Rainbow OFF","info")
    end
end,{toggle=true,key="megaRainbow",icon="🌈"})
                if CB and MF and TW and SG then
    CB.Text="X"
    CB.MouseButton1Click:Connect(function()
        local cg=Instance.new("ScreenGui",PG)
        cg.Name="LatinaConfirm_"..tostring(math.random(1000,9999))
        cg.ResetOnSpawn=false
        cg.IgnoreGuiInset=true
        cg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
        local bd=Instance.new("Frame",cg)
        bd.Size=UDim2.new(1,0,1,0)
        bd.BackgroundColor3=Color3.new(0,0,0)
        bd.BackgroundTransparency=0.5
        bd.BorderSizePixel=0
        bd.ZIndex=1000
        local dlg=Instance.new("Frame",cg)
        dlg.Size=UDim2.new(0,280,0,160)
        dlg.Position=UDim2.new(0.5,-140,0.5,-80)
        dlg.BackgroundColor3=Themes[Config.Theme].MainBg
        dlg.BorderSizePixel=0
        dlg.ZIndex=1001
        cor(dlg,12)
        str(dlg,Themes[Config.Theme].Border,1.5,0.3)
        local ttl=Instance.new("TextLabel",dlg)
        ttl.Size=UDim2.new(1,0,0,36)
        ttl.BackgroundColor3=Themes[Config.Theme].TopBar
        ttl.Text="  Confirm Close"
        ttl.TextColor3=Themes[Config.Theme].Text
        ttl.TextSize=13
        ttl.Font=Enum.Font.GothamBold
        ttl.TextXAlignment=Enum.TextXAlignment.Left
        ttl.ZIndex=1002
        cor(ttl,12)
        local msgl=Instance.new("TextLabel",dlg)
        msgl.Size=UDim2.new(1,-20,0,55)
        msgl.Position=UDim2.new(0,10,0,44)
        msgl.BackgroundTransparency=1
        msgl.Text="Are you sure you want to close this window?"
        msgl.TextColor3=Themes[Config.Theme].Text
        msgl.TextSize=12
        msgl.Font=Enum.Font.GothamMedium
        msgl.TextWrapped=true
        msgl.TextXAlignment=Enum.TextXAlignment.Center
        msgl.ZIndex=1002
        local yb=Instance.new("TextButton",dlg)
        yb.Size=UDim2.new(0.45,-10,0,36)
        yb.Position=UDim2.new(0,10,1,-46)
        yb.BackgroundColor3=ACR
        yb.Text="YES"
        yb.TextColor3=Color3.fromRGB(255,255,255)
        yb.TextSize=13
        yb.Font=Enum.Font.GothamBold
        yb.ZIndex=1002
        cor(yb,8)
        local nb=Instance.new("TextButton",dlg)
        nb.Size=UDim2.new(0.45,-10,0,36)
        nb.Position=UDim2.new(0.55,0,1,-46)
        nb.BackgroundColor3=Themes[Config.Theme].Element
        nb.Text="NO"
        nb.TextColor3=Themes[Config.Theme].Text
        nb.TextSize=13
        nb.Font=Enum.Font.GothamBold
        nb.ZIndex=1002
        cor(nb,8)
        yb.MouseButton1Click:Connect(function()
            cg:Destroy()
            SG:Destroy()
            if BL then BL:Destroy() end
        end)
        nb.MouseButton1Click:Connect(function() cg:Destroy() end)
    end)
end

if ML then
    ML.Position=UDim2.new(1,-180,0,4)
    ML.Size=UDim2.new(0,130,0,12)
    ML.ZIndex=200
end
if DH then DH.ZIndex=200 end

if MF then
    local rh=Instance.new("TextButton",MF)
    rh.Size=UDim2.new(0,22,0,22)
    rh.Position=UDim2.new(1,-24,1,-24)
    rh.BackgroundColor3=Themes[Config.Theme].Element
    rh.BackgroundTransparency=0.3
    rh.Text="◢"
    rh.TextColor3=ACC
    rh.TextSize=14
    rh.Font=Enum.Font.GothamBold
    rh.AutoButtonColor=false
    rh.ZIndex=999
    cor(rh,4)
    str(rh,ACC,1,0.5)
    local resizing=false
    local startPos,startSize
    rh.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            resizing=true
            startPos=input.Position
            startSize=MF.Size
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if not resizing then return end
        if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
            local d=input.Position-startPos
            MF.Size=UDim2.new(0,math.max(280,startSize.X.Offset+d.X),0,math.max(220,startSize.Y.Offset+d.Y))
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            resizing=false
        end
    end)
end

if ATB and AP then
    for i,v in ipairs(ATB) do
        if v.TextLabel and v.TextLabel.Text=="Main" then
            local tab=table.remove(ATB,i)
            table.insert(ATB,1,tab)
            local page=table.remove(AP,i)
            table.insert(AP,1,page)
            tab.Button.LayoutOrder=-100
            break
        end
    end
    for i,v in ipairs(ATB) do
        if v.TextLabel and v.TextLabel.Text=="Config" then
            local tab=table.remove(ATB,i)
            table.insert(ATB,2,tab)
            local page=table.remove(AP,i)
            table.insert(AP,2,page)
            tab.Button.LayoutOrder=-99
            break
        end
    end
    for i,v in ipairs(ATB) do
        if v.Button and (v.Button.LayoutOrder==0 or v.Button.LayoutOrder==nil) then
            v.Button.LayoutOrder=i
        end
    end
end

task.spawn(function()
    pcall(function()
        IS:Play()
        local BD=Instance.new("Frame",SG)
        BD.Size=UDim2.new(1,0,1,0)
        BD.BackgroundColor3=Color3.new(0,0,0)
        BD.BackgroundTransparency=1
        BD.ZIndex=5000
        local CN=Instance.new("Frame",SG)
        CN.AnchorPoint=Vector2.new(0.5,0.5)
        CN.Position=UDim2.new(0.5,0,0.5,0)
        CN.Size=UDim2.new(0,160,0,160)
        CN.BackgroundTransparency=1
        CN.ZIndex=5001
        local IM=Instance.new("ImageLabel",CN)
        IM.Size=UDim2.new(1,0,1,0)
        IM.BackgroundTransparency=1
        IM.ImageTransparency=1
        IM.Image="rbxassetid://100104680190424"
        IM.ZIndex=5002
        cor(IM,36)
        local ST2=str(IM,ACC,3,1)
        local TT=Instance.new("TextLabel",CN)
        TT.Size=UDim2.new(1,0,0,30)
        TT.Position=UDim2.new(0,0,1,12)
        TT.BackgroundTransparency=1
        TT.Text="LATINA HUB"
        TT.TextColor3=Themes[Config.Theme].Text
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
        sB(8)
        showN("LATINA HUB V1 — Ready","success")
    end)
end)

LP.CharacterAdded:Connect(function()
    task.wait(1)
    pcall(function()
        local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed=16 h.JumpPower=50 end
        workspace.Gravity=196.2
    end)
end)

showN("Latina Hub loaded","success")
