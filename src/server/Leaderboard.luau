local Leaderboard = {}


function Leaderboard.leaderboardSetup(player)
    print("1")
    local leaderstats = Instance.new("Folder")
    print("2")
    leaderstats.Name = "leaderstats"
    print("3")
    leaderstats.Parent = player
    print("4")

    local time = Instance.new("IntValue")
    print("5")
    time.Name = "Time"
    print("6")
    time.Name = 0
    print("7")
    time.Parent = leaderstats
    print("8")

    print("we made it this far")
end

return Leaderboard