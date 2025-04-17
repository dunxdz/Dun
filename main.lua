-- Dũng Hub - UI Gọn Nhẹ, Không Key, Full Hỗ Trợ Xeno v1.1.75
repeat task.wait() until game:IsLoaded()
if game.PlaceId ~= 2753915549 and game.PlaceId ~= 4442272183 and game.PlaceId ~= 7449423635 then return end

local Logo = "https://raw.githubusercontent.com/dunxdz/Dunxhub/main/boruto_logo.png"
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RunDTM/HohoHub/main/UILibrary.lua"))()
local Window = Library:CreateWindow("Dũng Hub", Logo)

-- Auto Farm
local tabFarm = Window:CreateTab("Auto Farm")
tabFarm:AddToggle("Auto Farm", false, function(v)
    getgenv().AutoFarm = v
    while getgenv().AutoFarm do
        pcall(function()
            local player = game.Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local humRoot = char:FindFirstChild("HumanoidRootPart")
            if not humRoot then return end

            -- Tự nhận nhiệm vụ
            for _, npc in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                if npc:FindFirstChild("Head") and npc.Head:FindFirstChild("QuestMarker") then
                    humRoot.CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                    task.wait(1)
                    fireproximityprompt(npc.Head:FindFirstChildOfClass("ProximityPrompt"))
                    mouse1click()
                    break
                end
            end

            -- Tìm và đánh quái
            for _, mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    local mobRoot = mob:FindFirstChild("HumanoidRootPart")
                    if mobRoot then
                        humRoot.CFrame = mobRoot.CFrame + Vector3.new(0, 5, 0)
                        repeat
                            mouse1click()
                            task.wait()
                        until not getgenv().AutoFarm or mob.Humanoid.Health <= 0
                    end
                end
            end
        end)
        task.wait()
    end
end)

-- Teleport
local tabTP = Window:CreateTab("Teleport")
tabTP:AddButton("Đến Đảo Chính", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(1041, 134, 1325))
end)
tabTP:AddButton("Đến Đảo Bí Ẩn", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(3876, 5, -1930))
end)

-- Fruit Notifier
local tabFruit = Window:CreateTab("Trái Cây")
tabFruit:AddToggle("Thông Báo Trái Cây", false, function(v)
    getgenv().FruitNotify = v
    while getgenv().FruitNotify do
        print("🍈 Có trái cây spawn!") -- Chỉ là demo, có thể gắn API thật nếu muốn
        task.wait(10)
    end
end)

-- ESP
local tabESP = Window:CreateTab("ESP")
tabESP:AddToggle("ESP Người Chơi", false, function(v)
    getgenv().PlayerESP = v
    print("ESP Player:", v)
end)
