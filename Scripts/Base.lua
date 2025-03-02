--- QUI 2.0
--- Author: @Aleq777
---     Discord:    aleq777
---     Steam:      Aleq777     https://steamcommunity.com/id/aleq777
--- Any questions? Ask on:
---     Discord QUI Server:             https://discord.gg/zjjqBnx6xu
---     Steam Workshop QUI/Examples     -soon-
---     Dm me on Discord:               aleq777
---     Ping me on #lua in Stormworks Discord server https://discord.gg/stormworks


---@see README.md !!!



---@diagnostic disable:lowercase-global


---@section __IT_EXISTS__
--- it exists only for annotations to work

do
    local __IT_EXISTS__ = nil


    ---@class NumberWithMass
    ---@field [1] number value
    ---@field [2] number mass
    local __NumberWithMasses = { }


    ---@class Color
    ---@field R number
    ---@field G number
    ---@field B number
    ---@field A number
    ---@field Length number|nil For gradient arrays only
    local __Colors = { }


    ---@class Style
    ---@field Fore Color|Color[]
    ---@field Back Color
    ---@field Border Color|nil
    ---@diagnostic disable-next-line
    ---@field Decoration TextStyles|TitleStyles|nil
    local __Styles = { }


    ---@class Object has multiple fields
    ---@field Type string Template name
    ---@field Params table
    local __Objects = { }


    ---@class Data
    ---@field Value any? The value
    ---@field Active boolean|nil? Display it as active?
    ---@field FuncOn boolean|nil? Run function?
    ---@field PrevClick boolean|nil? In previous tick, was I clicking it? -- for Pulse and Toggle
    local __Datas = { }
end


--- Fast debugging for IDE
---@param a any
function LOG(a)

    if type(a) == "table" then
        for k, v in pairs(a) do
            print(k, v)
        end
    elseif type(a) == "function" then
        print("function", a())
    else
        print(a)
    end
end


---@endsection











--- BASIC FUNCTIONS

---@diagnostic disable

gn = input.getNumber
gb = input.getBool
sn = output.setNumber
sb = output.setBool
---@section pn
pn = property.getNumber
---@endsection
---@section pb
pb = property.getBool
---@endsection
---@section pt
pt = property.getText
---@endsection

---@diagnostic enable


---@section abs
abs = math.abs
---@endsection
---@section floor
floor = math.floor
---@endsection
---@section ceil
ceil = math.ceil
---@endsection
---@section sqrt
sqrt = math.sqrt
---@endsection
---@section rad
rad = math.rad
---@endsection
---@section deg
deg = math.deg
---@endsection
---@section pi
PI = math.pi
---@endsection


---@section sin

--- `math.sin`
---@param a number degrees
---@return number # sin
---@nodiscard
function sin(a)
    return math.sin(rad(a))
end

---@endsection



---@section cos

--- `math.cos`
---@param a number degrees
---@return number # cos
---@nodiscard
function cos(a)
    return math.cos(rad(a))
end

---@endsection



---@section tg

--- `math.tan`
---@param a number degrees
---@return number # tan
---@nodiscard
function tg(a)
    return math.tan(rad(a + 180))
end

---@endsection



---@section asin

--- `math.asin`
---@param n number
---@return number # degrees
---@nodiscard
function asin(n)
    return deg(math.asin(n))
end

---@endsection



---@section acos

--- `math.acos`
---@param n number
---@return number # degrees
---@nodiscard
function acos(n)
    return deg(math.acos(n))
end

---@endsection



---@section atg

--- `math.atan`
---@param n number
---@return number # degrees
---@nodiscard
function atg(n, m)
    return deg(math.atan(n, m))
end

---@endsection



---@section round

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

---@endsection



---@section sign

--- Returns the sign of the number (`1` or `-1`)
---@param n number
---@return number # 1 if `> 0`, -1 if `< 0`
---@nodiscard
function sign(n)
    return n < 0 and -1 or 1
end

---@endsection



---@section avg

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

---@endsection



---@section avgm

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

---@endsection




---@section totable

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

---@endsection



---@section clamp

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

---@endsection



---@section xor

--- Logical XOR
---@param a boolean
---@param b boolean
---@return boolean
---@nodiscard
function xor(a, b)
    return a ~= b
end

---@endsection











--- ADDITIONAL BASIC FUNCTIONS



---@section InSpan

--- Gives information, if the number fits between `min` and `max`
---@param value number
---@param min number|nil? `Default = 0`
---@param max number|nil? `Default = 1`
---@return boolean
---@nodiscard
function InSpan(value, min, max)
    min = min or 0
    max = max or 1

    return value >= min and value <= max
