--- QUI 2
--- Official Template: Limit
--- Author: @Aleq777
--- Includes:
---     Limit - Simple limit "x/y", which you may need for speed etc.
---@module 'Base' REQUIRED



---@see OPTIMISE_ME.md
PushDict(Templates, {
    ["Limit"] = function (x, y, obj)
        obj.Value1 = tostring(obj.Value1)

        local w = TextWidth(obj.Value1)

        DrawStyledText(x, y, obj.Value1, obj.IsActive and obj.StyleActive or obj.Style1, nil, 5)
        DrawStyledText(x + w + 1, y, '/', obj.Style1, nil, 5)
        DrawStyledText(x + w + 6, y, tostring(obj.Value2), obj.Style2, nil, 5)
    end
})


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
---@nodiscard
function Limit(value1, value2, isActive, style1, style2, styleActive, isAnon)
    return Object("Limit", {
        Value1 = value1,    Value2 = value2,   IsActive = isActive,
        Style1 = style1,    Style2 = style2,   StyleActive = styleActive
    }, isAnon)
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