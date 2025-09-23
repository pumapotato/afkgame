local StatTracking = {}

local LeaderboardModule = require(script.Parent.Leaderboard)

local Players = game:GetService("Players")

function StatTracking.Count()
    while wait(5) do
        for _, player in ipairs(Players:GetPlayers()) do
            LeaderboardModule.UpdateCurrentSessionTime(player)
        end
    end
end

return StatTracking