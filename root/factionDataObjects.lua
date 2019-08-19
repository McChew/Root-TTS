--------------------------------
---  Instances (Actual Data) ---
--------------------------------

--Our special snowflake gets a few lines
va = FactionData:new(5, 2)
va:addVariants("Thief", "Tinker", "Scoundrel", "Arbiter", "Ranger", "Vagrant")
va:addVariant("Thief", 5)
tFactionValues["Vagabond"] = va

--all others get one, get real ppl
tFactionValues["Corvid"]        = FactionData:new(3)
tFactionValues["Duchy"]         = FactionData:new(8)
tFactionValues["Eyrie"]         = FactionData:new(7)
tFactionValues["Lizard"]        = FactionData:new(2)
tFactionValues["Marquise"]      = FactionData:new(10)
tFactionValues["Riverfolk"]     = FactionData:new(5)
tFactionValues["Woodland"]      = FactionData:new(3)

--These have no reach yet, so they have max=0 as well, and wont show up in interface
tFactionValues["Arachnid"]      = FactionData:new()
tFactionValues["Boars"]         = FactionData:new()
tFactionValues["Fangus"]        = FactionData:new()
tFactionValues["WeeklyCroak"]   = FactionData:new()


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
