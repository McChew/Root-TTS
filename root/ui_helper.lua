txmltest={
    {
        tag="HorizontalLayout",
        attributes={
            height=200,
            width=1000,
            color="rgba(0,0,0,0.7)",
        },
        children={
            {
                tag="Text",
                attributes={
                    fontSize=100,
                    color="red",
                },
                value="Example",
            },
            {
                tag="Text",
                id="hi",
                attributes={
                    text="Message",
                    fontSize=100,
                    color="blue",
                },
            },
        }
    }
}

function getXmlTable()
  return txmltest
end

function getFactionButton(sFName, sColor)
    return "{
        tag=\"Cell\"
        id=\""..sFName.."\"
        children={
            {
                tag=\"Button\"
                class=\"mapButton\"
                onClick=\"spawnFunction("..sFName..")
                color=\""..sColor.."\"
                children={
                    {
                        tag=\"Image\"
                        class=\"mapImage\"
                        image="..sFName.."-button\"
                    }
                }
            }
        }
    }"
end


--adds the new UI as children to the first element with matching ID
-- tNewUi: ui code as lua table
-- sID: unique ID of interface element
-- xmlUI leave empty, or provide current wip-ui
function addUIElementAtID(tNewUi, sID, tXmlUi) 
    for _, v in ipairs(tXmlUi or UI.getXmlTable()) do  
        if(v.id == sID) then
            v.children = v.children or {}
            table.insert(v.children, tNewUi) 

            return true, tXmlUI
        end 

        if(v.children) then
            return addUIElementAtID(tNewUi, sID, v.children)
        end
    end

    return false, tXmlUI
end

addUIElementAtID({tag="te3xt", lol="fufufu"}, "hi")