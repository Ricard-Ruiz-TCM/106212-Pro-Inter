-----------------------------------------------------------------
-- //////////////////////////////////////////////////////// TIMER
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"

-- Class
local Timer = Object:extend()
-----------------------------

function Timer:new()
  self.time = 0
  self.pause = true
end

function Timer:update(dt)
  if (self.pause == false) then
    self.time = self.time + dt
  end
end

function Timer:draw()
end

function Timer:reload()
  self.time = 0
  self.pause = true
end

function Timer:restart()
  self:reload()
  self:start()
end

function Timer:start()
  self.pause = false
end

function Timer:stop()
  self:reload()
end

function Timer:pause()
  self.pause = true
end

function Timer:isPuased()
  return self.pause
end

function Timer:isStoped()
  return self:isPaused()
end

return Timer

-----------------------------------------------------------------