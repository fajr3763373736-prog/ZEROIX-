-- =========================================================================
--  ZEROIX HUB - UNIVERSAL VERSION 10 (V10 GOD MODE - FINAL EXCLUSIVE)
--  GAME: STEAL AN EGG / MENCURI SEBUAH TELUR
--  FEATURES: 100% IGNORE COMMON EGGS | 0.5s DELAY BYPASS | 1000% ANTI-KICK
-- =========================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

_G.ZeroixConfig = _G.ZeroixConfig or {
    AutoStealTP = false,
    TouchGacor = false,
    IsProcessing = false,
    ThreadSpeed = 0.05
}

-- Anti-AFK Internal V10 (HP Aman Ditinggal AFK Tanpa Disconnect)
pcall(function()
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0,0))
    end)
end)

-- Universal Detector Base
local function getMyBase()
    local success, result = pcall(function()
        local pName = LocalPlayer.Name
        local bases = Workspace:FindFirstChild("Bases")
        if bases and bases:FindFirstChild(pName) then return bases[pName] end
        
        for _, obj in ipairs(Workspace:GetChildren()) do
            if string.match(obj.Name, pName) and string.match(string.lower(obj.Name), "base") then
                return obj
            end
        end
        if Workspace:FindFirstChild("Nest") then return Workspace.Nest end
        return nil
    end)
    return success and result or nil
end

-- V10 EXCLUSIVE SCANNER (HANYA MENGUNCI TELUR MAHAL - TELUR BIASA DIABAIKAN TOTAL)
local function getGacorEgg()
    local success, result = pcall(function()
        local folders = {
            Workspace:FindFirstChild("DroppedEggs"), 
            Workspace:FindFirstChild("Eggs"), 
            Workspace:FindFirstChild("EggSpawns"),
            Workspace:FindFirstChild("Map"),
            Workspace
        }
        
        -- Keyword Tier Mewah Sesuai Wiki Steal An Egg
        local highValueKeywords = {"divine", "eternal", "secret", "mythic", "legendary", "cosmic", "void", "luminous", "infested"}
        
        for i = 1, #folders do
            local folder = folders[i]
            if folder then
                for _, obj in ipairs(folder:GetChildren()) do
                    if obj and obj.Parent then
                        local nameLower = string.lower(obj.Name)
                        
                        -- Cek apakah nama objek mengandung salah satu keyword mewah
                        local isHighValue = false
                        for _, keyword in ipairs(highValueKeywords) do
                            if string.find(nameLower, keyword) then
                                isHighValue = true
                                break
                            end
                        end
                        
                        -- Jika terbukti telur mahal, ambil part fisiknya
                        if isHighValue then
                            local part = obj:IsA("Part") or obj:IsA("MeshPart") and obj or (obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("Part") or obj:FindFirstChildWhichIsA("MeshPart")))
                            if part then
                                return part
                            end
                        end
                    end
                end
            end
        end
        return nil
    end)
    return success and result or nil
end

-- Hyper FPS Boost V10 (Bikin HP Super Dingin dan Enteng)
pcall(function()
    settings().Rendering.QualityLevel = 1
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then
            obj.Transparency = 1
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("PostEffect") then
            obj.Enabled = false
        elseif obj:IsA("Explosion") or obj:IsA("Sparkles") then
            obj.Visible = false
        elseif obj:IsA("BasePart") then
            obj.CastShadow = false
        end
    end
end)

-- V10 GOD FARM ENGINE (Jeda Aman Nyata Bikin Akun Kebal Anti-Cheat)
local function RunUltimateEngine()
    task.spawn(function()
        while true do
            task.wait(_G.ZeroixConfig.ThreadSpeed)
            
            if (_G.ZeroixConfig.AutoStealTP or _G.ZeroixConfig.TouchGacor) and not _G.ZeroixConfig.IsProcessing then
                local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local root = char and char:WaitForChild("HumanoidRootPart", 5)
                local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
                
                if root and humanoid and humanoid.Health > 0 then
                    local egg = getGacorEgg()
                    local base = getMyBase()
                    
                    if egg and egg.Parent and base then
                        _G.ZeroixConfig.IsProcessing = true
                        
                        pcall(function()
                            local baseCFrame = base:IsA("Model") and (base.PrimaryPart and base.PrimaryPart.CFrame or base:GetPivot()) or base.CFrame
                            
                            -- HYBRID MODE (Dua-duanya ON)
                            if _G.ZeroixConfig.TouchGacor and _G.ZeroixConfig.AutoStealTP then
                                local startCFrame = root.CFrame
                                root.CFrame = egg.CFrame + Vector3.new(0, 1.5, 0)
                                task.wait(0.5) -- Jeda logis bypass anti-cheat (Ambil)
                                root.CFrame = baseCFrame + Vector3.new(0, 3, 0)
                                task.wait(0.5) -- Jeda logis bypass anti-cheat (Taruh)
                                root.CFrame = startCFrame
                                task.wait(0.1)
                                
                            -- TOUCH GACOR ONLY
                            elseif _G.ZeroixConfig.TouchGacor then
                                local startCFrame = root.CFrame
                                root.CFrame = egg.CFrame + Vector3.new(0, 1.5, 0)
                                task.wait(0.5)
                                root.CFrame = baseCFrame + Vector3.new(0, 3, 0)
                                task.wait(0.5)
                                root.CFrame = startCFrame
                                task.wait(0.1)
                                
                            -- AUTO STEAL TP ONLY
                            elseif _G.ZeroixConfig.AutoStealTP then
                                root.CFrame = egg.CFrame + Vector3.new(0, 2, 0)
                                task.wait(0.5)
                                root.CFrame = baseCFrame + Vector3.new(0, 3, 0)
                                task.wait(0.5)
                            end
                        end)
                        
                        _G.ZeroixConfig.IsProcessing = false
                    end
                end
            end
        end
    end)
