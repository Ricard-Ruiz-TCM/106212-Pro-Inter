
-- Libs
local Vector = Vector or require "lib/vector"

-- Engine
local Actor = Actor or require "src/engine/Actor"

-- Singletons
Video = Video or require "src/engine/Video"

-- Class
local BInter = Actor:extend()
-----------------------------

--[[ Construtor ]]
function BInter:new(x, y, texture, speed, effect)
  -- Super -----------------------------------
  BInter.super.new(self, x, y, texture, speed)
  --------------------------------------------
  
  -- Set de posición arriba de la pantalla
  self.position = Vector.new(math.random(0, Video:width() - self.width), -self.height)
  
  -- Set de efecto
  self.effect = effect or ""
  
  -- Creamos la collision box vacía
  self.cBox = {x = self.position.x, y = self.position.y, w = self.width, h = self.height}
  
  -- Dirección random
  self.scale.x = math.random(-1, 1)
  if (self.scale.x == 0) then self.scale.x = 1 end
  
end

--[[ Update ]]
function BInter:update(dt)
  -- Super --------------------
  BInter.super.update(self, dt)
  -----------------------------
  
  -- Ajuste de velocidad global
  self.speed = math.max(DATA.global.speed, DATA.global.min_speed)
  
  -- Movimiento hacia abajo
  self.position.y = self.position.y + self.speed * dt
  
  -- Destroy (Salimos de pantalla)
  if (self.position.y > Video:height() + (self.height * 2)) then self:destroy() end
  if (self.position.y < -(self.height * 2)) then self:destroy() end
  
end

--[[ Draw ]] --
function BInter:draw()
  -- Super --------------
  BInter.super.draw(self)
  -----------------------  
end

return BInter

-----------------------------------------------------------------