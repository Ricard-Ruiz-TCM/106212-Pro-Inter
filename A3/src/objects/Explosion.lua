
-- Libs
local Vector = Vector or require "lib/vector"

-- Engine
local AnimatedActor = AnimatedActor or require "src/Engine/AnimatedActor"

-- Class
local Explosion = AnimatedActor:extend()
-------------------------------------

function Explosion:new(x, y)
  Explosion.super.new(self, x, y, "assets/textures/Meteors/explosion.png", 0, 0, 1, 6, 0.2)
  -----------------------------------------------------------------------------------------
end

function Explosion:update(dt)
  Explosion.super.update(self, dt)
  --------------------------------
  if (self:animFinished()) then self:destroy() end
end

return Explosion
