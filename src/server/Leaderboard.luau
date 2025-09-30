local Leaderboard = {}

local UtilitiesModule = require(script.Parent.Utilities)


function Leaderboard.LeaderboardInit(player)
    -- Create leaderstats folder for player
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    -- Initialize Current Session Time on player's leaderboard
    local currentSessionTime = Instance.new("IntValue")
    currentSessionTime.Name = "currentSessionTime"
    currentSessionTime.Value = 0
    currentSessionTime.Parent = leaderstats

    -- Initialize Monthly Time on player's leaderboard
    local monthlyTime = Instance.new("IntValue")
    monthlyTime.Name = "monthlyTime"
    monthlyTime.Value = 0
    monthlyTime.Parent = leaderstats
    monthlyTime.Value = UtilitiesModule.GetDatastoreValue(player, "monthlySessionTime")

    -- Initialize Daily Login Streak on player's leaderboard
    local dailyLoginStreak = Instance.new("IntValue")
    dailyLoginStreak.Name = "dailyLoginStreak"
    dailyLoginStreak.Value = 0
    dailyLoginStreak.Parent = leaderstats
    dailyLoginStreak.Value = UtilitiesModule.GetDatastoreValue(player, "dailyStreak")

    -- Update player data streak upon joining the server
    Leaderboard.UpdateDailyLoginStreak(player)
end

function Leaderboard.UpdateCurrentSessionTime(player)
    local p = player
    local leaderstats = player:FindFirstChild("leaderstats")
    local currentSessionTime = leaderstats:FindFirstChild("currentSessionTime")

    currentSessionTime.Value += 1

    Leaderboard.UpdateMonthlyTime(p)
end

function Leaderboard.UpdateMonthlyTime(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    local monthlyTime = leaderstats:FindFirstChild("monthlyTime")

    UtilitiesModule.IncrementDataStoreValue(player, "monthlySessionTime")
    monthlyTime.Value = UtilitiesModule.GetDatastoreValue(player, "monthlySessionTime")
end

function Leaderboard.UpdateDailyLoginStreak(player)
    local currentDate = DateTime.now()
    local lastLoginDate = DateTime.fromIsoDate(UtilitiesModule.GetDatastoreValue(player, "lastLoginDate"))
    local diffSeconds = currentDate.UnixTimestamp - lastLoginDate.UnixTimestamp
    print(diffSeconds)
    -- There are 86400 seconds in a day
    if diffSeconds >= 172800 then
        UtilitiesModule.SetDataStoreValue(player, "dailyStreak", 0)
         UtilitiesModule.SetDataStoreValue(player, "lastLoginDate", currentDate.ToIsoDate(currentDate))
    elseif diffSeconds >= 86400 then
        UtilitiesModule.IncrementDataStoreValue(player, "dailyStreak")
        UtilitiesModule.SetDataStoreValue(player, "lastLoginDate", currentDate.ToIsoDate(currentDate))
    end
    
end

return Leaderboard