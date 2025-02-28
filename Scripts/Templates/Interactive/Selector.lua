-- QUI 2 Selector like <select> in HTML
--- REQUIRED: "Base.lua"

---@section REMOVE THIS BEFORE COMPILATION

---@class SelectorComponent
---@field Text string
---@field Value any
___SelectorComponents = { }

---@endsection

-- See "OPTIMISE_ME.md" for optimising code below
PushDict(Templates, {
    ["Selector"] = function (x, y, obj, id)

        obj.Height = obj.Height or 9

        local active, current = false, nil

        local function indexOf()
            for k, v in pairs(obj.Content) do
                if v == _Data[id].FuncOn then
                    return k
                end
            end

            return nil
        end

        -- is registered
        if not _Data[id] then
            _Data[id] = {
                FuncOn = obj.Content[1].Value,
                PrevClick = false,
                Active = false
            }
        end

        -- Display - this time its first lol
        current = obj.Content[indexOf()]
        DrawStyledText(x, y, current.Text, obj.StyleOff, obj.Width, obj.Height)
        if _Data[id].Active then -- shows list

            active = true

            for k, v in pairs(obj.Content) do

                DrawButton(
                    x,
                    y + 8 * k,
                    "selector" .. id .. k,
                    v.Text,
                    indexOf() == k and obj.StyleOn or obj.StyleOff,
                    obj.StyleOff,
                    obj.Width,
                    obj.Height,
                    EnumButtonMode.Pulse,
                    function ()
                        _Data[id].FuncOn = v.Value
                        _Data[id].Active = false

                        for k, v in pairs(_Data) do -- Memory managment
                            if k == "selector" .. id then
                                _Data[k] = nil
                            end
                        end
                    end
                )

            end

        end


        -- Interactions
        -- Pressing the field itself will toggle list
        if IsInBox(x, y, obj.Width + x, obj.Height + y) then
            _Data[id].Active = not _Data[id].Active
        end

    end
})


--- May be longer when writing, but it will be shorter after minimalising.
---@param label string
---@param value any
---@return SelectorComponent
function SelectorComponent(label, value)
    return {
        Text = label,
        Value = value
    }
end



--- Selector. Just like \<select> in HTML
---@param content SelectorComponent[] Just like \<option> in HTML
---@param styleOff Style Style for the selector in default state and for the not-selected options
---@param styleOn Style Style for the selected option
---@param width number|nil? Leave nil for auto-size
---@param height number|nil? Leave nil for auto-size
---@param isAnon boolean|nil?
---@return number|Object
function Selector(content, styleOff, styleOn, width, height, isAnon)
    return Object("Selector", {
        Content = content or {
            [1] = {
                Text = "Off",
                Value = 0
            },
            [2] = {
                Text = "On",
                Value = 1
            }
        },
        StyleOff = styleOff, StyleOn = styleOn,
        Width = width, Height = height
    }, isAnon)
end


--- Selector. Just like \<select> in HTML
---@param x number Position
---@param y number Position
---@param content SelectorComponent[] Just like \<option> in HTML
---@param styleOff Style Style for the selector in default state and for the not-selected options
---@param styleOn Style Style for the selected option
---@param width number|nil? Leave nil for auto-size
---@param height number|nil? Leave nil for auto-size
function DrawSelector(x, y, id, content, styleOff, styleOn, width, height)
    Draw(x, y,
        Selector(content, styleOff, styleOn, width, height),
        id
    )
end