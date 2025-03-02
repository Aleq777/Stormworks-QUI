--- QUI 2.0
--- Author: @Aleq777
---     Discord:    aleq777
---     Steam:      Aleq777
--- Any questions? Ask on:
---     Discord QUI Server: -soon-
---     Steam Workshop QUI/Examples
---     Ping me on #lua in Stormworks Discord server https://discord.gg/stormworks
---     Dm me on Discord - aleq777

---@see README.md !!!



---@diagnostic disable:lowercase-global



---@section REMOVE THIS BEFORE COMPILATION AFTER YOU FINISH YOUR PROJECT !!!!!!!!!!!


---@class NumberWithMass
---@field [1] number value
---@field [2] number mass
__NumberWithMasses = { }


---@class Color
---@field R number
---@field G number
---@field B number
---@field A number
---@field Length number|nil For gradient arrays only
__Colors = { }


---@class Style
---@field Fore Color|Color[]
---@field Back Color
---@field Border Color|nil
---@diagnostic disable-next-line
---@field Decoration TextStyles|TitleStyles|nil
__Styles = { }


---@class Object has multiple fields
---@field Type string Template name
__Objects = { }


---@class Data
---@field Value any? The value
---@field Active boolean|nil? Display it as active?
---@field FuncOn boolean|nil? Run function?
---@field PrevClick boolean|nil? In previous tick, was I clicking it? -- for Pulse and Toggle
__Datas = { }



--- Fast debugging for IDE
---@param a any
function LOG(a)

    if type(a) == type({ }) then
        for k, v in pairs(a) do
            print(k, v)
        end
    elseif type(a) == "function" then
        print("function", a())
    else
        print(a)
    end
end




---@endsection Stop removing here





---@section BASIC FUNCTIONS


gn = input.getNumber    ---@diagnostic disable-line:undefined-global
gb = input.getBool      ---@diagnostic disable-line:undefined-global
sn = output.setNumber   ---@diagnostic disable-line:undefined-global
sb = output.setBool     ---@diagnostic disable-line:undefined-global
pn = property.getNumber ---@diagnostic disable-line:undefined-global
pb = property.getBool   ---@diagnostic disable-line:undefined-global
pt = property.getText   ---@diagnostic disable-line:undefined-global


floor = math.floor
rad = math.rad
deg = math.deg
pi = math.pi


--- `math.sin`
---@param a number degrees
---@return number # sin
---@nodiscard
function sin(a)
    return math.sin(rad(a))
end


--- `math.cos`
---@param a number degrees
---@return number # cos
---@nodiscard
function cos(a)
    return math.cos(rad(a))
end


--- `math.asin`
---@param n number
---@return number # degrees
---@nodiscard
function asin(n)
    return deg(math.asin(n))
end


--- `math.acos`
---@param n number
---@return number # degrees
---@nodiscard
function acos(n)
    return deg(math.acos(n))
end


--- Returns a value which will be between `min` and `max`.
---@param num number
---@param min number|nil? `default = 0`
---@param max number|nil? `default = 1`
---@return number # returns the `num` or `min`/`max`
---@nodiscard
function clamp(num, min, max)
    min = min or 0
    max = max or 1

    return math.max(math.min(num, max), min)
end


--- Return value translated to the range of `0.0 - 1.0`
---@param min number Minimal value of the `value`
---@param max number Maximal value of the `value`
---@param value number Number between the `min` and `max`
---@return number # value 0-1
---@nodiscard
function ZeroOne(min, max, value)
    return clamp((value - min) / (max - min))
end





--- It adds `newChar` to the `str` only, if `str` has a lenght smaller than `maxLen`
---@param maxLen number Maximal acceptable length of the string
---@param str string The base string
---@param newChar string Character to add to `str`
---@return string # A modified string which won't be longer than `maxLen`
---@nodiscard
function sclamp(str, maxLen, newChar)
    return #str + 1 > maxLen and str or str .. newChar
end


