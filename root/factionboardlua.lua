#include factionsv2
#include buttonsv2
#include factionboardxml
#include scenarios

chosen_faction = nil

function g()
    self.UI.setXml(board_xml)
    -- We need some delay between setting ui and using it. hence the weird coroutine
    for x=1,10 do
        coroutine.yield()
    end
    showButtons()
    return 1
end

function onLoad(save_state)
    Global.call('ImHere', {self})
    startLuaCoroutine(self, 'g')
end

function toggleButtons(player, value, id)
    self.UI.setAttribute(id..'Buttons', 'active', value)
end

function setColor(_, color)
    local colors = Global.getTable('colors')
    if not colors[color] then
        for k,v in pairs(colors) do
            self.UI.setAttribute(k, 'active', v)
        end
        return
    end
    spawnWithColor(chosen_faction, color)
end


function spawnFunction(player, faction)
    if isSpectator(player) then
        broadcastToColor("Sit down first", player.color, "Red")
        return
    end
    local avail = Global.getTable('available')
    local colors = Global.getTable('colors')
    if (avail[faction] < 1) then return end
    Global.call('FactionChosen', {faction})
    local preferred_color = faction_colors[faction..tostring(avail[faction])]
    if not colors[preferred_color] then
        player.print("Preferred color for faction: "..faction.." alread taken.\nPlease pick another", red)
        chosen_faction = faction
        self.UI.setAttribute("factionsButtons", "active", "False")
        self.UI.setAttribute("botsButtons", "active", "False")
        self.UI.setAttribute("scenariosButtons", "active", "False")
        self.UI.setAttribute("rBotButtons", "active", "False")
        self.UI.setAttribute("fanButtons", "active", "False")
        self.UI.setAttribute("colorButtons", "active", "True")
        for k,v in pairs(colors) do
            self.UI.setAttribute(k, 'active', v)
        end
        return
    else
        spawnWithColor(faction, preferred_color)
    end
end

function isSpectator(player)
    if player.color == "Grey" then
        return true
    else
        return false
    end
end

function spawnWithColor(faction, color)
    local colors = Global.getTable('colors')
    colors[color] = false
    Global.setTable('colors', colors)
    log(colors)
    local closest = findClosestPosition()
    closest.scale = {17.20, 5.40, 3.00}
    val = false
    while not val do
        val = Player[color].setHandTransform(closest, 1)
    end
    if (faction == "Vagabond") then
        self.UI.setAttribute("factionsButtons", "active", "False")
        self.UI.setAttribute("vagabondButtons", "active", "True")
        self.UI.setAttribute('typeToggles', "active", "False")
        self.UI.setAttribute("colorButtons", "active", "False")
    else
        spawnFaction(faction)
    end
end

function spawnBot(player, faction, fan)
    if isSpectator(player) then
        broadcastToColor("Sit down first", player.color, "Red")
        return
    end
    local avail = Global.getTable('available')
    if (avail[faction:sub(5,-1)] < 1) then return end
    local colors = Global.getTable('colors')
    bot = Global.getVar('bot')
    if not bot then
        if fan then
            bot_pieces = fan_bot_stuff
        else
            bot_pieces = bot_stuff
        end
        for _, v in ipairs(bot_pieces) do
            spawnObjectJSON({json=v})
        end
        Global.setVar('bot', true)
    end
    Global.call('FactionChosen', {faction:sub(5,-1)})
    local preferred_color = faction_colors[faction:sub(5,-1)..tostring(avail[faction:sub(5,-1)])]
    if not colors[preferred_color] then
        player.print("Preferred color for faction: "..faction.." alread taken.\nPlease pick another", red)
        chosen_faction = faction
        self.UI.setAttribute("factionsButtons", "active", "False")
        self.UI.setAttribute("botsButtons", "active", "False")
        self.UI.setAttribute("scenariosButtons", "active", "False")
        self.UI.setAttribute("rBotButtons", "active", "False")
        self.UI.setAttribute("fanButtons", "active", "False")
        self.UI.setAttribute("colorButtons", "active", "True")
        for k,v in pairs(colors) do
            self.UI.setAttribute(k, 'active', v)
        end
        return
    else
        spawnWithColor(faction, preferred_color)
    end
end

function spawnFanBot(player, faction)
    spawnBot(player, faction, true)
end

function spawnOfficialBot(player, faction)
    spawnBot(player, faction, false)
end

function spawnVagabond(player, vaga)
    if isSpectator(player) then
        broadcastToColor("Sit down first", player.color, "Red")
        return
    end
    avail = Global.getTable('available')
    if (avail[vaga] < 1) then return end
    Global.call('FactionChosen', {vaga})
    spawnFaction(vaga)
end

function spawnScenario(player, scenario)
    if isSpectator(player) then
        broadcastToColor("Sit down first", player.color, "Red")
        return
    end
    spawnHere(scenarios[scenario])
end

function spawnFaction(faction)
    spawnHere(factions[faction])
end

function showButtons()
    local avail = Global.getTable('available')
    for _, k in ipairs(buttons) do
        local set = false
        if (k:sub(1,-2)..tostring(avail[k:sub(1,-2)] or 0)  == k) or (k:sub(5,-2)..tostring(avail[k:sub(5,-2)] or 0) == k:sub(5,-1)) or (avail[k] and avail[k] > 0) then
            self.UI.setAttribute(k, 'active', true)
        else
            self.UI.setAttribute(k, 'active', false)
        end
    end
end

function deleteThis()
    Global.call('ImGone', {self})
    self.destruct()
end

function spawnHere(to_spawn)
    my_pos = self.getPosition()
    my_rot = self.getRotation()
    -- self.destruct()
    for _,v in ipairs(to_spawn) do
        local x = v.distance*math.sin(v.heading+(math.rad(my_rot.y)-math.pi)) + my_pos.x;
        local z = v.distance*math.cos(v.heading+(math.rad(my_rot.y)-math.pi)) + my_pos.z;
        local new_pos = {x, v.own_y, z}
        spawnObjectJSON({
            json              = v.json,
            position          = new_pos,
            callback_function = function(o) o.setRotation({o.getRotation().x, o.getRotation().y+my_rot.y+180, o.getRotation().z}) end
        })
    end
    Global.call('ImGone', {self})
    self.destruct()
end

function findClosestPosition()
    local own_pos = self.getPosition()
    local closest = nil
    local smallest_distance = 100000000
    local places = {{position={-50.00, 5.00, -64.50}, rotation={0, 0, 0}}, {position={0.00, 5.00, -64.50},  rotation={0, 0, 0}}, {position={50.00, 5.00, -64.50},  rotation={0, 0, 0}}, {position={50.00, 5.00, 64.50},  rotation={0.00, 180.00, 0.00}}, {position={0.00, 5.00, 64.50},  rotation={0.00, 180.00, 0.00}}, {position={-50.00, 5.00, 64.50},  rotation={0.00, 180.00, 0.00}}}
    for _, place in ipairs(places) do
        pos = place.position
        local distance = math.sqrt(math.pow(own_pos.x-pos[1], 2)+math.pow(own_pos.z-pos[3], 2))
        if distance < smallest_distance then
            smallest_distance = distance
            closest = place
        end
    end
    return closest
end

function none() end
