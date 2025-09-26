print("Hello world, from server! and your mom")

wait(1)

local Players = game:GetService("Players")

local LeaderboardModule = require(script.Leaderboard)
local StatTrackingModule = require(script.StatTracking)


--Players.PlayerAdded:Connect(LeaderboardModule.LeaderboardInit())
for _, player in ipairs(Players:GetPlayers()) do
    print(player.UserId)
    LeaderboardModule.LeaderboardInit(player)
end

wait(1)

StatTrackingModule.Count()