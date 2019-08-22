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

function getFactionCell(sFName, factionData)
    return [[{
    tag="Cell"
    id="]]..sFName..[[_cell"
    children={
    ]]..getFactionButtons(sFName, factionData)..[[

    }
  }
  ]]
end

function getFactionButtons(sFName, factionData)
        sReturn = ""

        for i=1, factionData.max do
            sReturn=sReturn..[[
{
      tag="Button"
      class="mapButton"
      onClick="spawnFunction(]]..sFName..[[)"
      color="]]..factionData.color[i]..[["
      children={
          {
            tag="Image"
            id="]]..sFName..[[_image"
            class="mapImage"
            image="]]..sFName..[[-button"
          }
        }
      }]]
        end
    return sReturn
end

io.write(getFactionCell("Marquise", {max=2, color={"red","white"}}))


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