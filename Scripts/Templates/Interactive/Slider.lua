-- QUI 2 Slider (range)
--- REQUIRED: "Base.lua"

-- REWORK !!!


---@diagnostic disable:duplicate-doc-alias


-- See "OPTIMISE_ME.md" for optimising code below
PushDict(Templates, {
    ["Slider"] = function (x, y, obj, id)

        -- is registered
        if not _Data[id] then
            _Data[id] = {
                Value = obj.Default
            }
        end

        -- Interaction

        local valueX, valueY -- = (TouchX - x) / obj.Width, (TouchY - y) / obj.Height

        -- Checks and updates value
        local function isCorrect(appendValue)
            if InSpan(0, 1, valueX) and InSpan(0, 1, valueY) then
                _Data[id].Value = appendValue
            end
        end

        if IsInBox(x, y, obj.Width, obj.Height) then

            if obj.Direction == EnumBarDirection.Right then

                valueX = (TouchX - x) / obj.Width
                valueY = (TouchY - y) / obj.Height

                isCorrect(valueX)

            elseif obj.Direction == EnumBarDirection.Down then

                valueX = (TouchX - x) / obj.Width
                valueY = (TouchY - y) / obj.Height

                isCorrect(valueY)

            elseif obj.Direction == EnumBarDirection.Left then

                valueX = 1 - (TouchX - x) / obj.Width
                valueY = (TouchY - y) / obj.Height

                isCorrect(valueX)

            else

                valueX = (TouchX - x) / obj.Width
                valueY = 1 - (TouchY - y) / obj.Height

                isCorrect(valueY)

            end

        end

        -- Draw
        local v = ZeroOne(obj.Min, obj.Max, _Data[id].Value)

        DrawBar(x, y, obj.Width, obj.Height, v, obj.Direction, obj.Style)

        if obj.SliderObj then

            local prop = PropertiesOf(obj.SliderObj)

            if obj.Direction == EnumBarDirection.Right then
                ---@diagnostic disable-next-line:undefined-field
                Draw(x + v * obj.Width - prop.Width / 2, y - prop.Height / 2, prop) -- obj.Width is the width of the funny bar line, prop.Width is the width of the SliderObj like a pointer or smth
            elseif obj.Direction == EnumBarDirection.Down then
                ---@diagnostic disable-next-line:undefined-field
                Draw(x - prop.Width / 2, y + v * obj.Height - prop.Height / 2, prop)
            elseif obj.Direction == EnumBarDirection.Left then
                ---@diagnostic disable-next-line:undefined-field
                Draw(x - obj.Width * (1 - v) - prop.Width / 2, y - prop.Height / 2, prop)
            else
                ---@diagnostic disable-next-line:undefined-field
                Draw(x - prop.Width / 2, y + obj.Height * (1 - v) - prop.Height / 2, prop)
            end

        end

    end
})


---@enum BarDirection
EnumBarDirection = {
    Up = 0,
    Right = 1,
    Down = 2,
    Left = 3
}


--- A slider. Like in HTML input range
---@param width number
---@param height number
---@param box Object|number|nil? If you want to display a box in the place of current value
---@param style Style Fore - filled color, Back - unfilled color, Border? - border
---@param direction BarDirection
---@param min number|nil Minimal value `Default = 0`
---@param max number|nil Maximal value `Default = 1`
---@param step number --- maybe ill delete this
---@param default number Default value `Default = min`
---@param isAnon boolean|nil?
---@return number|Object
function Slider(width, height, box, style, direction, min, max, step, default, isAnon)
    return Object("Slider", {
        Width = width, Height = height,
        SliderObj = box,
        Direction = direction,
        Min = min or 0, Max = max or 1, Step = step,
        Default = default or min or 0,
        Style = style
    }, isAnon)
end

--- Draw a slider. Like in HTML input range
---@param width number
---@param height number
---@param box Object|number|nil? If you want to display a box in the place of current value
---@param style Style Fore - filled color, Back - unfilled color, Border? - border
---@param direction BarDirection
---@param min number|nil Minimal value `Default = 0`
---@param max number|nil Maximal value `Default = 1`
---@param step number --- maybe ill delete this
---@param default number Default value `Default = min`
function DrawSlider(x, y, id, width, height, box, style, direction, min, max, step, default)
    Draw(x, y,
        Slider(width, height, box, style, direction, min, max, step, default, true),
        id)
end