end

---@endsection



---@section ZeroOne

--- Return value translated to the range of `0.0 - 1.0`
---@param min number Minimal value of the `value`
---@param max number Maximal value of the `value`
---@param value number Number between the `min` and `max`
---@return number # value 0-1
---@nodiscard
function ZeroOne(min, max, value)
    return clamp((value - min) / (max - min))
end

---@endsection



---@section sclamp

--- It adds `newChar` to the `str` only, if `str` has a lenght smaller than `maxLen`
---@param maxLen number Maximal acceptable length of the string
---@param str string The base string
---@param newChar string Character to add to `str`
---@return string # A modified string which won't be longer than `maxLen`
---@nodiscard
function sclamp(str, maxLen, newChar)
    return #str + 1 > maxLen and str or str .. newChar
end

---@endsection




---@section PushDict

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

---@endsection



---@section FillPrefix

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

---@endsection



---@section IndexOf

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











--- MONITOR FUNCTIONS



---@type number Width of the monitor
WIDTH = nil
---@type number Height of the monitor
HEIGHT = nil



--- Functionalities for touching (E or Q).
---@see Extensions.Secound Touch for double touch (stouch, E and Q)
---@section Touching



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



---@endsection



---@section TextWidth

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

---@endsection



---@section TextHeight

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



---@section Center

--- Returns a position of the object, so it can be centered in a plane between `x1` and `x2`
--- - Example: `Center(1, 10, 2)` -> 6.5 -- the object will be in the center.
---@param x1 number Left/Top
---@param x2 number Right/Bottom
---@param length number Length of the object
---@return number # Center coordinates
---@nodiscard
function Center(x1, x2, length)
    return avg(x1, x2) - length / 2
end

---@endsection



---@section Center2D

--- Returns a position in the center of the box.
---@param x1 number Point A
---@param y1 number Point A
---@param x2 number Point B
---@param y2 number Point B
---@param width number Width of the object
---@param height number Height of the object
---@return number # Center of X
---@return number # Center of Y
---@nodiscard
function Center2D(x1, y1, x2, y2, width, height)
    return Center(x1, x2, width), Center(y1, y2, height)
end

---@endsection











-- COLORS
--- In RGB(a) format



--- Create a color in RGB(a)
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


---@type Color Transparent
TRANS  = Color(0, 0, 0, 0)
WHITE  = Color(255, 255, 255)
BLACK  = Color()
---@section GREY
GREY   = Color(127, 127, 127)
---@endsection
---@section RED
RED    = Color(255)
---@endsection
---@section ORANGE
ORANGE = Color(255, 127)
---@endsection
---@section YELLOW
YELLOW = Color(255, 255)
---@endsection
---@section CITRUS
CITRUS = Color(127, 255)
---@endsection
---@section GREEN
GREEN  = Color(0, 255)
---@endsection
---@section CYAN
CYAN   = Color(0, 255, 255)
---@endsection
---@section BLUE
BLUE   = Color(0, 0, 255)
---@endsection
---@section PINK
PINK   = Color(255, 0, 255)
---@endsection
---@section PURPLE
PURPLE = Color(127, 0, 255)
---@endsection

---@type Color Color of the foreground
Foreground = WHITE
---@type Color Color of the background
Background = TRANS



---@section SetFore

--- Sets the `Foreground`
---@param color Color
function SetFore(color)
    Foreground = color
end

---@endsection



---@section SetBack

--- Sets the `Background`
---@param color Color
function SetBack(color)
    Background = color
end

---@endsection




--- Sets the current color for `screen.*` functions
---@param color Color|nil? `Default = Foreground`
function SetColor(color)
    color = color or Foreground
    screen.setColor(color.R, color.G, color.B, color.A)     ---@diagnostic disable-line:undefined-global
end



---@section Clear

--- Clears the monitor and fills with other color
---@param toColor Color|nil? `Default = Background`
function Clear(toColor)
    SetColor(toColor or Background)
    screen.drawClear()      ---@diagnostic disable-line:undefined-global
end

---@endsection











--- Custom styling with colors for advanced functions (Text, StyledText, custom Templates ...)
---@section Style



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



---@endsection











---@section DEBUG

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










--- Objects
--- Definition Reminder:
---     Template - type of object with defined (but not set) properties and behaviour (like a class)
---     Object - An instance of Template which has defined and set properties (like object of a class)
---     Spirit - Spawned object on the monitor. "Index and Layers" module will use this term. Here it's not used.