--- It rounds the number in a mathematical way (`>= 0.5` -> 1, `< 0.5` -> 0).
--- Also, it can return a number rounded to a decimal point.
--- - Example: `round(1.23, 1)` -> 1.2
---@param num number
---@param decimals number|nil? If it's `nil`, it only returns the perfectly rounded number, else it returns number rounded to the decimal point.
---@return number # Rounded number
---@nodiscard
function round(num, decimals)
    if decimals then
        return tonumber( string.format( "%." .. decimals .. "f", tostring(num)) ) --[[@as number]]
    end

    return floor(num + 0.5)
end


--- Returns a mathematical average of the numbers
---@param ... number
---@return number # Average of numbers
---@nodiscard
function avg(...)
    local t, sum = table.pack(...), 0

    for k, v in pairs(t) do
        if k ~= 'n' then
            sum = sum + v
        end
    end

    return #t == 0 and 0 or sum / #t
end



--- Returns an arithmetical average of the numbers.
--- Write every elements as a table of 2 elements: `[number, mass]`
---@param ... NumberWithMass
---@return number # Arithmetical average
---@nodiscard
function avgm(...)
    local sum, div = 0, 0

    for k, v in pairs(table.pack(...)) do
        if k ~= 'n' then
          sum = sum + v[1] * v[2]
          div = div + v[2]
        end
    end

    return div == 0 and 0 or sum / div
end





--- Adds to the provided table `base` properties of `dict`.
---@param base table Provided table as reference
---@param dict table Table of new properties and values
---@return table|nil # Returns a table, but doesn't need to, as the `base` has already been overriden
function PushDict(base, dict)
    for k, v in pairs(dict) do
        base[k] = v
    end

    return base
end


--- Fills the string `value` with `prefix` in front of, until it's length is equal to `minLen`
--- - Example: `FillPrefix(3, 3, '0')` -> '003'
---@param value string
---@param minLen number
---@param prefix string Must be 1 char
---@return string
---@nodiscard
function FillPrefix(value, minLen, prefix)
    value = tostring(value)

    for i = 1, minLen - #value do
        value = prefix .. value
    end

    return value
end


--- Converts a string to a table
---@param str string
---@return table
---@nodiscard
function totable(str)
    local result = { }
    for i = 1, #str do
        table.insert(result, string.sub(str, i, i))
    end

    return result
end


--- Returns the index of `value` in `array`
---@param arr table
---@param value any
---@return any # The index in the `arr`
---@nodiscard
function IndexOf(arr, value)
    for k, v in pairs(arr) do
        if v == value then
            return k
        end
    end

    return nil
end



---@endsection






---@section MONITOR

---@type number Width of the monitor
WIDTH = nil
---@type number Height of the monitor
HEIGHT = nil


---@type boolean Is user touching the monitor? (E or Q)
Touching = nil

---@type number X position of the touch
TouchX = nil
---@type number Y position of the touch
TouchY = nil


--- Checks, if user is Touching the monitor inside a provided rectangle of 2 points
---@param x number Point A
---@param y number Point A
---@param x2 number Point B
---@param y2 number Point B
---@return boolean # Is touch inside the box
---@nodiscard
function IsInBox(x, y, x2, y2)
    return Touching and TouchX >= x and TouchX <= x2 and TouchY >= y and TouchY <= y2
end


--- Calculates width of the text in pixels and columns (the widest line)
---@param text string
---@return number # pixels
---@return number # columns
---@nodiscard
function TextWidth(text)
    local widths, index = { 0 }, 1

    for k, c in pairs(totable(text)) do
        if c == '\n' then
            index = index + 1
            widths[index] = 0
        elseif c ~= "" then
            widths[index] = widths[index] + 5
        end
    end

    for k, v in pairs(widths) do
        if v > widths[index] then
            index = k
        end
    end

    if widths[index] == 0 then
      return 0, 0
    end

    return widths[index] - 1, (widths[index] + 1) / 5
end


