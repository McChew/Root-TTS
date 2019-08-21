--------------------------------
---  Instances (Actual Data) ---
--------------------------------

--Our special snowflake gets a few lines
local va = FactionData:new({"#dbdbdb", 5}, {"gray", 2})
va:addVariants("Thief", "Tinker", "Scoundrel", "Arbiter", "Ranger", "Vagrant")
--va:addVariant("Thief", 5) --example for different max on variant
tFactionValues["Vagabond"] = va

--all others get one, get real ppl
tFactionValues["Corvid"]        = FactionData:new("purple",3)
tFactionValues["Duchy"]         = FactionData:new("brown", 8)
tFactionValues["Eyrie"]         = FactionData:new("blue", 7)
tFactionValues["Lizard"]        = FactionData:new("yellow", 2)
tFactionValues["Marquise"]      = FactionData:new("#f78b18", 10)
tFactionValues["Riverfolk"]     = FactionData:new("#47f8ff", 5)
tFactionValues["Woodland"]      = FactionData:new("green", 3)

--These have no reach yet, so they have max=0 as well, and wont show up in interface
tFactionValues["Arachnid"]      = FactionData:new("blue")
tFactionValues["Boars"]         = FactionData:new("brown")
tFactionValues["Fangus"]        = FactionData:new("red")
tFactionValues["WeeklyCroak"]   = FactionData:new("white")


faction_colors = {}
faction_colors.Eyrie = "Blue"
faction_colors.Marquise = "Orange"
faction_colors.Riverfolk = "Teal"
faction_colors.Lizard = "Yellow"
faction_colors.Woodland = "Green"
faction_colors.Corvid = "Purple"
faction_colors.Vagabond2 = "White"
faction_colors.Vagabond = "Red"
faction_colors.Duchy = "Brown"
faction_colors.Fangus = "Pink"
faction_colors.Arachnid = "Purple"
faction_colors.WeeklyCroak = "Green"
faction_colors.Boars = "Brown"


--non-custom pawns  -- just an idea
--spawnObject("pawn", callbackFunction={setColorTint(factionColor)})
