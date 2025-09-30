Utilities = {}

local DataStoreService = game:GetService("DataStoreService")

local afkStatsStorage = DataStoreService:GetDataStore("afkStatsStorage")

local function playerAfkStats(currentSessionTime: number, monthlySessionTime: number, dailyStreak: number, lastLoginDate: DateTime)
    return {
    currentSessionTime = currentSessionTime or 0,
    monthlySessionTime = monthlySessionTime or 0,
    dailyStreak = dailyStreak or 0,
    lastLoginDate = lastLoginDate or "1400-01-01T00:00:00Z"
    }
end

function Utilities.GetDatastoreValue(player, key)
    local success, statTable = pcall(function()
        return afkStatsStorage:GetAsync(player.UserId)
    end)
    if not success then
        print("Failed to get monthly time")
    end
    local value
    if statTable == nil then
        local errorMessage
        success, errorMessage = pcall(function()
	        afkStatsStorage:SetAsync(player.UserId, playerAfkStats())
        end)
        if not success then
	        print(errorMessage)
        end
        return nil
    else
        value = statTable[key]
        return value
    end
end

function Utilities.IncrementDataStoreValue(player, key)
    local success, statTable = pcall(function()
        return afkStatsStorage:GetAsync(player.UserId)
    end)
    if not success then
        print("Failed to get stat table from datastore")
    end
    statTable[key] += 1
    success, _ = pcall(function()
        return afkStatsStorage:SetAsync(player.UserId, statTable)
    end)
    if not success then
        print("Failed to increment stat table from datastore")
    end
end

function Utilities.SetDataStoreValue(player, key, value)
    local success, statTable = pcall(function()
        return afkStatsStorage:GetAsync(player.UserId)
    end)
    if not success then
        print("Failed to get stat table from datastore")
    end
    statTable[key] = value
    success, _ = pcall(function()
        return afkStatsStorage:SetAsync(player.UserId, statTable)
    end)
    if not success then
        print("failed to increament stat table from datastore")
    end
end


return Utilities