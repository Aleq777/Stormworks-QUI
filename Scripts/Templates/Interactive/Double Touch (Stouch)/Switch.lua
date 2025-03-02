--- QUI 2
--- Official Template: Switch
--- Author: @Aleq777
--- Includes:
---     Switch - a special type of button. By Touching (E or Q), you increase it's value. By Stouching (E and Q), you decrease it's value.
---@module 'Base' REQUIRED


---@section REMOVE THIS BEFORE COMPILATION

---@class SwitchState
---@field Text string
---@field Style Style
---@field Value any
__SwitchStates = { }

---@endsection Finish removing here

-- REWORK!! DISCORD CZY COŚ OPISAŁEM CO ZMIENIĆ

---@see OPTIMISE_ME.md
PushDict(Templates, {
    ["Switch"] = function (x, y, obj, id)

        local function indexOf(move)
            for k, v in pairs(obj.Content) do
                if v.Value == _Data[id].FuncOn then
                    return k + move
                end
            end

            return nil
        end

        -- is registered
        if not _Data[id] then
            _Data[id] = {
                FuncOn = obj.Content[1].Value,
                PrevClick = false
            }
        end

        -- Interactions
        if IsInBox2(x, y, obj.Width + x, obj.Height + y) then

            if not _Data[id].PrevClick then
                -- Previous state
                _Data[id] = {
                    FuncOn = obj.Content[ indexOf(-1) ].Value,
                    PrevClick = true
                }
            end

        elseif IsInBox(x, y, obj.Width + x, obj.Height + y) then

            if not _Data[id].PrevClick then
                -- Next state
                _Data[id] = {
                    FuncOn = obj.Content[ indexOf(1) ].Value,
                    PrevClick = true
                }
            end

        else
            _Data[id].PrevClick = false
        end

        -- Draw

        local current = obj.Content[indexOf(0)]
        DrawStyledText(x, y, current.Text, current.Style, obj.Width, obj.Height)

    end
})


--- Returns one of many possible switch states
---@param label string
---@param style Style
---@param value any
---@return SwitchState
---@nodiscard
function SwitchState(label, style, value)
    return {
        Text = label or value,
        Style = style,
        Value = value or label
    }
end


--- An advanced switch. When you Touch (E or Q), you forward it's state. When you Stouch (E and Q), you back it's state.
---@param width number|nil Leave nil for auto-size
---@param height number|nil Leave nil for auto-size
---@param switchContent SwitchState[]
---@param isAnon boolean|nil?
---@return number|Object
---@nodiscard
function Switch(width, height, switchContent, isAnon)
    return Object("Switch", {
        Width = width, Height = height,
        Content = switchContent or {
            [1] = {
                Text = "Off",
                Value = 0,
                Style = Style()
            },
            [2] = {
                Text = "Part",
                Value = 1,
                Style = Style()
            },
            [3] = {
                Text = "Full",
                Value = 2,
                Style = Style()
            }
        }
    }, isAnon)
end


--- Draw an advanced switch. When you Touch (E or Q), you forward it's state. When you Stouch (E and Q), you back it's state.
---@param x number Position
---@param y number Position
---@param width number|nil Leave nil for auto-size
---@param height number|nil Leave nil for auto-size
---@param switchContent SwitchState[]
function DrawSwitch(x, y, id, width, height, switchContent)
    Draw(x, y,
        Switch(width, height, switchContent),
        id
    )
end