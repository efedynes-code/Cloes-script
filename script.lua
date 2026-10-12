-- Cloes TANRI MODU MENÜ v4.0
-- By Cloes

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "TANRI MODU | By Cloes",
   LoadingTitle = "Cloes yükleniyor...",
   LoadingSubtitle = "By Cloes",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Cloes",
      FileName = "TanriModu"
   },
   KeySystem = false
})

-- Değişkenler
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()

local speedOn = false
local flyOn = false
local jumpOn = false
local espOn = false
local godOn = false
local noclipOn = false
local fullbrightOn = false
local aimbotOn = false

-- Ana Sekme
local MainTab = Window:CreateTab("Ana Hileler", 4483362458)

MainTab:CreateSection("Hareket")

MainTab:CreateToggle({
   Name = "Speed Hack (Hız)",
   CurrentValue = false,
   Flag = "SpeedToggle",
   Callback = function(Value)
       speedOn = Value
       if Value then
           humanoid.WalkSpeed = 300
       else
           humanoid.WalkSpeed = 16
       end
   end,
})

MainTab:CreateToggle({
   Name = "Fly (Uçma)",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
       flyOn = Value
       if Value then
           local fly = Instance.new("BodyVelocity")
           fly.MaxForce = Vector3.new(1e5, 1e5, 1e5)
           fly.Velocity = Vector3.new(0, 0, 0)
           fly.Parent = root
           RunService.RenderStepped:Connect(function()
               if flyOn then
                   local move = Vector3.new()
                   if UIS:IsKeyDown(Enum.KeyCode.W) then move += camera.CFrame.LookVector end
                   if UIS:IsKeyDown(Enum.KeyCode.S) then move -= camera.CFrame.LookVector end
                   if UIS:IsKeyDown(Enum.KeyCode.A) then move -= camera.CFrame.RightVector end
                   if UIS:IsKeyDown(Enum.KeyCode.D) then move += camera.CFrame.RightVector end
                   if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
                   if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0, 1, 0) end
                   fly.Velocity = move * 200
               end
           end)
       else
           if root:FindFirstChildOfClass("BodyVelocity") then
               root:FindFirstChildOfClass("BodyVelocity"):Destroy()
           end
       end
   end,
})

MainTab:CreateToggle({
   Name = "Infinite Jump (Sınırsız Zıplama)",
   CurrentValue = false,
   Flag = "JumpToggle",
   Callback = function(Value)
       jumpOn = Value
   end,
})

UIS.JumpRequest:Connect(function()
   if jumpOn then
       humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
   end
end)

MainTab:CreateSection("Görsel")

MainTab:CreateToggle({
   Name = "ESP (Duvar Arkası)",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
       espOn = Value
       if Value then
           for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= player and v.Character then
                   local h = Instance.new("Highlight")
                   h.Parent = v.Character
                   h.FillColor = Color3.fromRGB(255, 0, 0)
                   h.OutlineColor = Color3.fromRGB(255, 255, 255)
               end
           end
       else
           for _, v in pairs(game.Players:GetPlayers()) do
               if v.Character and v.Character:FindFirstChildOfClass("Highlight") then
                   v.Character:FindFirstChildOfClass("Highlight"):Destroy()
               end
           end
       end
   end,
})

MainTab:CreateToggle({
   Name = "Fullbright (Aydınlatma)",
   CurrentValue = false,
   Flag = "BrightToggle",
   Callback = function(Value)
       fullbrightOn = Value
       if Value then
           game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
           game.Lighting.Brightness = 2
           game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
       else
           game.Lighting.Ambient = Color3.fromRGB(0, 0, 0)
           game.Lighting.Brightness = 1
           game.Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
       end
   end,
})

-- Koruma Sekmesi
local ProtectTab = Window:CreateTab("Koruma", 4483362458)

ProtectTab:CreateSection("Savunma")

ProtectTab:CreateToggle({
   Name = "God Mode (Ölümsüzlük)",
   CurrentValue = false,
   Flag = "GodToggle",
   Callback = function(Value)
       godOn = Value
       if Value then
           humanoid.MaxHealth = math.huge
           humanoid.Health = math.huge
       else
           humanoid.MaxHealth = 100
           humanoid.Health = 100
       end
   end,
})

ProtectTab:CreateToggle({
   Name = "Noclip (Duvardan Geçme)",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
       noclipOn = Value
   end,
})

RunService.Stepped:Connect(function()
   if noclipOn then
       for _, v in pairs(char:GetDescendants()) do
           if v:IsA("BasePart") and v.CanCollide then
               v.CanCollide = false
           end
       end
   end
end)

ProtectTab:CreateToggle({
   Name = "Anti-AFK",
   CurrentValue = false,
   Flag = "AfkToggle",
   Callback = function(Value)
       if Value then
           player.Idled:Connect(function()
               game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0))
               wait(1)
               game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0))
           end)
       end
   end,
})

-- Aimbot Sekmesi
local AimTab = Window:CreateTab("Aimbot", 4483362458)

AimTab:CreateSection("Nişan")

AimTab:CreateToggle({
   Name = "Aimbot (Otomatik Nişan)",
   CurrentValue = false,
   Flag = "AimbotToggle",
   Callback = function(Value)
       aimbotOn = Value
   end,
})

RunService.RenderStepped:Connect(function()
   if aimbotOn then
       local closest = nil
       local dist = math.huge
       for _, v in pairs(game.Players:GetPlayers()) do
           if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
               local d = (v.Character.Head.Position - camera.CFrame.Position).Magnitude
               if d < dist then
                   dist = d
                   closest = v.Character.Head
               end
           end
       end
       if closest then
           camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Position)
       end
   end
end)

-- Araçlar Sekmesi
local ToolTab = Window:CreateTab("Araçlar", 4483362458)

ToolTab:CreateSection("Işınlanma")

ToolTab:CreateButton({
   Name = "Mouse ile Işınlan",
   Callback = function()
       UIS.InputBegan:Connect(function(input)
           if input.UserInputType == Enum.UserInputType.MouseButton1 then
               if mouse.Hit then
                   root.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 5, 0))
               end
           end
       end)
   end,
})

ToolTab:CreateButton({
   Name = "Rastgele Işınlan",
   Callback = function()
       local x = math.random(-500, 500)
       local z = math.random(-500, 500)
       root.CFrame = CFrame.new(x, 50, z)
   end,
})

ToolTab:CreateButton({
   Name = "Sunucudan Ayrıl",
   Callback = function()
       game:GetService("TeleportService"):Teleport(game.PlaceId, player)
   end,
})

-- Hakkında
Window:CreateTab("Hakkında", 4483362458):CreateParagraph({
   Title = "TANRI MODU",
   Content = "Bu script Cloes tarafından yapılmıştır. By Cloes. İyi eğlenceler."
})

Rayfield:Notify({
   Title = "TANRI MODU",
   Content = "Menü yüklendi! By Cloes",
   Duration = 5,
   Image = 4483362458,
})

print("Cloes TANRI MODU MENÜ yüklendi. By Cloes.")
