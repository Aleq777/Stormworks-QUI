--- QUI 2
--- Official Extension: Time
--- Author: @Aleq777
---     Introduces time (ticks) management


---@section ToUpdate

---@type function[] List of events to run every tick/update
ToUpdate = { }

---@endsection





---@section AddUpdate

---Adds a new event
---@param func function Function to run
---@return integer # Index of `ToUpdate`
function AddUpdate(func)
    local i = 1

    while true do

        if ToUpdate[i] == nil then

            table.insert(ToUpdate, i, func)
            return i

        end

    end

end

---@endsection




---@section RemoveUpdate

--- Removes an event
---@param index integer Index of `ToUpdate`
function RemoveUpdate(index)
    ToUpdate[index] = nil
end

---@endsection




---@section Update

--- Run this at the end of `onTick` function (or `onDraw`, depends on what you want to achieve)
function Update()
    for k, v in pairs(ToUpdate) do
        v()
    end
end

---@endsection




---@section _constructStopwatch

--- Constructs a new stopwatch
---@param current integer Current lap
---@param time integer[] Laps (ticks)
---@return Stopwatch
---@nodiscard
local function _constructStopwatch(current, time)
    return {
        Current = current,
        Time = time,
        ID = nil
    }
end

---@endsection




---@section _STOPWATCH_ 1 Stopwatch

