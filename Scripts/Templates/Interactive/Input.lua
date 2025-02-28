-- QUI 2 Input and Checkbox
--- REQUIRED: "Base.lua"

-- See "OPTIMISE_ME.md" for optimising code below
PushDict(Templates, {
    ["Input"] = function (x, y, obj, id)

        local isExternal, active = obj.Method == EnumInputMethod.ExternalInput, nil

        -- is active
        if isExternal then
            active = false -- always active
        else
            active = ActiveInputID == id -- only when is active duh
        end

        -- Is registered
        if not _Data[id] then
            _Data[id] = {
                Value = 0
            }
        end

        -- Update
        if isExternal then
            _Data[id].Value = gn(obj.ID)
        else
            if active then
                _Data[id].Value = _Data[obj.ID].Value
            end
        end

        -- Display
        local size, w = "", nil
        for i = 1, obj.Size do
            size = size .. " "
        end

        w = TextWidth(size)
        DrawStyledText(x, y, _Data[id].Value, active and obj.StyleOn or obj.StyleOff, w)

    end
})


---@type number ID of the selected input for the KeyPad
ActiveInputID = nil


---@enum InputMethod
EnumInputMethod = {
    -- Number Channel Input
    ExternalInput = 0,
    -- REQUIRED: "Templates/KeyPad.lua"
    -- Best to use with digital KeyPad
    KeyPadID = 1,
}


-- REWORK !!! - use sclamp !!!

--- Input. Just like HTML \<input type="number">
---@param charSize number Character limit
---@param styleOff Style Unselected input style (and for `InputMethod.ExternalInput`)
---@param styleOn Style Selected input style (only for `InputMethod.KeyPadID`)
---@param method InputMethod
---@param channelOrId number|any # <ul> <li>`ExternalInput` -> Number Channel Input</li> <li>`KeyPadID` -> ID of the KeyPad data</li> </ul>
---@param isAnon boolean|nil?
---@return number|Object
function Input(charSize, styleOff, styleOn, method, channelOrId, isAnon)
    return Object("Input", {
        Size = charSize,
        StyleOff = styleOff, StyleOn = styleOn,
        Method = method,     ID = channelOrId
    }, isAnon)
end


--- Input. Just like HTML \<input type="number">
---@param x number Position
---@param y number Position
---@param charSize number Character limit
---@param styleOff Style Unselected input style (and for `InputMethod.ExternalInput`)
---@param styleOn Style Selected input style (only for `InputMethod.KeyPadID`)
---@param method InputMethod
---@param channelOrId number|any # <ul> <li>`ExternalInput` -> Number Channel Input</li> <li>`KeyPadID` -> ID of the KeyPad data</li> </ul>
function DrawInput(x, y, id, charSize, styleOff, styleOn, method, channelOrId)
    Draw(x, y,
        Input(charSize, styleOff, styleOn, method, channelOrId, true),
        id)
end