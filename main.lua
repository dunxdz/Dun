-- Dũng Hub - Hoho Giao Diện - Không cần key - Xeno 1.1.75
local Logo = "https://raw.githubusercontent.com/dunxdz/Dunxhub/main/boruto_logo.png"
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RunDTM/HohoHub/main/UILibrary.lua"))()
local Window = Library:CreateWindow("Dũng Hub", Logo)

-- Auto Farm Level
local Tab1 = Window:CreateTab("Auto Farm")
Tab1:AddToggle("Auto Farm Level", false, function(v)
    getgenv().AutoFarmLevel = v
    while getgenv().AutoFarmLevel do
        pcall(function()
            local player = game.Players.LocalPlayer
            local char = player.Character
            local hum = char and char:FindFirstChild("HumanoidRootPart")

            -- Nhận nhiệm vụ tự động
            local function getQuest()
                for _, npc in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                    if npc:FindFirstChild("Head") and npc.Head:FindFirstChild("QuestMarker") then
                        hum.CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                        wait(1)
                        fireproximityprompt(npc.Head:FindFirstChildOfClass("ProximityPrompt"))
                        wait(2)
                        -- Click chọn nhiệm vụ (giả lập)
                        mouse1click()
                        wait(1)
                        break
                    end
                end
            end

            -- Tìm quái
            local function getEnemy()
                for _, mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                        return mob
                    end
                end
                return nil
            end

            -- Gọi nhận nhiệm vụ
            getQuest()
            wait(2)

            -- Tìm và farm quái
            local target = getEnemy()
            if target then
                repeat
                    hum.CFrame = target.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                    wait(0.2)
                    -- Đánh quái (giả lập click chuột)
                    mouse1click()
                until not getgenv().AutoFarmLevel or target.Humanoid.Health <= 0 or not target.Parent
            end
        end)
        wait(1)
    end
end)

-- Teleport Tab
local Tab2 = Window:CreateTab("Teleport")
Tab2:AddButton("Đến Đảo Chính", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1041, 134, 1325)
end)
Tab2:AddButton("Đến Đảo Bí Ẩn", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3876, 5, -1930)
end)

-- Fruit Notifier Tab
local Tab3 = Window:CreateTab("Fruit Notifier")
Tab3:AddLabel("🔔 Hiện thông báo khi có trái cây spawn")
Tab3:AddToggle("Bật thông báo", false, function(v)
    getgenv().FruitNotify = v
    while getgenv().FruitNotify do
        wait(5)
        print("🍈 Có trái spawn!") -- Thay bằng API check real nếu có
    end
end)

-- ESP Tab
local Tab4 = Window:CreateTab("ESP")
Tab4:AddToggle("ESP Người Chơi", false, function(v)
    getgenv().PlayerESP = v
    print("ESP: ", v)
end)

