--- QUI 2
--- Official Template: Button
--- Author: @Aleq777
--- Includes:
---     Button - a button that user can press. It can be push, pulse or toggle.
---@module 'Base' REQUIRED

require("Base")


---@alias ButtonMode
---| 0 # `Push`. Default. When you hold, function is active.
---| 1 # `Pulse`. When you hold, function is called once till you release and press again.
---| 2 # `Toggle`. When you hold, state of the button is toggled and repeats the function or stops it.


---@see OPTIMISE_ME.md
---@section "Button"

Templates["Button"] = function (x, y, obj, id)

    Register(id, Data(nil, false, false, false))

    local w = obj.Width or TextWidth(obj.Content)
    local h = obj.Height or 9 -- Borders are required for Buttons, even TRANSparent ones
    local data = _Data[id]

    ---@type ButtonMode
    obj.Mode = obj.Mode or 0
    obj.StyleOn.Border = obj.StyleOn.Border or obj.StyleOn.Back
    obj.StyleOff.Border = obj.StyleOff.Border or obj.StyleOff.Fore


    -- Touch logic

    -- Touched?
    local touch = IsInBox(x + 1, y + 1, w + x - 2, h + y - 2) -- borders are unclickable

    -- Push
    if obj.Mode == 0 then

        _Data[id] = Data(nil, touch, touch)

    else

        if touch and not data.PrevClick then

            -- Pulse
            if obj.Mode == 1 then

                data.FuncOn = not data.PrevClick

            -- Toggle
            else

                _Data[id] = Data(nil, not data.FuncOn, not data.FuncOn)

            end

        end

        data.PrevClick = touch

    end


    -- Draw
    DrawStyledText(x, y, obj.Content, data.Active and obj.StyleOn or obj.StyleOff, w, h)

    -- Execute
    if data.Active then
        Execute(obj.Func, obj.Args)
    end
end

---@endsection




---@section Button

--- Interactive text button, which interacts only with the Touch 1 (E or Q)
---@param title string
---@param styleOff Style Displays, when button is not pressed (or not active)
---@param styleOn Style Displays, when button is pressed or active
---@param width number|nil Leave `nil`, if you want auto-size
---@param height number|nil Leave `nil`, if you want auto-size
---@param mode ButtonMode|nil `Default = Push`
---@param func function The function to call, when button is activated
---@param args table|nil? Arguments for the function. Leave nil or empty table, if none
---@param isAnon boolean|nil?
---@return number|Object
---@nodiscard
function Button(title, styleOff, styleOn, width, height, mode, func, args, isAnon)
    return Object("Button", {
        Content = title,
        Width = width, Height = height,
        StyleOff = styleOff, StyleOn = styleOn,
        Mode = mode,
        Func = func, Args = args,
        ID = nil
    }, isAnon)
end

---@endsection



---@section DrawButton

--- Draw an interactive text button, which interacts only with the Touch 1 (E or Q)
---@param x number Position
---@param y number Position
---@param id any ID of the button's data
---@param title string
---@param styleOff Style Displays, when button is not pressed (or not active)
---@param styleOn Style Displays, when button is pressed or active
---@param width number|nil Leave `nil`, if you want auto-size
---@param height number|nil Leave `nil`, if you want auto-size
---@param mode ButtonMode|nil `Default = Push`
---@param func function The function to call, when button is activated
---@param args table|nil? Arguments for the function. Leave nil or empty table, if none
function DrawButton(x, y, id, title, styleOff, styleOn, width, height, mode, func, args)
    Draw(x, y,
        Button(title, styleOff, styleOn, width, height, mode, func, args, true),
        id
    )
end

---@endsection