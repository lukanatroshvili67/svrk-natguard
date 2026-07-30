-- svrk-natguard: Native safety wrappers
-- Loaded via @svrk-natguard/natguard.lua in each resource's server_scripts
-- Silently blocks invalid entity calls instead of crashing the server

local resName = GetCurrentResourceName()
local _blockCount = 0
local _lastLogTime = 0
local LOG_INTERVAL = 60

local function isValidEntity(entity)
    return entity and entity ~= 0 and DoesEntityExist(entity)
end

local function onBlocked(nativeName, entity)
    _blockCount = _blockCount + 1
    local now = os.time()
    if now - _lastLogTime >= LOG_INTERVAL then
        print('^3[svrk-natguard:' .. resName .. '] Blocked ' .. _blockCount .. ' invalid entity call(s) in the last ' .. LOG_INTERVAL .. 's^7')
        _blockCount = 0
        _lastLogTime = now
    end
end

local _GetEntityCoords = GetEntityCoords
GetEntityCoords = function(entity, ...)
    if not isValidEntity(entity) then
        onBlocked("GetEntityCoords", entity)
        return vector3(0.0, 0.0, 0.0)
    end
    return _GetEntityCoords(entity, ...)
end

local _GetEntityRotation = GetEntityRotation
GetEntityRotation = function(entity, ...)
    if not isValidEntity(entity) then
        onBlocked("GetEntityRotation", entity)
        return vector3(0.0, 0.0, 0.0)
    end
    return _GetEntityRotation(entity, ...)
end

local _GetEntityHeading = GetEntityHeading
GetEntityHeading = function(entity, ...)
    if not isValidEntity(entity) then
        onBlocked("GetEntityHeading", entity)
        return 0.0
    end
    return _GetEntityHeading(entity, ...)
end

local _GetEntityModel = GetEntityModel
GetEntityModel = function(entity, ...)
    if not isValidEntity(entity) then
        onBlocked("GetEntityModel", entity)
        return 0
    end
    return _GetEntityModel(entity, ...)
end

-- Player source validation for TriggerClientEvent.
-- Accept -1 (broadcast to all clients) and any positive integer source.
-- Block only truly invalid sources (nil, 0, non-numeric).
local function isValidSource(source)
    local n = tonumber(source)
    if not n then return false end
    return n == -1 or n > 0
end

local _TriggerClientEvent = TriggerClientEvent
TriggerClientEvent = function(eventName, source, ...)
    if eventName == nil or type(eventName) ~= "string" then
        local resName = GetCurrentResourceName() or "unknown"
        print('^1[svrk-natguard] BLOCKED TriggerClientEvent with nil/invalid eventName from resource: ' .. resName .. '^7')
        return
    end
    if not isValidSource(source) then return end
    return _TriggerClientEvent(eventName, source, ...)
end

