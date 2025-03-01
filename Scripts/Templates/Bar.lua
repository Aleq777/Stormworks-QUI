--- QUI 2
--- Official Template: Bar
--- Author: @Aleq777
--- Includes:
---     Bar - Like gauge, fills up and shows current value
---@module 'Base' REQUIRED

---@diagnostic disable:duplicate-doc-alias


---@alias BarDirection
---| 0 # Up
---| 1 # Right
---| 2 # Down
---| 3 # Left


---@see OPTIMISE_ME.md
PushDict(Templates, {
    ["Bar"] = function (x, y, obj)
        local a, z = obj.Style.Border and 1 or 0, Style(nil, obj.Style.Fore)

        ---@type BarDirection
        obj.Direction = obj.Direction or 0

        DrawBox(x, y, obj.Width, obj.Height, obj.Style)

        -- Left
        if obj.Direction == 3 then

            DrawBox(x + obj.WIDTH * (1 - obj.Value) + a, y + a, obj.Width * (1 - obj.Value) - 2 * a, obj.Height - 2 * a, z)

        elseif obj.Direction == 1 then -- Right

            DrawBox(x + a, y + a, obj.Width * obj.Value - 2 * a, obj.Height - 2 * a, z)

        elseif obj.Direction == 2 then -- Down

            DrawBox(x + a, y + a, obj.Width - 2 * a, obj.Height * obj.Value - 2 * a, z)

        else -- up, default

            DrawBox(x + a, y + obj.Height * obj.Value + a, obj.Width - 2 * a, obj.Height * (1 - obj.Value) - 2 * a, z)

        end
    end
})


--- A bar. Works like a gauge.
---@param width number
---@param height number
---@param value number 0.0 to 1.0
---@param direction BarDirection
---@param style Style Fore - filled color, Back - empty color, Border? - border
---@param isAnon boolean|nil?
---@return number|Object
function Bar(width, height, value, direction, style, isAnon)
    return Object("Bar", {
        Width = width,      Height = height,
        Direction = direction,      Value = value,
        Style = style
    }, isAnon)
end


--- Draw a bar. Works like a gauge.
---@param x number Position
---@param y number Position
---@param width number
---@param height number
---@param value number 0.0 to 1.0
---@param direction BarDirection
---@param style Style Fore - filled color, Back - empty color, Border? - border
function DrawBar(x, y, width, height, value, direction, style)
    Draw(x, y,
        Bar(width, height, value, direction, style, true)
    )
end