local Leaderboard = {}

local DataStoreService = game:GetService("DataStoreService")

local MonthlyTimeStorage = DataStoreService:GetDataStore("MonthlyTimeStore")
local DailyLoginStreakStorage = DataStoreService:GetDataStore("DailyLoginStore")


function Leaderboard.LeaderboardInit(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local currentSessionTime = Instance.new("IntValue")
    currentSessionTime.Name = "currentSessionTime"
    currentSessionTime.Value = 0
    currentSessionTime.Parent = leaderstats

    local monthlyTime = Instance.new("IntValue")
    monthlyTime.Name = "monthlyTime"
    monthlyTime.Value = 0
    monthlyTime.Parent = leaderstats

    local success, mTime = pcall(function()
        return MonthlyTimeStorage:GetAsync("player.UserId")
    end)
    if not success then
        print("Failed to get monthly time")
    elseif mTime == nil then
        local errorMessage
        success, errorMessage = pcall(function()
	        MonthlyTimeStorage:SetAsync("player.UserId", 0)
        end)
        if not success then
	        print(errorMessage)
        end
    else
        print(mTime)
        monthlyTime.Value = mTime
    end

    local dailyLoginStreak = Instance.new("IntValue")
    dailyLoginStreak.Name = "dailyLoginStreak"
    dailyLoginStreak.Value = 0
    dailyLoginStreak.Parent = leaderstats

    local streak
    success, streak = pcall(function()
        return DailyLoginStreakStorage:GetAsync("player.UserId")
    end)
    if not success then
        print("Failed to get daily login streak")
    elseif streak == nil then
        success, errorMessage = pcall(function()
	        DailyLoginStreakStorage:SetAsync("player.UserId", 0)
        end)
        if not success then
	        print(errorMessage)
        end
    else
        print(streak)
        dailyLoginStreak.Value = streak
    end
    
end

function Leaderboard.UpdateCurrentSessionTime(player)
    local p = player

    local leaderstats = player:FindFirstChild("leaderstats")
    local currentSessionTime = leaderstats:FindFirstChild("currentSessionTime")

    currentSessionTime.Value += 1

    Leaderboard.UpdateMonthlyTime(p)
end

function Leaderboard.UpdateMonthlyTime(player)
    
    local success, mTime = pcall(function()
        return MonthlyTimeStorage:IncrementAsync("Player.UserId", 1)
    end)
    if not success then
        print("failed to increament monthly time")
    end

    local leaderstats = player:FindFirstChild("leaderstats")
    local monthlyTime = leaderstats:FindFirstChild("monthlyTime")

    success, mTime = pcall(function()
        return MonthlyTimeStorage:GetAsync("Player.UserId")
    end)
    if not success then
        print("failed to add monthly time to monthly time leaderboard")
    end

    monthlyTime.Value = mTime
end

function Leaderboard.UpdateDailyLoginStreak()

end

return Leaderboard
