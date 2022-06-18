-----------------------------------------------------------------
-- //////////////////////////////////////////////////////// ACTOR
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"
local Vector = Vector or require "lib/vector"

-- Engine
local Entity = Entity or require "src/engine/Entity"

-- Class
local Actor = Entity:extend()
-----------------------------

--[[ Constructor
  @param x       -> Posición X de la pantalla
  @param y       -> Posición Y de la pantalla
  @param texture -> Path de la textura
  @param speed   -> Velocidad del actor
--]]
function Actor:new(x, y, texture, speed)
  -- Super ------------------
  Actor.super.new(self, x, y)
  ---------------------------
  self:setTexture(texture)
  self.speed = speed or 0
  self.base_speed = self.speed
end

--[[ Reload ]]
function Actor:reload()
  -- Super ---------------
  Actor.super.reload(self)
  ------------------------
  self.speed = self.base_speed
end

return Actor

-----------------------------------------------------------------