--- Calculates height of the text in pixels and lines
---@param text string
---@param maxWidth number|nil? pixels. `Default = no limit` - limit of the width of the text
---@return number pixels
---@return number columns
---@nodiscard
function TextHeight(text, maxWidth)
    if not maxWidth then
        maxWidth = TextWidth(text)
    end

    local height, currentWidth = #text > 0 and 5 or 0, 0

    for k, c in pairs(totable(text)) do
        if c == '\n' or currentWidth + 4 > maxWidth then
            height = height + 6
            currentWidth = 0
        else
            currentWidth = currentWidth + 5
        end
    end

    if height == 0 then
        return 0, 0
    end

    return height, height > 5 and (height + 1) / 6 or height / 5
end



---@endsection





---@section COLORS


--- Create a color in RGBA
---@param r number|nil? Red (`Default = 0`)
---@param g number|nil? Green (`Default = 0`)
---@param b number|nil? Blue (`Default = 0`)
---@param a number|nil? Alpha (`Default = 255`)
---@return Color
---@nodiscard
function Color(r, g, b, a)
    return {
        R = r or 0,
        G = g or 0,
        B = b or 0,
        A = a or 255
    }
end


TRANS = Color(0, 0, 0, 0)
WHITE = Color(255, 255, 255)
BLACK = Color()
GREY = Color(127, 127, 127)
RED = Color(255)
ORANGE = Color(255, 127)
YELLOW = Color(255, 255)
CITRUS = Color(127, 255)
GREEN = Color(0, 255)
CYAN = Color(0, 255, 255)
BLUE = Color(0, 0, 255)
PINK = Color(255, 0, 255)
PURPLE = Color(127, 0, 255)


---@type Color Color of the foreground
Foreground = WHITE
---@type Color Color of the background
Background = TRANS


--- Sets the `Foreground`
---@param color Color
function SetFore(color)
    Foreground = color
end


--- Sets the `Background`
---@param color Color
function SetBack(color)
    Background = color
end


--- Sets the current color for `screen.*` functions
---@param color Color|nil? `Default = Foreground`
function SetColor(color)
    color = color or Foreground
    screen.setColor(color.R, color.G, color.B, color.A)     ---@diagnostic disable-line:undefined-global
end


--- Clears the monitor and fills with other color
---@param toColor Color|nil? `Default = Background`
function Clear(toColor)
    SetColor(toColor or Background)
    screen.drawClear()      ---@diagnostic disable-line:undefined-global
end





---@alias TextStyle
---| 'u' # Text: Underline
---| 's' # Text: Strike


--- Returns Style
---@param fore Color|Color[]|nil? Color or gradient `Default = Foreground`
---@param back Color|nil? Background color `Default = Background`
---@param border Color|nil? Border color `Default = no border`
---@diagnostic disable-next-line
---@param decor TextStyle|TitleStyle? Text decoration `Default = no decoration`. TitleStyle requires "Formatted texts.lua"
---@return Style
---@nodiscard
function Style(fore, back, border, decor)
    return {
        Fore = fore or Foreground,
        Back = back or Background,
        Border = border,
        Decor = decor
    }
end





--- Perfect for debugging and error making
---@param bool boolean If `true`, throw the error
---@param text string Error message
function DEBUG(bool, text)
    if bool then
        Clear(GREY)
        DrawStyledText(1, 1, text, Style(RED), WIDTH - 2, HEIGHT - 2)
    end
end


---@endsection




---@section Object
--- Definition Reminder:
---     Template - type of object with defined (but not set) properties and behaviour (like a class)
---     Object - An instance of Template which has defined and set properties (like object of a class)
---     Spirit - Spawned object on the monitor. "Index and Layers" module will use this term. Here it's not used.


---@type Object[] List of objects (template instances) - can be spawned multiple times later
Objects = { }


--- Returns a REFERENCE to the Object. Best for changing or getting properties.
---@param idOrObject number|Object ID of the Object in `Objects` or actual anonymous Object
---@return Object # reference
---@nodiscard
function PropertiesOf(idOrObject)
    if type(idOrObject) == type({ }) then
        return idOrObject --[[@as Object]]
    end

    return Objects[idOrObject]
end


--- Returns a COPY BY VALUE of the Object. Best for creating an anonymous object (copy) with different properties.
---@param idOrObject number ID of the Object in `Objects`
---@return Object # value
---@nodiscard
function GetCopy(idOrObject)
    local result, ref = { }, Objects[idOrObject]

    for k, v in pairs(ref) do
        result[k] = v
    end

    return result
