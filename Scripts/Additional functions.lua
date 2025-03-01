
---@diagnostic disable:lowercase-global

abs = math.abs
ceil = math.ceil
sqrt = math.sqrt


--- `math.tan`
---@param a number degrees
---@return number # tan
function tg(a)
    return math.tan(rad(a + 180))
end


--- `math.atan`
---@param n number
---@return number # degrees
function atg(n, m)
    return deg(math.atan(n, m))
end


--- Gives information, if the number fits between `min` and `max`
---@param value number
---@param min number|nil? `Default = 0`
---@param max number|nil? `Default = 1`
---@return boolean
function InSpan(value, min, max)
    min = min or 0
    max = max or 1

    return value >= min and value <= max
end


--- Returns the sign of the number (`1` or `-1`)
---@param n number
---@return number # 1 if `> 0`, -1 if `< 0`
function sign(n)
    return n < 0 and -1 or 1
end


--- Logical XOR
---@param a boolean
---@param b boolean
---@return boolean
function xor(a, b)
    return a ~= b
end


--- Returns a position of the object, so it can be centered in a plane between `x1` and `x2`
--- - Example: `Center(1, 10, 2)` -> 6.5 -- the object will be in the center.
---@param x1 number Left/Top
---@param x2 number Right/Bottom
---@param length number Length of the object
---@return number # Center coordinates
function Center(x1, x2, length)
    return avg(x1, x2) - length / 2
end


--- Returns a position in the center of the box.
---@param x1 number Point A
---@param y1 number Point A
---@param x2 number Point B
---@param y2 number Point B
---@param width number Width of the object
---@param height number Height of the object
---@return number # Center of X
---@return number # Center of Y
function Center2D(x1, y1, x2, y2, width, height)
    return Center(x1, x2, width), Center(y1, y2, height)
end


