-- QUI 2 Input and Checkbox

-- See "OPTIMISE_ME.md" for optimising code below
PushDict(Templates, {
    ["CheckBox"] = function (x, y, obj, id)

        -- is registered
        if not _Data[id] then
            _Data[id] = { FuncOn = false, PrevClick = false }
        end

        -- is active
        if obj.Method == EnumCheckBoxMethod.ExternalInput then
            _Data[id].Value = gb(obj.ID)
        elseif obj.Method == EnumCheckBoxMethod.Variable then
            _Data[id].Value = obj.ID -- as variable
        else -- User click
            if IsInBox(x, y, obj.Width, obj.Height) then
                if not _Data[id].PrevClick then -- first click
                    _Data[id] = {
                        FuncOn = not _Data[id].FuncOn,
                        PrevClick = true,
                        Value = not _Data[id].FuncOn
                    }
                end
            else
                _Data[id].PrevClick = false
            end
        end

        -- Display
        if _Data[id].FuncOn or _Data[id].Value then
            DrawStyledText(x, y, obj.CharOn, obj.Width, obj.Height, obj.StyleOn)
        else
            DrawStyledText(x, y, obj.CharOff, obj.Width, obj.Height, obj.StyleOff)
        end

    end
})


---@enum CheckBoxMethod
EnumCheckBoxMethod = {
    -- CheckBox is readonly. It's state is the same as Boolean Channel Input
    ExternalInput = 0,
    -- CheckBox is readonly. It's state is the same as a given variable/value
    Variable = 2,
    -- CheckBox is mutable. The user decides of it's state.
    UserClick = 3
}


--- An advanced CheckBox. Just like HTML \<input type="checkbox">
---@param charOn string|nil This char will be displayed when the state is OFF
---@param charOff string|nil This char will be displayed when the state is ON
---@param width number|nil `Default = 9`
---@param height number|nil `Default = 9`
---@param styleOff Style Style of the unchecked checkbox
---@param styleOn Style Style of the checked checkbox
---@param method CheckBoxMethod `Default = UserClick` (propably what you want)
---@param channelOrIdOrVar number|any|boolean See `EnumCheckBoxMethod` comment
---@param isAnon boolean|nil?
---@return number|Object
function CheckBox(charOn, charOff, width, height, styleOff, styleOn, method, channelOrIdOrVar, isAnon)
    return Object("CheckBox", {
        CharOn = charOn or ' ', CharOff = charOff or ' ',
        Width = width or 9, Height = height or width,
        StyleOff = styleOff, StyleOn = styleOn,
        Method = method, ID = channelOrIdOrVar
    }, isAnon)
end


--- Draw an advanced CheckBox. Just like HTML \<input type="checkbox">
---@param x number Position
---@param y number Position
---@param charOn string|nil This char will be displayed when the state is OFF
---@param charOff string|nil This char will be displayed when the state is ON
---@param width number|nil `Default = 9`
---@param height number|nil `Default = 9`
---@param styleOff Style Style of the unchecked checkbox
---@param styleOn Style Style of the checked checkbox
---@param method CheckBoxMethod `Default = UserClick` (propably what you want)
---@param channelOrIdOrVar number|any|boolean See `EnumCheckBoxMethod` comment
function DrawCheckBox(x, y, id, charOn, charOff, width, height, styleOff, styleOn, method, channelOrIdOrVar)
    Draw(x, y,
        CheckBox(charOn, charOff, width, height, styleOff, styleOn, method, channelOrIdOrVar, true),
        id)
end