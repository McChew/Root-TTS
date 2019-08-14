-- fixed reach values
tReachToReach = {}
tReachToReach[2] = 17
tReachToReach[3] = 18
tReachToReach[4] = 21
tReachToReach[5] = 25
tReachToReach[6] = 28

-- define factions here if you want to include them in the calculations
tReach = {
    Marquise = 10,
    Duchy = 8,
    Eyrie = 7,
    Vagabond = 2,
    Riverfolk = 5,
    Woodland = 3,
    Corvid = 3,
    Lizard = 2
}
-- counts seatet players, without spectators
nPlayerCount = 0



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
    nPlayerCount = 2 -- #getPlayers()
    checkForValidPicks( )
end


function checkForValidPicks( )
    local nReachToReach = tReachToReach[nPlayerCount]
    local tPicked = {}

    -- to know if a pick is valid we create different table setups
    -- and then check if this assumed setup is valid
    for i, v in pairs(tReach) do
        if(v ~= nil) then          
            local tTemp = sCopy(tReach)
            tTemp[i] = nil
            if( false == validateSetup(tTemp, v, nPlayerCount-1) ) then
                tReach[i] = nil
            else
                tPicked[i] = v
            end
        end
    end

    io.write("Picked Factions:")
    for i, v in pairs(tPicked) do
      if v~=nil then 
        io.write(" >"..i.."< ")
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

            if( nTemp >= tReachToReach[nPlayerCount]) then
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



-- Returns a shallow copy of given parameter
-- based on https://stackoverflow.com/a/12397742
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