---@class Stopwatch
---@field Current integer Current lap
---@field Time integer[] Laps (ticks)
---@field ID integer|nil Index in `ToUpdate`
Stopwatch = {


    ---@section New

    --- Creates a new stopwatch
    ---@return Stopwatch
    ---@nodiscard
    New = function ()
        return _constructStopwatch(1, { 0 })
    end,

    ---@endsection




    ---@section Copy

    --- Copies an existing stopwatch
    ---@param stopwatch Stopwatch
    ---@return Stopwatch
    ---@nodiscard
    Copy = function (stopwatch)
        return _constructStopwatch(stopwatch.Current, stopwatch.Time)
    end,

    ---@endsection




    ---@section Start

    --- Starts the stopwatch at current lap
    ---@param self Stopwatch
    Start = function (self)
        self.ID = AddUpdate(function ()
            self.Time[self.Current] = self.Time[self.Current] + 1
        end)
    end,

    ---@endsection






    ---@section Check

    --- Returns current time
    ---@param self Stopwatch
    ---@return integer # Current time
    ---@nodiscard
    Check = function (self)
        return self.Time[self.Current]
    end,

    ---@endsection




    ---@section Compare

    --- Checks, if current time is the same or bigger from provided
    ---@param self Stopwatch
    ---@param time integer Time to compare
    ---@return boolean # True if `time` is bigger or equal actual stopwatch time
    ---@nodiscard
    Compare = function (self, time)
        return self:Check() >= time
    end,

    ---@endsection





    ---@section Stop

    --- Stopts the stopwatch
    ---@param self Stopwatch
    ---@return integer # Current time
    Stop = function (self)
        RemoveUpdate(self.ID)
        self.ID = nil
        return self.Time[self.Current]
    end,

    ---@endsection






    ---@section StopWhen

    --- Stops if the `expression` is true
    --- @param self Stopwatch
    --- @param expression boolean
    --- @return integer|boolean # Current time or `false` if expression is not true
    StopWhen = function (self, expression)
        if expression then
            return self:Stop()
        end

        return false
    end,

    ---@endsection









    ---@section StopAt

    --- Stops, when Stopwatch reaches (or goes through) the provided time
    ---@param self Stopwatch
    ---@param time integer
    ---@return boolean
    StopAt = function (self, time)
        return self:StopWhen(self.Time[self.Current] >= time) ~= false -- return true when stops, false if not
    end,

    ---@endsection





    ---@section Reset

    --- Restarts the stopwatch (including all laps)
    --- @param self Stopwatch
    Reset = function (self)
        self.Time = { 0 }
    end,

    ---@endsection











    ---@section NextLap

    --- Creates a new lap
    --- @param self Stopwatch
    --- @return integer # New-current lap
    NextLap = function (self)
        table.insert(self.Time, 0)
        self.Current = self.Current + 1
        return self.Current
    end,

    ---@endsection









    ---@section CompareLaps

    --- Compares selected laps
    ---@param self Stopwatch
    ---@param a integer Lap A
    ---@param b integer Lap B
    ---@param isAbs boolean Should the result be absolute
    ---@return integer
    ---@nodiscard
    CompareLaps = function (self, a, b, isAbs)
        if self.Current < 2 then
            return self.Time[1]
        end

        local diff = self.Time[a] - self.Time[b]

        return isAbs and abs(diff) or diff
    end,

    ---@endsection








    ---@section GetLapDelta

    --- Gets the difference between actual and previous lap
    ---@param self Stopwatch
    ---@param isAbs boolean Should the result be absolute
    ---@return integer
    ---@nodiscard
    GetLapDelta = function (self, isAbs)
        return self:CompareLaps(self.Current, self.Current - 1, isAbs)
    end,

    ---@endsection






    ---@section CompareFirstLastLap

    --- Compares first and last lap
    ---@param self Stopwatch
    ---@param isAbs boolean Should the result be absolute
    ---@return integer
    ---@nodiscard
    CompareFirstLastLap = function (self, isAbs)
        return self:CompareLaps(1, #self.Time, isAbs)
    end,

    ---@endsection







    ---@section CompareBiggestSmallestLap

    --- Compares the biggest and smallest time lap
    ---@param self Stopwatch
    ---@return integer
    ---@nodiscard
    CompareBiggestSmallestLap = function (self)
        if self.Current < 2 then
            return self.Time[1]
        end

        local smallest, biggest = min(table.unpack(self.Time)), max(table.unpack(self.Time))
        return biggest - smallest
    end

    ---@endsection
}

---@endsection _STOPWATCH_





---@section _constructTimer

--- Constructs a new Timer
---@param time integer Time to count down
---@param finished boolean Has the timer finished
---@return Timer
---@nodiscard
local function _constructTimer(time, finished)
    return {
        Time = time,
        Finished = finished,
        ID = nil
    }
end

---@endsection






---@section _TIMER_ 1 Timer

---@class Timer
---@field Time integer Time to count down
---@field Finished boolean Has the timer finished
---@field ID integer|nil `ToUpdate` index
Timer = {

    ---@section New

    --- Creates a new timer
    ---@return Timer
    ---@nodiscard
    New = function ()
        return _constructTimer(0, false)
    end,

    ---@endsection




    ---@section Copy

    --- Copies the timer
    ---@param timer Timer
    ---@return Timer
    ---@nodiscard
    Copy = function (timer)
        return _constructTimer(timer.Time, timer.Finished)
    end,

    ---@endsection






    ---@section Set

    --- Sets the time to count down
    ---@param self Timer
    ---@param time integer
    Set = function (self, time)
        self.Time = time
    end,

    ---@endsection






    ---@section Start

    --- Starts counting
    ---@param self Timer
    ---@param time integer|nil Time to count down. `Default = time set before`
    Start = function (self, time)
        self.Finished = false
        self.Time = time and time or self.Time

        self.ID = AddUpdate(function ()
            self.Time = self.Time - 1
            self.Finished = self.Time == 0
            if self.Finished then
                RemoveUpdate(self.ID) -- auto destruction
            end
        end)
    end,

    ---@endsection





    ---@section Check

    --- Checks current time
    ---@param self Timer
    ---@return integer
    ---@nodiscard
    Check = function (self)
        return self.Time
    end,

    ---@endsection








    ---@section HasFinished

    --- Checks, if the Timer has finished
    ---@param self Timer
    ---@return boolean
    ---@nodiscard
    HasFinished = function (self)
        return self.Finished
    end,

    ---@endsection








    ---@section ChangeTime

    --- Change the time to count down by `value`
    ---@param self Timer
    ---@param value integer Postivie - adds more, negative - substracts
    ---@return integer # Current time to count down
    ChangeTime = function (self, value)
        self:Set(self.Time + value)
        return self.Time
    end,

    ---@endsection







    ---@section StopWhen

    --- Stops the timer, if the `expression` is true
    ---@param self Timer
    ---@param expression boolean
    ---@return integer|boolean # false if the expression is not true
    StopWhen = function (self, expression)
        if expression then
            RemoveUpdate(self.ID)
            return self.Time
        end

        return false
    end,

    ---@endsection






    ---@section Stop

    --- Stops the timer
    ---@param self Timer
    Stop = function (self)
        self:StopWhen(true)
    end

    ---@endsection
}

---@endsection _TIMER_