---@type Object[] List of objects (template instances) - can be spawned multiple times later
Objects = { }



---@section PropertiesOf

--- Returns a REFERENCE to the Object. Best for changing or getting properties.
---@param idOrObject number|Object ID of the Object in `Objects` or actual anonymous Object
---@return Object # reference
---@nodiscard
function PropertiesOf(idOrObject)
    if type(idOrObject) == "table" then
        return idOrObject --[[@as Object]]
    end

    return Objects[idOrObject]
end

---@endsection



---@section CopyOf

--- Returns a COPY BY VALUE of the Object. Best for creating an anonymous object (copy) with different properties.
---@param idOrObject number|Object ID of the Object in `Objects` or a reference to the Object
---@return Object # value
---@nodiscard
function CopyOf(idOrObject)
    local result = { }

    if type (idOrObject) == "number" then
        for k, v in pairs(Objects[idOrObject]) do
            if type (v) == "table" then
                local copy = CopyOf(v)
                result[k] = { }
                for i, j in pairs(copy) do
                    result[k][i] = j
                end
            else
                result[k] = v
            end
        end
    else
        for k, v in pairs(idOrObject --[[@as Object]]) do
            result[k] = v
        end
    end

    return result
end

---@endsection





---@type function[] Templates' behaviours and draw-executing
Templates = {
    ---@section "Line"
    ["Line"] = function (x, y, obj)
        SetColor(obj.Color)
        screen.drawLine(x, y, obj.X + x, obj.Y + y)     ---@diagnostic disable-line:undefined-global
    end,
    ---@endsection
    ---@section "TrigLine"
    ["TrigLine"] = function (x, y, obj)
        DrawLine(x, y, obj.R * cos(obj.Angle), obj.R * sin(obj.Angle), obj.Color)
    end,
    ---@endsection
    ---@section "Dot"
    ["Dot"] = function (x, y, obj)
        DrawLine(x, y, 1, 0, obj.Color)
    end,
    ---@endsection
    ---@section "Box"
    ["Box"] = function (x, y, obj)
        SetColor(obj.Style.Back)
        screen.drawRectF(x, y, obj.Width, obj.Height)   ---@diagnostic disable-line:undefined-global
        SetColor(obj.Style.Border or TRANS)
        screen.drawRect(x, y, obj.Width - 1, obj.Height - 1)    ---@diagnostic disable-line:undefined-global
    end,
    ---@endsection
    ---@section "Triangle"
    ["Triangle"] = function (x, y, obj)
        local function coords()
            return obj.Ax + x, obj.Ay + y, obj.Bx + x, obj.By + y, obj.Cx + x, obj.Cy + y
        end

        SetColor(obj.Style.Back)
        screen.drawTriangleF(coords())      ---@diagnostic disable-line:undefined-global
        SetColor(obj.Style.Border or TRANS)
        screen.drawTriangle(coords())       ---@diagnostic disable-line:undefined-global
    end,
    ---@endsection
    ---@section "Circle"
    ["Circle"] = function (x, y, obj)
        SetColor(obj.Style.Back)
        screen.drawCircleF(x, y, obj.R)     ---@diagnostic disable-line:undefined-global
        SetColor(obj.Style.Border or obj.Style.Back) -- it's a better circle when bordered lol
        screen.drawCircle(x, y, obj.R)      ---@diagnostic disable-line:undefined-global
    end,
    ---@endsection
    ---@section "Text"
    ["Text"] = function (x, y, obj)
        SetColor(obj.Color)
        screen.drawText(x, y, obj.Text)     ---@diagnostic disable-line:undefined-global
    end,
    ---@endsection
    ---@section "StyledText"
    ["StyledText"] = function (x, y, obj)
        -- width
        local w = obj.Width

        if not w then
            w = TextWidth(obj.Text)
            w = w + 1
        end

        -- height
        local h, ln

        if obj.Height then
            h = obj.Height
        else
            h, ln = TextHeight(obj.Text, w)
        end


        -- Draw
        -- drawTextBox is little bugged, so I had to this (I think)
        local a, builder, mod = obj.Style.Border and 2 or 0, "", 0
        DrawBox(x, y, w + 1.5 * a - 1, h + 2 * a, obj.Style)

        SetColor(obj.Style.Fore)
        for k, v in pairs(totable(obj.Text)) do
            if v == '\n' then
                screen.drawTextBox(x + a, y + a + mod, w, 5, builder, 0, 0)   ---@diagnostic disable-line:undefined-global
                builder = ""
                mod = mod + 6
            else
                builder = builder .. v
            end
        end

        -- In case if builder isn't empty
        screen.drawTextBox(x + a, y + a + mod, w, h, builder, 0, 0)       ---@diagnostic disable-line:undefined-global

        -- styles
        if obj.Style.Decor == 'u' then

            DrawTrigLine(x, y + h - 2, 0, w, obj.Style.Fore)

        elseif obj.Style.Decor == 's' then

            for i = 1, ln do
                DrawTrigLine(x, y + 2 + 6 * (i - 1), 0, w, obj.Style.Fore)
            end

        end
    end,
    ---@endsection
}



