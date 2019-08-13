-- fixed reach values
tReachToReach = {
    2 = 17,
    3 = 18,
    4 = 21,
    5 = 25,
    6 = 28
}
nPlayerCount = 5

-- define factions here if you want to include them in the calculations
tReach = {
    Marquise = 10,
    Duchy = 8,
    Eyrie = 7,
    Vagabond1 = 2,
    Riverfolk = 5,
    Woodland = 3,
    Corvid = 3,
    Vagabond2 = 2,
    Lizard = 2
}

function onLoad(){
   -- obsolete, rather have a specific table with no cross references

   -- import the table with available factions, then construct our own table
   -- tAvail = global.getTable("available")
   -- tPossible = {}
   -- for i, v in ipairs(tAvail){
   --     if(tReach[i] != nil)
   --         tPossible[i] = tReach[i]
   -- }
}


function checkForValidPick(){
    nReachToReach = tReachToReach[nPlayerCount]


    -- to know if a pick is valid we create different table setups
    -- and then check if this assumed setup is valid
    for i, v in ipairs tPossible{
        if(v != nil){
            nTemp = nReachToReach - v
            tTemp = sCopy(tPossible)
            tTemp[i] = nil

            if( !validateSetup(tTemp, nTemp) )
                tPossible[i] = nil
        }
    }

    
}



-- tPoss = still possible factions
-- nPsf  = points so far
function validateSetup(tPoss, nPsf){
    for i, v in ipairs(tPoss){
        if(v != nil){
            nTemp = nPsf - v
            tTemp = sCopy(tPoss)
            tTemp[i] = nil

            if( validateSetup(tTemp, nTemp) )
                return true;        
        }
    }
    
    return false
}



-- Returns a shallow copy of a table
-- https://stackoverflow.com/a/12397742
function sCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end