end
RunUltimateEngine()
-- =========================================================================
--  ZEROIX HUB - UNIVERSAL VERSION 10 - PART 2 (V10 PREMIUM UI STANDARD)
-- =========================================================================

pcall(function()
    local oldUi = game:GetService("CoreGui"):FindFirstChild("ZeroixUniversalUI")
    if oldUi then oldUi:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TitleBar = Instance.new("Frame")
    local UiIcon = Instance.new("ImageLabel")
    local Title = Instance.new("TextLabel")
    local MinimizeBtn = Instance.new("TextButton")
    local ToggleContainer = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")

    ScreenGui.Name = "ZeroixUniversalUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
    MainFrame.Size = UDim2.new(0, 260, 0, 160)
    MainFrame.Active = true
    MainFrame.Draggable = true 

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = MainFrame

    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 35)

    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, 8)
    BarCorner.Parent = TitleBar

    UiIcon.Name = "UiIcon"
    UiIcon.Parent = TitleBar
    UiIcon.BackgroundTransparency = 1
    UiIcon.Position = UDim2.new(0, 8, 0, 6)
    UiIcon.Size = UDim2.new(0, 22, 0, 22)
    UiIcon.Image = "rbxassetid://6031094678" 
    UiIcon.ImageColor3 = Color3.fromRGB(255, 100, 0)

    Title.Name = "Title"
    Title.Parent = TitleBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 36, 0, 0)
    Title.Size = UDim2.new(1, -70, 1, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "ZEROIX HUB v10 [GOD MODE]"
    Title.TextColor3 = Color3.fromRGB(255, 100, 0)
    Title.TextSize = 14.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Parent = TitleBar
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MinimizeBtn.Position = UDim2.new(1, -28, 0, 6)
    MinimizeBtn.Size = UDim2.new(0, 22, 0, 22)
    MinimizeBtn.Font = Enum.Font.SourceSansBold
    MinimizeBtn.Text = "-"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextSize = 16.000

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(1, 0)
    MinCorner.Parent = MinimizeBtn

    ToggleContainer.Name = "ToggleContainer"
    ToggleContainer.Parent = MainFrame
    ToggleContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    ToggleContainer.BorderSizePixel = 0
    ToggleContainer.Position = UDim2.new(0, 10, 0, 45)
    ToggleContainer.Size = UDim2.new(1, -20, 1, -55)

    UIListLayout.Parent = ToggleContainer
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8)

    local uiOpened = true
    MinimizeBtn.MouseButton1Click:Connect(function()
        uiOpened = not uiOpened
        if uiOpened then
            MainFrame:TweenSize(UDim2.new(0, 260, 0, 160), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
            ToggleContainer.Visible = true
            MinimizeBtn.Text = "-"
        else
            MainFrame:TweenSize(UDim2.new(0, 260, 0, 35), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
            ToggleContainer.Visible = false
            MinimizeBtn.Text = "+"
        end
    end)

    local function CreateGacorToggle(name, callback)
        local Button = Instance.new("TextButton")
        local BtnCorner = Instance.new("UICorner")
        
        Button.Name = name .. "Btn"
        Button.Parent = ToggleContainer
        Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Button.BorderSizePixel = 0
        Button.Size = UDim2.new(1, 0, 0, 42)
        Button.Font = Enum.Font.SourceSansBold
        Button.Text = name .. " : OFF"
        Button.TextColor3 = Color3.fromRGB(180, 180, 180)
        Button.TextSize = 14.000
        
        BtnCorner.CornerRadius = UDim.new(0, 6)
        BtnCorner.Parent = Button
        
        local active = false
        Button.MouseButton1Click:Connect(function()
            active = not active
            if active then
                Button.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.Text = name .. " : ON"
            else
                Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Button.TextColor3 = Color3.fromRGB(180, 180, 180)
                Button.Text = name .. " : OFF"
            end
            callback(active)
        end)
    end

    CreateGacorToggle("Touch Gacor Active", function(state)
        _G.ZeroixConfig.TouchGacor = state
        if state then _G.ZeroixConfig.IsProcessing = false end
    end)

    CreateGacorToggle("Auto Steal High Value TP", function(state)
        _G.ZeroixConfig.AutoStealTP = state
        if state then _G.ZeroixConfig.IsProcessing = false end
    end)
end)

print("[ZEROIX HUB V10]: EXCLUSIVE HIGH VALUE ONLY LOADED!")
