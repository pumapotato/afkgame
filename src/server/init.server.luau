print("Hello world, from server! and your mom")

task.wait(1)

local Players = game:GetService("Players")

local LeaderboardModule = require(script.Leaderboard)



-- Players.PlayerAdded:Connect(function(Player)
--     print("Player connected!")
--     LeaderboardModule.leaderboardSetup(Player)
-- end)

Players.PlayerAdded:Connect(LeaderboardModule.leaderboardSetup())
for _, player in ipairs(Players:GetPlayers()) do
    LeaderboardModule.leaderboardSetup(player)
end