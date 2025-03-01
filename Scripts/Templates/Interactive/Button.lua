--- QUI 2
--- Official Template: Button
--- Author: @Aleq777
--- Includes:
---     Button - a button that user can press. It can be push, pulse or toggle.
---@module 'Base' REQUIRED

--- REWORK !!!

---@see OPTIMISE_ME.md
PushDict(Templates, {
    ["Button"] = function (x, y, obj, id)
        if not _Data[id] then
            _Data[id] = { Active = false, FuncOn = false, PrevClick = false }
        end

        local w = obj.Width or TextWidth(obj.Text)
        local h = obj.Height or 5

        -- If clicked

        local touch = IsInBox(x + 1, y + 1, obj.Width + x - 1, obj.Height + y - 1) -- borders are unclickable

        ---@type ButtonMode
        obj.Mode = obj.Mode or 0

        -- Pulse
        if obj.Mode == 1 then

            if touch then

                _Data[id].Active = true

                if not _Data[id].PrevClick then

                    _Data[id].FuncOn = true
                    _Data[id].PrevClick = true

                else
                    _Data[id].FuncOn = false
                end

            else

                _Data[id].PrevClick = false

            end

        elseif obj.Mode == 2 then -- Toggle

            if touch then

                if not _Data[id].PrevClick then -- first pulse
                    _Data[id] = {
                        Active = not _Data[id].FuncOn,
                        FuncOn = not _Data[id].FuncOn,
                        PrevClick = true
                    }
                end

            else
                _Data[id].PrevClick = false
            end

        else -- Push, default

            _Data[id] = { Active = touch, FuncOn = touch }

        end

        -- Draw

        DrawStyledText(x, y, obj.Text, _Data[id].Active and obj.StyleOn or obj.StyleOff,  w, h)

        -- Execute
        if _Data[id].FuncOn then
            if obj.Args then
                obj.Func( table.unpack(obj.Args) )
            else
                obj.Func()
            end
        end
    end
})


---@alias ButtonMode
---| 0 # `Push`. Default. When you hold, function is active.
---| 1 # `Pulse`. When you hold, function is called once till you release and press again.
---| 2 # `Toggle`. When you hold, state of the button is toggled and repeats the function or stops it.


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
        Text = title,
        Width = width, Height = height,
        StyleOff = styleOff, StyleOn = styleOn,
        Mode = mode,
        Func = func, Args = args,
        ID = nil
    }, isAnon)
end


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