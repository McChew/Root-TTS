
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


function addUIElementAtPath(tUIE, ...) --the vararg is used for path nodes
    tFinalNode = {}
    for _, tNode do
        tNode.tag 
    end
    tables.push(tNode, tUIE) 
end