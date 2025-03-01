
---@type boolean Is youser double touching (stouching) the monitor? (E and Q)
Stouching = nil

---@type number X position of the stouch
StouchX = nil
---@type number Y position of the stouch
StouchY = nil


--- Checks, if user is Stouching (Touching second method) the monitor inside a provided rectangle of 2 points
---@param x number Point A
---@param y number Point A
---@param x2 number Point B
---@param y2 number Point B
---@return boolean # Is stouch inside the box
function IsInBox2(x, y, x2, y2)
    return Stouching and StouchX >= x and StouchX <= x2 and StouchY >= y and StouchY <= y2
end


---@see ADD THIS TO onTick FUNCTION (below Touchs)
Stouching = gb(2)
StouchX = gn(5)
StouchY = gn(6)