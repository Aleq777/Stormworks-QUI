-- QUI 2 Text Formats
--- REQUIRED "Base.lua"

-- See "OPTIMISE_ME.md" for optimising code below
PushDict(Templates, {
    -- REWORK !!!
    ["Title"] = function (x, y, obj)
        local w = TextWidth(obj.Text)

        DrawTrigLine(x, y, 270, 5, obj.Style.Border)
        DrawStyledText(x + 2, y, obj.Text, Style(obj.Style.Fore, obj.Style.Back), nil, 5)

        if obj.Style.Decor == EnumTitleStyles.Fancy then
            DrawBox(x + 4 + w, y, WIDTH - (x + 4 + w), 5, Style(nil, obj.Style.Border))
        end
    end,
    ["Limit"] = function (x, y, obj)
        obj.Value1 = tostring(obj.Value1)

        local w = TextWidth(obj.Value1)

        DrawStyledText(x, y, obj.Value1, obj.IsActive and obj.StyleActive or obj.Style1, nil, 5)
        DrawStyledText(x + w + 1, y, '/', obj.Style1, nil, 5)
        DrawStyledText(x + w + 6, y, tostring(obj.Value2), obj.Style2, nil, 5)
    end,
    -- REWORK !!!
    ["Clock"] = function (x, y, obj)
        -- mode depends
    end
})


--- Styled title with width of the screen.
---@param title string
---@param style Style
---@param isAnon boolean|nil?
---@return number|Object
function Title(title, style, isAnon)
    return Object("Title", {
        Text = title,
        Style = style
    }, isAnon)
end


--- Draw a limit "a/b"
--- - example: `000 / 000`
---@param value1 any First value to display
---@param value2 any Second value to display
---@param isActive boolean|nil Toggles style of first value. E.g., when value is exceeded, you can switch style to red
---@param style1 Style Default style of first value and the slash '/'
---@param style2 Style Style of second value
---@param styleActive Style Activated style of first value
---@param isAnon boolean|nil?
---@return number|Object
function Limit(value1, value2, isActive, style1, style2, styleActive, isAnon)
    return Object("Limit", {
        Value1 = value1, Value2 = value2, IsActive = isActive,
        Style1 = style1, Style2 = style2, StyleActive = styleActive
    }, isAnon)
end


-- REWORK !!! - time (12/24), stopwatch
---@enum ClockType
EnumClockType = {
    -- hh:mm - 00:00 - 12:59
    HourMinute = 0,
    -- hh:mm:ss - 00:00:00 - 12:59:59
    HourMinuteSecond = 1,
    -- hh:mm:ss.ms - 00:00:00.000 - 12:59:59.999
    HourMinuteSecondMilis = 2,
    -- hh:mm t - 00:00 AM - 12:59 PM
    HourMinuteAMPM = 3,
    -- hh:mm:ss t - 00:00:00 AM - 12:59:59 PM
    HourMinuteSecondAMPM = 4,
    HourMinute24 = 6,
    HourMinuteSecond24 = 7,
    HourMinuteSecondMilis24 = 8
}

--- Simple digital clock
---@param timeMS integer Time in miliseconds (1h = 3.600.000)
---@param mode ClockType
---@param style Style
---@param isAnon boolean|nil?
---@return number|Object
function Clock(timeMS, mode, style, isAnon)
    return Object("Clock", {
        Time = timeMS,
        Mode = mode,
        Style = style
    }, isAnon)
end



--- Draw styled title with width of the screen.
---@param x number Position
---@param y number Position
---@param title string
---@param style Style
function DrawTitle(x, y, title, style)
    Draw(x, y,
        Title(title, style, true)
    )
end


--- Draw a limit "a/b"
--- - example: `000 / 000`
---@param x number Position
---@param y number Position
---@param value1 any First value to display
---@param value2 any Second value to display
---@param isActive boolean|nil Toggles style of first value. E.g., when value is exceeded, you can switch style to red
---@param style1 Style Default style of first value and the slash '/'
---@param style2 Style Style of second value
---@param styleActive Style Activated style of first value
function DrawLimit(x, y, value1, value2, isActive, style1, style2, styleActive)
    Draw(x, y,
        Limit(value1, value2, isActive, style1, style2, styleActive, true)
    )
end


-- REWORK !!!
--- Draw a simple digital clock
---@param x number Position
---@param y number Position
---@param timeMS integer Time in miliseconds (1h = 3.600.000)
---@param mode ClockType
---@param style Style
function DrawClock(x, y, timeMS, mode, style)
    Draw(x, y,
        Clock(timeMS, mode, style, true)
    )
end