-- QUI 2 Circles
--- REQUIRED: "Base.lua"

--- Function used for BreCircle
---@param xc number Position of center
---@param yc number Position of center
---@param x number
---@param y number
---@param color Color|nil? Border color `Default = Border Color`
local function _drawCircle(xc, yc, x, y, color)
    local b = Background
    SetBack(color or Foreground)

    DrawDot(xc + x, yc + y)
    DrawDot(xc + x, yc - y)
    DrawDot(xc - x, yc + y)
    DrawDot(xc - x, yc - y)
    DrawDot(xc + y, yc + x)
    DrawDot(xc + y, yc - x)
    DrawDot(xc - y, yc + x)
    DrawDot(xc - y, yc - x)

    SetBack(b)
end

-- See "OPTIMISE_ME.md" for optimising code below
PushDict(Templates, {
    ["BreCircle"] = function (x, y, obj)
        local ax, ay, d = 0, obj.R, 3 - 2 * obj.R
        _drawCircle(x, y, ax, ay, obj.Color)

        while ay >= ax do
            ax = ax + 1
            if d > 0 then
                ay = ay - 1
                d = d + 4 * (ax - ay) + 10
            else
                d = d + 4 * ax + 6
            end
            _drawCircle(x, y, ax, ay, obj.Color)
        end
    end,
    ["TrigCircle"] = function (x, y, obj)
        local step = pi * 2 / obj.Segments

        for i = 0, pi * 2, step do
            DrawLine(x + math.cos(i) * obj.R, y + math.sin(i) * obj.R, obj.R * (math.cos(i + step) - math.cos(i)), obj.R * (math.sin(i + step) - math.sin(i)), obj.Color)
        end
    end
})

---Brehensam circle
---@param r number Radius
---@param color Color|nil? Border color `Default = Foreground`
---@param isAnon boolean|nil?
---@return number|Object
function BreCircle(r, color, isAnon)
    return Object("BreCircle", {
        R = r,
        Color = color
    }, isAnon)
end


--- Trigonometric circle.
---@param r number Radius
---@param segments number Accuracy
---@param color Color|nil? Border color `Default = Foregorund`
---@param isAnon boolean|nil?
---@return number|Object
function TrigCircle(r, segments, color, isAnon)
    return Object("TrigCircle", {
        R = r,
        Segments = segments,
        Color = color
    }, isAnon)
end


---Draw Brehensam Circle
---@param x number Center position
---@param y number Center position
---@param r number Radius
---@param color Color|nil? Border color
function DrawBreCircle(x, y, r, color)
    Draw(x, y,
        BreCircle(r, color, true)
    )
end


--- Draw Trigonometric circle
---@param x number Center position
---@param y number Center position
---@param r number Radius
---@param segments number Accuracy
---@param color Color|nil? Border color
function DrawTrigCircle(x, y, r, segments, color)
    Draw(x, y,
        TrigCircle(r, segments, color, true)
    )
end