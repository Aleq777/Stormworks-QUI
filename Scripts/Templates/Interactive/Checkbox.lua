--- QUI 2
--- Official Template: Checkbox
--- Author: @Aleq777
--- Includes:
---     Checkbox - Like HTML <select type="checkbox">. It's a square/rectangle, that can be checked by the user or other data.
---@module 'Base' REQUIRED


---@see OPTIMISE_ME.md
PushDict(Templates, {
    ["Checkbox"] = function (x, y, obj, id)

        -- is registered
        if not _Data[id] then
            _Data[id] = { FuncOn = false, PrevClick = false }
        end

        ---@type CheckboxMethod
        obj.Method = obj.Method or 0

        -- is active
        -- ExternalInput
        if obj.Method == 0 then
            _Data[id].Value = gb(obj.ID)
        -- Variable
        elseif obj.Method == 1 then
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


---@alias CheckboxMethod
---| 0 # `ExternalInput` - CheckBox is readonly. It's state is the same as Boolean Channel Input.
---| 1 # `Variable` - CheckBox is readonly. It's state is the same as a given variable/value.
---| 3 # `UserClick` - CheckBox is mutable. The user decides of it's state.


--- An advanced CheckBox. Just like HTML \<input type="checkbox">
---@param charOn string|nil This char will be displayed when the state is OFF
---@param charOff string|nil This char will be displayed when the state is ON
---@param width number|nil `Default = 9`
---@param height number|nil `Default = 9`
---@param styleOff Style Style of the unchecked checkbox
---@param styleOn Style Style of the checked checkbox
---@param method CheckboxMethod `Default = UserClick` (propably what you want)
---@param channelOrIdOrVar number|any|boolean See `EnumCheckBoxMethod` comment
---@param isAnon boolean|nil?
---@return number|Object
---@nodiscard
function Checkbox(charOn, charOff, width, height, styleOff, styleOn, method, channelOrIdOrVar, isAnon)
    return Object("Checkbox", {
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
---@param method CheckboxMethod `Default = UserClick` (propably what you want)
---@param channelOrIdOrVar number|any|boolean See `EnumCheckBoxMethod` comment
function DrawCheckbox(x, y, id, charOn, charOff, width, height, styleOff, styleOn, method, channelOrIdOrVar)
    Draw(x, y,
        Checkbox(charOn, charOff, width, height, styleOff, styleOn, method, channelOrIdOrVar, true),
        id)
end