end



---@type function[] Templates' behaviours
Templates = {
    ["Line"] = function (x, y, obj)
        SetColor(obj.Color)
        screen.drawLine(x, y, obj.X + x, obj.Y + y)     ---@diagnostic disable-line:undefined-global
    end,
    ["TrigLine"] = function (x, y, obj)
        DrawLine(x, y, x + obj.R * cos(obj.Angle), y + obj.R * sin(obj.Angle), obj.Color)
    end,
    ["Dot"] = function (x, y, obj)
        DrawLine(x, y, 1, 0, obj.Color)
    end,
    ["Box"] = function (x, y, obj)
        SetColor(obj.Style.Back)
        screen.drawRectF(x, y, obj.Width, obj.Height)   ---@diagnostic disable-line:undefined-global
        SetColor(obj.Style.Border or TRANS)
        screen.drawRect(x, y, obj.Width, obj.Height)    ---@diagnostic disable-line:undefined-global
    end,
    ["Triangle"] = function (x, y, obj)
        local function coords()
            return obj.Ax + x, obj.Ay + y, obj.Bx + x, obj.By + y, obj.Cx + x, obj.Cy + y
        end

        SetColor(obj.Style.Back)
        screen.drawTriangleF(coords())      ---@diagnostic disable-line:undefined-global
        SetColor(obj.Style.Border or TRANS)
        screen.drawTriangle(coords())       ---@diagnostic disable-line:undefined-global
    end,
    ["Circle"] = function (x, y, obj)
        SetColor(obj.Style.Back)
        screen.drawCircleF(x, y, obj.R)     ---@diagnostic disable-line:undefined-global
        SetColor(obj.Style.Border or TRANS)
        screen.drawCircle(x, y, obj.R)      ---@diagnostic disable-line:undefined-global
    end,
    ["Text"] = function (x, y, obj)
        SetColor(obj.Color)
        screen.drawText(x, y, obj.Text)     ---@diagnostic disable-line:undefined-global
    end,
    ["StyledText"] = function (x, y, obj)
        local w = obj.Width or TextWidth(obj.Text)

        if obj.Width then
            w = obj.Width
        else
            w = TextWidth(obj.Text)
            w = w + 1
        end

        local h, ln

        if obj.Height then
            h = obj.Height
        else
            h, ln = TextHeight(obj.Text, w)
        end

        local a = obj.Style.Border and 2 or 0
        DrawBox(x, y, w + 1.5 * a - 1, h + 1.5 * a, obj.Style)

        SetColor(obj.Style.Fore)
        screen.drawTextBox(x + a, y + a, w, h, obj.Text, 0, 0)      ---@diagnostic disable-line:undefined-global

        if obj.Style.Decor == 'u' then

            DrawTrigLine(x, y + h - 2, 0, w, obj.Style.Fore)

        elseif obj.Style.Decor == 's' then

            for i = 1, ln do
                DrawTrigLine(x, y + 2 + 6 * (i - 1), 0, w, obj.Style.Fore)
            end

        end
    end,
}


--- Draws an Object. The object can be in `Objects` or can be anonymous.
---@param x number Draw at X
---@param y number Draw at Y
---@param obj number|Object Reference to the object or anonymous Object
---@param id any|nil? Required only for interactives (Buttons etc)
function Draw(x, y, obj, id)
    -- Is anonymous - true is table of an object, false is a reference to the premade object
    if type(obj) == type(0) then
        obj = Objects[obj]
    end

    -- Spawn object
    Templates[obj.Type](x, y, obj, id)
end




--- Returns the Object from a Template. It's still not drew, but it has defined properties and it's ready to be put in `Draw()` function
---@param typeof string Name of the Template defined in `Templates`
---@param dict table Table of properties and functions
---@param isAnon boolean|nil? Decides, if it puts the object in `Objects` and returns a reference to it, or return the object itself (anonymous). <br> `Default = false`
---@return number|Object # The anonymous object or number as a reference to the `Objects`
---@nodiscard
function Object(typeof, dict, isAnon)
    local result = { Type = typeof }
    PushDict(result, dict)

    if isAnon then
        return result
    end

    table.insert(Objects, result)
    return #Objects
