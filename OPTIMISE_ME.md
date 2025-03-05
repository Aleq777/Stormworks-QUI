# I. OPTIMALISATION

There are many ways to optimise your code - in this document you'll read about the basic techniques.

> [!TIP]
> If you know another way to generally optimise code or how to improve a technique written here - write an Issue

# II. SHORTER CODE

## VSC + LifeBoatAPI

When you are using VSC and LifeBoatAPI extension, length of the code won't be a problem.

You will find everything on the [VSC Extension description]()

### Minifying

1. Use `F7` to minify your code
2. Head to `_build/out/release/` and copy the file's content. Paste it into microcontroller's Lua script.

### Redundancy Removal

Official sublibraries of QUI have already implemented Redundancy Removal, so don't worry about that.

If for some reason, you are creating a code that may not be used - use **Redundancy Removal**:
```lua
---@section KeyName
-- code
---@endsection
```

if `KeyName` appears outside `@section`, the code won't be removed. In other case, it's removed after build (`F7`).

> [!TIP]
> Use redundancy removal for every function/feature singly - the LifeBoatAPI will take care of everything.

**Example**
```lua

---@section Foo

function Foo()
    -- a long code
end

---@endsection


---@section Bar

function Bar()
    Foo()
    -- some other code
end

---@endsection


-- Case 1
Bar() -- you are using Bar, Bar uses Foo, so both functions remain

-- Case 2
Foo() -- you are using Foo. Bar is unused. It'll get deleted except the Foo function

-- Case 3
    -- You aren't using any of the functions. Both are removed
```

## Other IDEs

Every IDE can work differently with optimising (shortening) your code. Here are some examples to ensure that your final code will be shorter.

### Minifiers

The first thing you should consider is using minifier. For example, [PonyIDE]()

Length of your variable/function names won't make a difference. Use as many whitespaces as you want. Just copy and paste the minified code.

### Shorter statements

You can rewrite some of your code to be shorter.

<hr>

**Tenary Operator:**<br>
Too long:
```lua
local a
if statement then
    a = 3
else
    a = 0
end

-- Minified
local a
if b then
a=3
else
a=0
end
```

Good:
```lua
local a = statement and 3 or 0

-- Minified
local a=b
and 3
or 0
```

<hr>

**Use less locals:**<br>
Too long:
```lua
local pi = math.pi -- it's in global scope
function Foo()
    local x -- it's in Foo's scope
end

-- Minified
local p=math.pi
function f()local x end
```

Good:
```lua
pi = math.pi -- if you stick to good programming practices, this won't affect your code
function Foo()
    local x -- leave locals in functions etc.
end

-- Minified
p=math.pi
function f()local x end
```

<hr>

**Use less variables:**

> [!WARNING]
> Using many variables is a good practice for readability. So, do this only when you must and only for the output of the project so it'll be still easy to make changes in original project files.

Long:
```lua
function Foo(x, y, z)
    local a, b = x + y, z * 2
    local c = a + b - x - z
    return c - a
end

-- Minified
function f(x,y,z)local a,b=x+y,z*2
local c=a+b-x-z
return c-a
end
```

Short:
```lua
function Foo(x, y, z)
    return z - x
end

-- Minified
function f(x,y,z)return z-x
end
```

# III. FASTER CODE

If your code gets timeout, consider those options:

## Loops

### onTick and onDraw

Use less loops if possibile. Functions `onTick` and `onDraw` are already functioning like loops, so if possible - don't use `for` and `while` loops.

### break statement

If your loops search for a specific element, you should add a `break` statement:

**Wrong:**
```lua
function At(theTable, index)
    local result
    for k, v in pairs(theTable) do
        if k == index and not result then
            result = v
        end
    end

    return result
end
```

**Right:**
```lua
-- #1
function At(theTable, index)
    local result
    for k, v in pairs(theTable) do
        if k == index then
            result = v
            break
        end
    end

    return result
end

-- #2
function At(theTable, index)
    for k, v in pairs(theTable) do
        if k == index then
            return v
        end
    end
end
```

### Aliases

Lua is an interpreted language - so it reads every instruction and executes them separately, even if it's repeated. When you have, for example, `math.sin` function - Lua searches `math` table for `sin` function.

You can shorten the process:
```lua
sin = math.sin -- the alias
for ... do
    sin(1) -- It's faster
end
```

### Infinite loops

Sometimes, you need to use loops that don't have specified end statement (like `while true`). Search and test, if the loop gets stopped properly.

Error:
```lua
local num = 0
while num >= 0 do
    -- do something
    num = num + 1 -- num is increased. Always, num will be greater or equal 0
end
```

Good:
```lua
while true do
local num = 0
while num >= 0 do
    -- do something
    num = num - 1 -- now, at some point the loop will be breaked. In this case, after the first iteration.
end
```