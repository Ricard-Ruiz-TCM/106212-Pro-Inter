-----------------------------------------------------------------
-- //////////////////////////////////////////////////////// TIMER
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"

-- Class
local Timer = Object:extend()
-----------------------------

--[[ Constructor
  @param time   -> Tiempo del timer
  @param method -> Método a ejectuar al acabar
  @param loop   -> Repetición
--]]
function Timer:new(time, method, loop)
  self.active = true
  self.time = time or 0
  self.base_time = self.time
  self.loop = loop or false
  self.method = method or (function() end)
end

--[[ Update
  @param dt -> Delta Time de cada frame
--]]
function Timer:update(dt)
  if (self.active) then self.time = self.time - dt
    if (self.time < 0) then self.method()
      if (self.loop) then self:reload()
      else self.active = false end
    end
  end
end

--[[ Reload ]]
function Timer:reload()
  self.active = true
  self.time = self.base_time
end

--[[ Activo?
  @return -> (true -> activo | false -> innactivo)
--]]
function Timer:isActive()
  return self.active
end

return Timer

-----------------------------------------------------------------