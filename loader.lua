local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local BASE_URL = "https://raw.githubusercontent.com/TrustsenseDev/MicroHub/main/games/"
local DEFAULT_SCRIPT_URL = BASE_URL.."universal.lua"

local function LoadScript(scriptUrl)
    local success, result = pcall(function()
        return game:HttpGet(scriptUrl)
    end)
    
    if success then
        local loadSuccess, loadError = pcall(function()
            local loadedScript = loadstring(result)
            if loadedScript then
                loadedScript()
            end
        end)
        
        if not loadSuccess then
            warn("[MicroHub] Failed to load script: "..tostring(loadError))
        end
    else
        warn("[MicroHub] Failed to fetch script: "..tostring(result))
    end
end

local function Init()
    local placeId = game.PlaceId
    local scriptUrl = BASE_URL..placeId..".lua"
    
    local success = pcall(function()
        return game:HttpGet(scriptUrl)
    end)
    
    if success then
        LoadScript(scriptUrl)
    else
        LoadScript(DEFAULT_SCRIPT_URL)
    end
    
    task.spawn(function()
        local player = Players.LocalPlayer
        if player then
            local success, result = pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "MicroHub",
                    Text = "Loaded successfully!",
                    Duration = 3
                })
            end)
        end
    end)
end

xpcall(Init, function(err)
    warn("[MicroHub] Error in loader: "..tostring(err).."\n"..debug.traceback())
end)
