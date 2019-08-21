
-- Add custom xml       --- REWORK FOR XML PATH ?
function addInterfaceElement(tUIElement)

    tXML = getXmlTable()

    for gEl, gElTable in tUIElement do --go through given table and extract main components
        for element, table in tXML do  --look at main components of current ui
            if element.tag = tUIElement[gEl].tag then -- append the current ui with the new components
                tables.push(element.children, table)
            end
        end
    end
end


tPathFaction = {}

--adds the new UI as children to the first element with matching ID
-- tNewUi: ui code as lua table
-- sID: unique ID of interface element
-- xmlUI leave empty, or provide current wip ui
function addUIElementAtID(tNewUi, sID, xmlUi) 
    tFinalNode = {}
    for _, v in (xmlUi or getXmlTable()) do
        if(v.id == sID) then
            tables.push(v.children, tNewUi) 
            return true
        end 

        if(type(v) == 'table') then
            return addUIElementAtID(tNewUi, sID, v)
        end
    end

    return false
end