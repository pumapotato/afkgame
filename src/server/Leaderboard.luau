local Leaderboard = {}

local DataStoreService = game:GetService("DataStoreService")

local MonthlyTimeStorage = DataStoreService:GetDataStore("MonthlyTimeStore")
local DailyLoginStreakStorage = DataStoreService:GetDataStore("DailyLoginStore")
local LastLoginDateStorage = DataStoreService:GetDataStore("LastLoginDateStore")


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
        return MonthlyTimeStorage:GetAsync(player.UserId)
    end)
    if not success then
        print("Failed to get monthly time")
        print(mTime)
    end
    if mTime == nil then
        local errorMessage
        success, errorMessage = pcall(function()
	        MonthlyTimeStorage:SetAsync(player.UserId, 0)
        end)
        if not success then
	        print(errorMessage)
        end
    else
        monthlyTime.Value = mTime
    end

    local dailyLoginStreak = Instance.new("IntValue")
    dailyLoginStreak.Name = "dailyLoginStreak"
    dailyLoginStreak.Value = 0
    dailyLoginStreak.Parent = leaderstats

    local streak
    local errorMessage
    success, streak = pcall(function()
        return DailyLoginStreakStorage:GetAsync(player.UserId)
    end)
    if not success then
        print("Failed to get daily login streak")
    end
    if streak == nil then
        local tempDate = DateTime.fromIsoDate("1400-01-01T00:00:00Z")
        success, errorMessage = pcall(function()
	        DailyLoginStreakStorage:SetAsync(player.UserId, 0)
        end)
        if not success then
	        print(errorMessage)
        end
        success, errorMessage = pcall(function()
	        LastLoginDateStorage:SetAsync(player.UserId, tempDate.ToIsoDate())
        end)
        if not success then
	        print(errorMessage)
        end
    else
        print(streak)
        dailyLoginStreak.Value = streak
    end

    local tempDate = DateTime.fromIsoDate("1400-01-01T00:00:00Z")
    success, errorMessage = pcall(function()
        LastLoginDateStorage:SetAsync(player.UserId, tempDate.ToIsoDate(tempDate))
    end)
    if not success then
        print(errorMessage)
    end
    
    local lastLoginDatafr
    success, lastLoginDatafr = pcall(function()
        LastLoginDateStorage:GetAsync(player.UserId)
    end)
    print(lastLoginDatafr)
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
        return MonthlyTimeStorage:IncrementAsync(player.UserId, 1)
    end)
    if not success then
        print("failed to increament monthly time")
    end

    local leaderstats = player:FindFirstChild("leaderstats")
    local monthlyTime = leaderstats:FindFirstChild("monthlyTime")

    success, mTime = pcall(function()
        return MonthlyTimeStorage:GetAsync(player.UserId)
    end)
    if not success then
        print("failed to add monthly time to monthly time leaderboard")
    end

    monthlyTime.Value = mTime
end

function Leaderboard.UpdateDailyLoginStreak(player, todaysDate)
    local success, lastLoginDate = pcall(function()
        return LastLoginDateStorage:GetAsync(player.UserId)
    end)
    if not success then
        print("failed to add monthly time to monthly time leaderboard")
    end
end

return Leaderboard
