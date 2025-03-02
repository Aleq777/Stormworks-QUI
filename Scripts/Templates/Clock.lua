--- QUI 2
--- Official Template: Clock
--- Author: @Aleq777
--- Includes:
---     Clock - Simple digital clock in multiple formats like 12h/24h, hh:mm, mm:ss:ms, stopwatch
---@module 'Base' REQUIRED



---@see OPTIMISE_ME.md
PushDict(Templates, {
    -- REWORK !!!
    ["Clock"] = function (x, y, obj)
        -- mode depends
    end
})



-- REWORK !!! - time (12/24), stopwatch
---@alias ClockType
---| 0 # Hour:Minute - 00:00 - 12:59
---| 1 # Hour:Minute:Second - 00:00:00 - 12:59:59
---| 2 # [24] Hour:Minute - 00:00 - 24:59
---| 3 # [24] Hour:Minute:Second - 00:00:00 - 24:59:59
---| 4 # [Stopwatch] Minute:Second - 00:00 - 99:59
---| 5 # [Stopwatch] Minute:Second:Milisecond - 00:00.000 - 99:59.999
---| 6 # [Stopwatch] Hour:Minute:Second - 00:00:00 - 99:59:59


--- Simple digital clock
---@param timeMS integer Time in miliseconds (1h = 3.600.000)
---@param mode ClockType
---@param style Style
---@param isAnon boolean|nil?
---@return number|Object
---@nodiscard
function Clock(timeMS, mode, style, isAnon)
    return Object("Clock", {
        Time = timeMS,
        Mode = mode,
        Style = style
    }, isAnon)
end


-- REWORK !!!
--- Draw a simple digital clock
---@param x number Position
---@param y number Position
---@param timeMS integer Time in miliseconds (1h = 3.600.000)
---@param mode ClockType
---@param style Style
function DrawClock(x, y, timeMS, mode, style)
    Draw(x, y,
        Clock(timeMS, mode, style, true)
    )
end