end


---@endsection






---@section CREATOR FUNCTIONS
--- Fast object creatior functions
--- When you will create your own Template, you should include that function too, so it'll be easier your objects.
--- Also, you can put comments, so it's more readable.
--- Include in them the default values.



--- Vector line.
--- - Example - `x = 1, y = 2` will result in a line like `/`, and by `Draw()` function you can place that line wherever you want 
---@param x number Vector X
---@param y number Vector Y
---@param color Color|nil? Color. Gradients are available in "Gradient" module
---@param isAnon boolean|nil? Anonymous object = you will use it once
---@return number|Object
---@nodiscard
function Line(x, y, color, isAnon)
    return Object("Line", {
        X = x,
        Y = y,
        Color = color
    }, isAnon)
end


--- Line with using trigonometry.
---@param angle number degrees. 0* -> line going to the left.
---@param r number Length in pixels
---@param color Color|nil? Color. Gradients are available in "Gradient" module
---@param isAnon boolean|nil? Anonymous object = you will use it once
---@return number|Object
---@nodiscard
function TrigLine(angle, r, color, isAnon)
    return Object("TrigLine", {
        Angle = angle,
        R = r,
        Color = color
    }, isAnon)
end


--- Just a dot, point.
---@param color Color|nil?
---@param isAnon boolean|nil?
---@return number|Object
---@nodiscard
function Dot(color, isAnon)
    return Object("Dot", {
        Color = color
    }, isAnon)
end


--- Box, square, rectangle.
---@param width number
---@param height number
---@param style Style
---@param isAnon boolean|nil?
---@return number|Object
---@nodiscard
function Box(width, height, style, isAnon)
    return Object("Box", {
        Width = width,
        Height = height,
        Style = style,
     }, isAnon)
end


--- Traingle.
---@param ax number Point A
---@param ay number Point A
---@param bx number Point B
---@param by number Point B
---@param cx number Point C
---@param cy number Point C
---@param style Style
---@param isAnon boolean|nil?
---@return number|Object
---@nodiscard
function Triangle(ax, ay, bx, by, cx, cy, style, isAnon)
    return Object("Triangle", {
        Ax = ax, Ay = ay,
        Bx = bx, By = by,
        Cx = cx, Cy = cy,
        Style = style
    }, isAnon)
end


--- Simple circle. For better ones, check "Better Circles" module.
---@param r number Radius in pixels
---@param style Style
---@param isAnon boolean|nil?
---@return number|Object
---@nodiscard
function Circle(r, style, isAnon)
    return Object("Circle", {
        R = r,
        Style = style
    }, isAnon)
end


--- Simple text. if you want background colors, borders, decorations - use `StyledText`
---@param text string
---@param color Color|nil? Color of the text
---@param isAnon boolean|nil?
---@return number|Object
---@nodiscard
function Text(text, color, isAnon)
    return Object("Text", {
        Text = text,
        Color = color
    }, isAnon)
end


--- Super fun text. Customise anything.
---@param text string
---@param style Style Text color, background color and border!
---@param width number|nil? `Default = no limit`
---@param height number|nil? `Default = no limit`
---@param isAnon boolean|nil?
---@return number|Object
---@nodiscard
function StyledText(text, style, width, height, isAnon)
    local w = TextWidth(text)
    return Object("StyledText", {
        Text = text,
        Style = style,
        Width = width or w,
        Height = height or TextHeight(text, w)
    }, isAnon)
end


---@endsection





---@section SHORT FUNCTIONS
--- Short functions to draw anonymous objects.
--- If you are creating custom templates - you can also include a short function. Depends on your goal - private projects or contributing to QUI.


--- A simple line from point A to point B
---@param x number Point A
---@param y number Point A
---@param x2 number Point B
---@param y2 number Point B
---@param color Color|nil? Color. Gradients are available in "Gradient" module
function DrawLine(x, y, x2, y2, color)
    Draw(x, y,
        Line(x2, y2, color, true)
    )
