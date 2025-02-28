-- QUI 2 Second Interactive
--- REQUIRED: "Base.lua"

-- See "OPTIMISE_ME.md" for optimising code below
PushDict(Templates, {
    ["SButton"] = function (x, y, obj, id)
        
    end
})


--- An advanced button that works with both touches (touch 1 and touch 2 / touch and stouch)
---@param title string
---@param styleOff Style Default style
---@param style1 Style Style, when Touching
---@param style2 Style Style, when Stouching
---@param width number|nil Leave nil for auto-size
---@param height number|nil Leave nil for auto-size
---@param mode SButtonMode
---@param separateFunctions boolean|nil If `true`, the f2 activates when Stouching, and f1 when Touching. If `false`, then f1 when Touching, and f1 and f2 when Stouching
---@param func1 function Function for Touching
---@param args1 table|nil Arguments
---@param func2 function Function for Stouching
---@param args2 table|nil Arguments
---@param isAnon boolean|nil?
---@return number|Object
function SButton(title, styleOff, style1, style2, width, height, mode, separateFunctions, func1, args1, func2, args2, isAnon)
    return Object("SButton", {
        Text = title,
        Width = width, Height = height,
        StyleOff = styleOff, StyleOn1 = style1, StyleOn2 = style2,
        Mode = mode, Separate = separateFunctions,
        Func1 = func1, Args1 = args1,
        Func2 = func2, Args2 = args2
    }, isAnon)
end

--- Draw an advanced button that works with both touches (touch 1 and touch 2 / touch and stouch)
---@param x number Position
---@param y number Position
---@param title string
---@param styleOff Style Default style
---@param style1 Style Style, when Touching
---@param style2 Style Style, when Stouching
---@param width number|nil Leave nil for auto-size
---@param height number|nil Leave nil for auto-size
---@param mode SButtonMode
---@param separateFunctions boolean|nil If `true`, the f2 activates when Stouching, and f1 when Touching. If `false`, then f1 when Touching, and f1 and f2 when Stouching
---@param func1 function Function for Touching
---@param args1 table|nil Arguments
---@param func2 function Function for Stouching
---@param args2 table|nil Arguments
function DrawSButton(x, y, id, title, styleOff, style1, style2, width, height, mode, separateFunctions, func1, args1, func2, args2)
    Draw(x, y,
        SButton(title, styleOff, style1, style2, width, height, mode, separateFunctions, func1, args1, func2, args2),
        id
    )
end