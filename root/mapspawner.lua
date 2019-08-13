#include maps
function onLoad(save_state)
    self.createButton({click_function = "spawnAutumn", function_owner = self, label = "Autumn Map", position = {0, 1, 4}, rotation = {0, 180, 0}, scale = {2, 2, 2}, width = 2100, height = 400, font_size = 300, color = {0.956, 0.392, 0.113, 1}})
    self.createButton({click_function = "spawnWinter", function_owner = self, label = "Winter Map", position = {0, 1, 2}, rotation = {0, 180, 0}, scale = {2, 2, 2}, width = 2100, height = 400, font_size = 300, color = {0.5528, 0.759, 0.9947, 1}})
    self.createButton({click_function = "spawnLake", function_owner = self, label = "Lake Map (default)", position = {0, 1, 0}, rotation = {0, 180, 0}, scale = {2, 2, 2}, width = 2100, height = 400, font_size = 200, color = {0.2739, 0.8414, 0.2477, 1}})
    self.createButton({click_function = "spawnLakeRandom", function_owner = self, label = "Lake Map (random)", position = {0, 1, -2}, rotation = {0, 180, 0}, scale = {2, 2, 2}, width = 2100, height = 400, font_size = 200, color = {0.2739, 0.8414, 0.2477, 1}})
    self.createButton({click_function = "spawnMountain", function_owner = self, label = "Mountain Map", position = {0, 1, -4}, rotation = {0, 180, 0}, scale = {2, 2, 2}, width = 2100, height = 400, font_size = 200, color = {0.627, 0.125, 0.941, 1}})
    self.setName("Setup Map")
end

function spawnAutumn()
    spawnMap("Autumn", false)
end

function spawnWinter()
    spawnMap("Winter", true)
end

function spawnLake()
    spawnMap("Lake", false)
end

function spawnLakeRandom()
    spawnMap("Lake", true)
end

function spawnMountain()
    spawnMap("Mountain", true)
end

function spawnMap(map, random)
    ruinItemBags = {getObjectFromGUID("005fc0"), getObjectFromGUID("d65302"), getObjectFromGUID("fd5932")}
    self.destruct()
    -- map and items
    for _, x in ipairs(map_data[map].map) do
        spawnObjectJSON({json=x})
    end

    -- ruins and ruin items
    available = Global.getTable('available')
    
    -- Spawn items if we have Boars and no vagabonds
    vagabonds = math.max(2-available.Vagabond, 1-available.Boars)
    local params = {}
    params.rotation = {0, 180, 0}
    params.smooth = false
    if vagabonds > 0 then
        for x=1, vagabonds do
            ruinItemBags[x].shuffle()
            for _, y in ipairs(map_data[map].ruins) do
                params.position = y
                params.position[2] = params.position[2]+(x-1)*0.1
                ruinItemBags[x].takeObject(params)
            end
        end
    else
        params.callback_function = function(o) o.lock() end
    end
    for _, x in ipairs(map_data[map].ruins) do
        params.position = x
        params.position[2] = params.position[2]+vagabonds*0.1
        ruinItemBags[3].takeObject(params)
    end
    for _, x in ipairs(ruinItemBags) do
        x.destruct()
    end

    -- clearing markers
    local clearingMarkerBag = getObjectFromGUID("e060fd")
    if map_data[map]["clearing_markers"] ~= nil and random == true then
        clearingMarkerBag.shuffle()
        local params = {}
        params.callback_function = function(o) o.lock() end
        params.smooth = false
        for _, x in ipairs(map_data[map].clearing_markers) do
            params.position = x.position
            params.rotation = x.rotation
            clearingMarkerBag.takeObject(params)
        end
    end
    clearingMarkerBag.destruct()

    -- note
    if map_data[map]['note'] ~= nil then
        setNotes(map_data[map]['note'])
    end

    Global.call('SetupQuests', {})
end
