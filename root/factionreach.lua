-- fixed reach values
tReachByPlayerCount = {0, 17,18,21,25,28}
require("factionDataClass")

tFactionValues["Eyrie"]:print()

-- counts seatet players, without spectators
nPlayerCount = 2



function onPlayerChangeColor(sPlayerColor)
    updateReachMax()
end
function onPlayerDisconnect()
    updateReachMax()
end
function onPlayerConnect()
    updateReachMax()
end

function updateReachMax()
    -- #getPlayers()
    checkForValidPicks( )
end


function checkForValidPicks( )
    tReach = getPickableReachList()
    local nReachToReach = tReachByPlayerCount[nPlayerCount]
    local tPicked = {}

    -- to know if a pick is valid we create different table setups
    -- and then check if this assumed setup is valid
    for i, v in pairs(tReach) do
        if(v ~= nil) then          
            local tTemp = sCopy(tReach)
            tTemp[i] = nil
            if(  validateSetup(tTemp, v, nPlayerCount-1) ) then
                tPicked[i] = v
            else
                tReach[i] = nil
            end
        end
    end

    io.write("\n\n\nPickable Factions:")
    for i, v in pairs(tPicked) do
      if v~=nil then 
        io.write("\n"..i)
      end
    end

    -- updateAllButtons!?
end


-- The following code could be streamlined to be more efficient,
-- but this way we dont have to care for sorting the reach-table
-- tPoss = still possible factions
-- nPsf  = points so far
-- nPltp = Players left to pick
function validateSetup(tPoss, nPsf, nPltp)
    for i, v in pairs(tPoss) do
        if(v ~= nil) then
            local tTemp = sCopy(tPoss)
            if(nPltp <= 0) then
              return false
            end
            
            local nTemp = nPsf + v

            if( nTemp >= tReachByPlayerCount[nPlayerCount]) then
                return true
            end
            
            -- new assumed score is not high enough so we clone the table and pick another faction from it
            tTemp[i] = nil
            --io.write("nested:")
            if( validateSetup(tTemp, nTemp, nPltp-1) ) then
                return true -- subsequent picks proved to be enough
            else
                tPoss[i] = nil --none of the following picks made our result valid
            end
        end
    end
    
    return false -- no picks (nor their subsequent picks) managed to achieve our reach
end



-- Returns a 1 layer deep copy of given parameter
function sCopy(orig)
    local orig_type = type(orig)
    local copy
    if(orig_type == 'table') then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value 
        end
    else -- number, string, boolean, etc
        copy = orig
    end  
    return copy
end
onPlayerChangeColor("white")