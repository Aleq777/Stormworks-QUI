--- QUI 2
--- Official Template: KeyPad
--- Author: @Aleq777
--- Includes:
---     Keypad - A digital keypad, defaultly containing characters: 0-9, '.' and 'C' for clear function
---@module 'Base' REQUIRED
---@module 'Templates.Interactive.Input' REQUIRED IF you will use `ForInput`



---@see OPTIMISE_ME.md
PushDict(Templates, {
    ["Keypad"] = function (x, y, obj, id)

        -- register
        if id and not _Data[id] then
            _Data[id] = {
                Value = ""
            }
        end

        local func
        local moveX, moveY = 0, 0

        for k, v in pairs(obj.KeyData) do

            for i, j in pairs(v) do

                if type(j) == "function" then
                    func = j
                else
                    func = id and function ()
                                _Data[id].Value = _Data[id].Value .. j
                            end or function ()
                                _Data[ActiveInputID].Value = tonumber( _Data[ActiveInputID].Value .. j )
                    end
                end

                DrawButton(
                    x + 7 * moveX,
                    y + 8 * moveY,
                    "keypad" .. i,
                    tostring(i),
                    obj.StyleOff,
                    obj.StyleOn,
                    nil,
                    nil,
                    ---@type ButtonMode
                    1, -- Pulse
                    func,
                    id
                )

                moveX = moveX + 1

            end

            moveY = moveY + 1
        end

    end
})


---@alias KeypadMode
---| 0 # `ForInput` - It's for the `Input` object. REQUIRES "Templates/Input.lua"
---| 1 # `ForData` - Creates a new Data. Requires `id` parameter. You can get the value by GetData()
---| 2 # `ForTable` - Requires `id` parameter as the table. The value at 1 (`table[1]`) will be updated by reference


--- An advanced keypad for monitor.
---@param keyData table<table> First dimension defines rows. Second defines each button. Index (k) is what will be displayed. Value (v) is what will be added to the value/data/input
---@param mode KeypadMode
---@param styleOff Style Default style of buttons
---@param styleOn Style Style for pressed buttons
---@param isAnon boolean|nil?
---@return number|Object
---@nodiscard
function Keypad(keyData, mode, styleOff, styleOn, isAnon)
    local f

    -- ForData
    if mode == 1 then
        f = function (id)
            _Data[id].Value = ""
        end
    elseif mode == 2 then -- ForTable
        f = function (table)
            table[1] = ""
        end
    else -- ForInput, default
        f = function ()
            _Data[ActiveInputID].Value = ""
        end
    end

    return Object("Keypad", {
        StyleOff = styleOff, StyleOn = styleOn,
        Mode = mode,
        KeyData = keyData or {
            {
                [7] = 7, [8] = 8, [9] = 9
            },
            {
                [4] = 4, [5] = 5, [6] = 6
            },
            {
                [1] = 1, [2] = 2, [3] = 3
            },
            {
                ['.'] = '.', [0] = 0,
                ['C'] = f
            }
        }
    }, isAnon)
end


--- Draw an advanced keypad for monitor.
---@param x number Position
---@param y number Position
---@param keyData table<table> First dimension defines rows. Second defines each button. Index (k) is what will be displayed. Value (v) is what will be added to the value/data/input
---@param mode KeypadMode
---@param styleOff Style Default style of buttons
---@param styleOn Style Style for pressed buttons
function DrawKeyPad(x, y, keyData, mode, styleOff, styleOn)
    Draw(x, y,
        Keypad(keyData, mode, styleOff, styleOn, true)
    )
end