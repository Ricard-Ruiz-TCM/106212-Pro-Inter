
-- Libs
local Vector = Vector or require "lib/vector"

-- Engine
local AnimatedActor = AnimatedActor or require "src/engine/AnimatedActor"

-- Singletons
Video = Video or require "src/engine/Video"

-- Class
local AInter = AnimatedActor:extend()
-------------------------------------

--[[ Construtor ]]
function AInter:new(x, y, texture, speed, animations, frames, framerate, loop, effect)
  -- Super ------------------------------------------------------------------------
  AInter.super.new(self, x, y, texture, speed, animations, frames, framerate, loop)
  ---------------------------------------------------------------------------------
  
  -- Set de posición arriba de la pantalla
  self.position = Vector.new(math.random(0, Video:width() - self.width / self.total_frames), -self.height / self.total_animations)
  
  -- Set de effecto
  self.effect = effect or ""
  
  -- Creamos la collision box vacía
  self.cBox = {x = self.position.x, y = self.position.y, w = self.width, h = self.height}
  
  -- Dirección random
  self.scale.x = math.random(-1, 1)
  if (self.scale.x == 0) then self.scale.x = 1 end
  
  self.up = false
  
end

--[[ Update ]]
function AInter:update(dt)
  -- Super --------------------
  AInter.super.update(self, dt)
  -----------------------------
  
  -- Ajuste de velocidad global
  if (not self.up) then self.speed = math.max(DATA.global.speed, DATA.global.min_speed) end
  
  -- Movimiento hacia abajo
  self.position.y = self.position.y + self.speed * dt
    
  -- Destroy (Salimos de pantalla)
  if (self.position.y > Video:height() + (self.height / self.total_animations * 5)) then self:destroy() end
  if (self.position.y < -(self.height / self.total_animations * 5)) then self:destroy() end
  
end

--[[ Draw ]] --
function AInter:draw()
  -- Super --------------
  AInter.super.draw(self)
  -----------------------
end

return AInter

-----------------------------------------------------------------