--- Draws an Object. The object can be in `Objects` or can be anonymous.
---@param x number Draw at X
---@param y number Draw at Y
---@param obj number|Object Reference to the object or anonymous Object
---@param id any|nil? Required only for interactives (Buttons etc)
function Draw(x, y, obj, id)
    -- Is anonymous - true is table of an object, false is a reference to the premade object
    if type (obj) == "number" then
        obj = Objects[obj]
    end

    -- Spawn object
    Templates[obj.Type](x, y, obj.Params, id)
end




--- Returns the Object from a Template. It's still not drew, but it has defined properties and it's ready to be put in `Draw()` function
---@param typeof string Name of the Template defined in `Templates`
---@param dict table Table of properties and functions
---@param isAnon boolean|nil? Decides, if it puts the object in `Objects` and returns a reference to it, or return the object itself (anonymous). <br> `Default = false`
---@return number|Object # The anonymous object or number as a reference to the `Objects`
---@nodiscard
function Object(typeof, dict, isAnon)
    local result = {
        Type = typeof,
        Params = { }
    }

    PushDict(result.Params, dict)

    if isAnon then
        return result
    end

    table.insert(Objects, result)
    return #Objects
end











--- OBJECT FUNCTIONS
--- Fast object creatior functions
--- When you will create your own Template, you should include that function too, so it'll be easier your objects.
--- Also, you can put comments, so it's more readable.
--- Include in them the default values.



---@section Line

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

---@endsection



---@section TrigLine

--- Line with using trigonometry.
---@param angle number degrees. 0* -> line going to the right.
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

---@endsection



---@section Dot

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

---@endsection



---@section Box

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

---@endsection



---@section Triangle

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

---@endsection



---@section Circle

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

---@endsection




---@section Text

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

---@endsection



---@section StyledText

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
        Width = width,
        Height = height
    }, isAnon)
end

---@endsection











--- SHORT FUNCTIONS
--- Short functions to draw anonymous objects.
--- If you are creating custom templates - you can also include a short function. Depends on your goal - private projects or contributing to QUI.



---@section DrawLine

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

---@endsection



---@section DrawTrigLine

--- Line with using trigonometry.
---@param x number Start point
---@param y number Start point
---@param angle number degrees. 0* -> line going to the right.
---@param r number Length in pixels
---@param color Color|nil? Color. Gradients are available in "Gradient" module
function DrawTrigLine(x, y, angle, r, color)
    Draw(x, y,
        TrigLine(angle, r, color, true)
    )
end

---@endsection



---@section DrawDot

--- Just a dot, point.
---@param x number Position
---@param y number Position
---@param color Color|nil? Color
function DrawDot(x, y, color)
    Draw(x, y,
        Dot(color, true)
    )
end

---@endsection




---@section DrawBox

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

---@endsection



---@section DrawTriangle

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

---@endsection


---@section DrawCircle

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

---@endsection



---@section DrawText

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

---@endsection



---@section DrawStyledText

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











--- INTERACTIONS
--- You can create your own interactive Templates.
--- You can get some ready interactive Templates, search for modules: Button, HTML Select, Second Interactivity, Slider, Input and CheckBox etc.
---@section _Data 1 __INTERACTIVES__



---@type Data[] List of data and values required for interactive Templates
_Data = { }


---@section GetData

--- Get the value of interactive element
---@param id any ID of interactive data
---@return any
---@nodiscard
function GetData(id)
    if not _Data[id] then return nil end

    return _Data[id].Value
end

---@endsection



---@section SetData

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

---@endsection



---@section ForceData

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




---@endsection INTERACTIVES











--- TIME
---@see Extensions.Time for time managment and functions
---@section Update




--- Updates every tick, at the end of `onTick` function (there you should place this function).<br>
--- Everything that has been added with `AddUpdate` function, will be updated.
---@see Time module. It's required, if you want to use this function
function Update() end



---@endsection











--================= USER ===================

---@see Write your code here or cut it out to your main project's file.




function onTick()
    -- Those should be included at the beginning of onTick function
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