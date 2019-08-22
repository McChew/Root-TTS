tFactionValues = {}
--Style guidelines
-- prefix on all non-generic variables in camelCase (iNumber, sText...)
-- objects can use obj, of a acronym of the class-name
-- PascalCase for classes
-- camelCase for functoins
-- ideally single words for variables


-- Meta Class
FactionData = {
    max = 0,
    picked = 0,
    color = {},
    reach = {},
    variants = {}
}

--Constructor
-- either pass  color, reach for one faction
-- or {color, reach}, {color, reach} ... for multiple
-- main goal here is to keep faction creation as compact as possible
function FactionData:new(var_table, ...)
    local o = {}   
    
    setmetatable(o, self)
    self.__index = self

    o.variants = {}
    o.color = {}
    o.reach = {} 

    if(type(var_table) == "table") then -- we probably got max > 1
        o:addColor(var_table[1])
        o:addReach(var_table[2])
        if arg then
            for _, a in arg do
                o:addColor(a[1]) 
                o:addReach(a[2]) 
            end
        end
    else
        o.color = var_table
        if arg then
            o:setReach(arg) 
        end
    end
    return o
end

function FactionData:print()
  io.write("\nmax: "..self.max)
  io.write("\npicked: "..self.picked)
  for i, v in ipairs(self.reach) do
      io.write("\n"..i..". reach: "..v)
  end
  for i, v in pairs(self.variants) do
      io.write("\n\t"..i..": "..v)
  end
end

--------------------------------
---      Class Functions     ---
--------------------------------

--max
function FactionData:setMaxInstances(nAmount)
    self.max = nAmount
end

--color
function FactionData:addColor(...)
    for _, v in ipairs(arg) do 
        table.insert(self.color, v)
    end
end
function FactionData:setColors(...)
    self.color = arg
end

--reach
function FactionData:resetReach()
    self:setReach()
end
function FactionData:setReach(tGivenReach)
    if(atGivenReachg == nil) then
        self.reach = {}
    end
    self.reach = tGivenReach

    self:setMaxInstances(table.getn(self.reach))
end
function FactionData:addReach(...)
    for _, v in ipairs(arg) do 
        table.insert(self.reach, v)
    end

    self:setMaxInstances(table.getn(self.reach))
end
function FactionData:getCurrentReach()
    local nReachCount = table.getn(self.reach)
    local nTempReach = self.reach[self.picked+1]
    if(picked+1 <= nReachCount) then
        return nTempReach
    else
        return self.reach[nReachCount]
    end
end

--variants
function FactionData:addVariant(sVariantName, nMaxInstances)
    if not nMaxInstances then
        nMaxInstances = 1
    end
    self.variants[sVariantName] = nMaxInstances
end 
function FactionData:addVariants(...)
    for _,v in ipairs(arg) do
        self:addVariant(v)
    end
end

function FactionData:resetVariants()
    self.variants = {}
end

--pick
function FactionData:pick()
    if(self:isPickable()) then 
        self.picked = self.picked + 1
        return true
    end
    
    return false
end
function FactionData:unpick()
    if(self.picked > 0) then 
        self.picked = self.picked - 1
        return true
    end

    return false
end

function FactionData:isPickable()
    return (self.picked < self.max) and (self.max > 0)
end







--------------------------------
---   Data-Table Functions   ---
--------------------------------

--names
function getFactionList()
    local tNames = {}
    for name, o in pairs(tFactionValues) do
        if(o.max > 0) then
            table.insert(tNames, name)
        end
    end

    return tNames
end

--reach
function getPickableReachList()
    local tReachList = {}
    for name, object in pairs(tFactionValues) do
        if(object:isPickable()) then
            for i, r in ipairs(object.reach) do
                if(tReachList[name])  then
                    tReachList[name..i] = r
                else
                    tReachList[name] = r
                end
            end
        end
    end

    return tReachList
end

function getCurrentReach(sFactionName)
    return FactionData[sFactionName]:getCurrentReach()
end

--picking
function getPickableFactions()
    local tNames = {}
    for name, o in pairs(tFactionValues) do
        if(o:isPickable()) then
            table.insert(tNames, name)
        end
    end

    return tNames
end

function pickFaction(sFactionName)
    return tFactionValues[sFactionName]:pick()
end
function unpickFaction(sFactionName)
    return tFactionValues[sFactionName]:unpick()
end
function isFactionPickable(sFactionName)
    return tFactionValues[sFactionName]:isPickable()
end


--  Add Instances
local fdObjects = require("factionDataObjects")



--------------------------------
---  Testing/Debug Functions ---
--------------------------------
function testLoop()
    for name, object in pairs(tFactionValues) do
        io.write(name.." max: "..object.max.."\n")
        io.write("ReachValues: ")
        for _, v in ipairs(object.reach) do
            io.write(v.." ")
        end
        io.write("\n")
        for name, max in pairs(object.variants) do
            io.write("\t"..name.." max: "..max.."\n")
        end
        io.write("\n")
    end
end

function reachTest()
    io.write("\n\n\n\nReachlist:")
    for name, tReach in pairs(getPickableReachList()) do
            io.write("\n"..name..": "..tReach)            
    end
end


function outsideTest()
    io.write("\n\n"..tFactionValues.Marquise.reach[1])
    pickFaction("Marquise")
    pickFaction("Marquise")
    unpickFaction("Marquise")
    pickFaction("Eyrie")
    unpickFaction("Marquise")
    unpickFaction("Marquise")
end
testLoop()
--outsideTest()
--reachTest()