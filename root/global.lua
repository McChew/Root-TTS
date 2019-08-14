

colors = {Blue=true, Orange=true, Teal=true, Yellow=true, Green=true,
          Purple=true, White=true, Red=true, Brown=true, Pink=true}

factionboards = {}
bot = false
-- par = {factionboard instance}
function ImHere(par)
    factionboards[#factionboards+1] = par[1]
end

-- par = {factionboard instance}
function ImGone(par)
    local where = 0
    for x=1, #factionboards do
        if factionboards[x] == par[1] then
            where = x
        end
    end
    table.remove(factionboards, where)
end

-- par = {faction}
function FactionChosen(par)
    local faction = par[1]
    available[faction] = available[faction] -1
    ShowAllButtons()
end

function ShowAllButtons()
    for _, x in ipairs(factionboards) do
        x.call('showButtons', {})
    end
end

function SetupQuests()
    local quest_board = getObjectFromGUID('afea2f')
    local quest_deck = getObjectFromGUID('cc5741')
    if available.Vagabond == 2 then
        quest_board.destruct()
        quest_deck.destruct()
    else
        quest_deck.shuffle()
        local positions = {{32.98, 1.61, -2.89},
                     {32.98, 1.61, 2.97},
                     {32.99, 1.61, 8.90}}
        local params = {}
        params.smooth = true
        params.flip = true
        for _, x in ipairs(positions) do
            params.position  = x
            quest_deck.takeObject(params)
        end
    end
end
