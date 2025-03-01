--- QUI 2
--- Official Template: Formatted Texts
--- Author: @Aleq777
--- Includes:
---     Title - Perfect for sectioning your UI
---@module 'Base' REQUIRED



---@see OPTIMISE_ME.md
PushDict(Templates, {
    -- REWORK !!!
    ["Title"] = function (x, y, obj)
        local w = TextWidth(obj.Text)

        DrawTrigLine(x, y, 270, 5, obj.Style.Border)
        DrawStyledText(x + 2, y, obj.Text, Style(obj.Style.Fore, obj.Style.Back), nil, 5)

        if obj.Style.Decor == 'f' then
            DrawBox(x + 4 + w, y, WIDTH - (x + 4 + w), 5, Style(nil, obj.Style.Border))
        end
    end
})


---@alias TitleStyle
---| 'i' # Title: Simple
---| 'f' # Title: Fancy


--- Styled title with width of the screen.
---@param title string
---@param style Style
---@param isAnon boolean|nil?
---@return number|Object
---@nodiscard
function Title(title, style, isAnon)
    return Object("Title", {
        Text = title,
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