end


--- Line with using trigonometry.
---@param x number Start point
---@param y number Start point
---@param angle number degrees. 0* -> line going to the left.
---@param r number Length in pixels
---@param color Color|nil? Color. Gradients are available in "Gradient" module
function DrawTrigLine(x, y, angle, r, color)
    Draw(x, y,
        TrigLine(angle, r, color, true)
    )
end


--- Just a dot, point.
---@param x number Position
---@param y number Position
---@param color Color|nil? Color
function DrawDot(x, y, color)
    Draw(x, y,
        Dot(color, true)
    )
end


--- Box, square, rectangle.
---@param x number Position
---@param y number Position
---@param width number
---@param height number
---@param style Style
function DrawBox(x, y, width, height, style)
    Draw(x, y,
        Box(width, height, style, true)
    )
end


--- Triangle
---@param ax number Point A
---@param ay number Point A
---@param bx number Point B
---@param by number Point B
---@param cx number Point C
---@param cy number Point C
---@param style Style
function DrawTriangle(ax, ay, bx, by, cx, cy, style)
    Draw(0, 0,
        Triangle(ax, ay, bx, by, cx, cy, style, true)
    )
end


--- Simple circle. For better ones, check "Better Circles" module.
---@param x number Position of center
---@param y number Position of center
---@param r number Radius in pixels
---@param style Style
function DrawCircle(x, y, r, style)
    Draw(x, y,
        Circle(r, style, true)
    )
end


--- Simple text. if you want background colors, borders, decorations - use `StyledText`
---@param x number Position
---@param y number Position
---@param text string
---@param color Color|nil? Color of the text
function DrawText(x, y, text, color)
    Draw(x, y,
        Text(text, color, true)
    )
end


--- Super fun text. Customise anything.
---@param x number Position
---@param y number Position
---@param text string
---@param style Style Text color, background color and border!
---@param width number|nil? `Default = no limit`
---@param height number|nil? `Default = no limit`
function DrawStyledText(x, y, text, style, width, height)
    Draw(x, y,
        StyledText(text, style, width, height, true)
    )
end


---@endsection





---@section INTERACTIONS
--- You can create your own interactive Templates.
--- You can get some ready interactive Templates, search for modules: Button, HTML Select, Second Interactivity, Slider, Input and CheckBox etc.




---@type Data[] List of data and values required for interactive Templates
_Data = { }


--- Get the value of interactive element
---@param id any ID of interactive data
---@return any
---@nodiscard
function GetData(id)
    if not _Data[id] then return nil end

    return _Data[id].Value
end


--- Set (update) the value of interactive element. Sometimes helpful
---@param id any ID of interactive data
---@param value any New value
---@param force boolean? If the interactive element doesn't exist, create new?
---@return boolean # <ul> <li>`true`, if created new element </li> <li>`false`, if updated existing element </li> </ul>
function SetData(id, value, force)
    if not _Data[id] then
        if force then
            ForceData(id, value)
        end

        return force or false
    end

    _Data[id].Value = value
    return false
end


--- Forces creating a new interactive data. Best when creating custom interactive templates.
---@param id any ID of interactive data
---@param value any?
---@param funcOn boolean|nil?
---@param active boolean|nil?
---@param prevClick boolean|nil?
function ForceData(id, value, funcOn, active, prevClick)
    _Data[id] = {
        Value = value or false,
        FuncOn = funcOn or false,
        Active = active or false,
        PrevClick = prevClick or false
    }
end


---@endsection





---@section TIME


--- Updates every tick, at the end of `onTick` function (there you should place this function).<br>
--- Everything that has been added with `AddUpdate` function, will be updated.
---@see Time module. It's required, if you want to use this function
---@module 'Extensions.Time'
function Update() end


---@endsection



--================= USER ===================

---@see Write your code here.




function onTick()
    WIDTH = gn(1)
    HEIGHT = gn(2)

    Touching = gb(1)
    TouchX = gn(3)
    TouchY = gn(4)

    -- if you don't have "Time" module - you can remove this
    Update()
end


function onDraw()
    
end